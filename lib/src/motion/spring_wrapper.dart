import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'motion_adaptive.dart';
import 'motion_tokens.dart';

/// A wrapper around [AnimationController] to facilitate spring animations.

///
/// Example usage:
/// ```dart
/// final controller = AnimationController(vsync: this);
/// final springAnim = SpringAnimation(controller);
///
/// // Animate to target 1.0 using a specific spring description
/// springAnim.animateTo(
///   1.0,
///   MotionTokens.expressiveDefaultSpatial,
/// );
/// ```
class SpringAnimation {
  final AnimationController controller;
  double? _target;

  SpringAnimation(this.controller);

  /// Animates the controller to [target] using the provided [spring].
  ///
  /// If [velocity] is not provided, the current velocity of the controller is used
  /// to ensure smooth transitions (handling retargeting/interruption).
  ///
  /// If [reduceMotion] is true, the animation completes instantly.
  TickerFuture animateTo(
    double target,
    SpringDescription spring, {
    double? velocity,
    bool reduceMotion = false,
  }) {
    _target = target;

    // If reduced motion is requested, jump to target instantly
    if (reduceMotion) {
      controller.value = target;
      return TickerFuture.complete();
    }

    final simulation = SpringSimulation(
      spring,
      controller.value,
      target,
      velocity ?? controller.velocity,
    );
    return controller.animateWith(simulation);
  }

  /// Retargets the in-flight animation with new spring parameters.
  /// Preserves current value, velocity, and target for instant switching.
  void retarget(SpringDescription newSpring, {bool reduceMotion = false}) {
    if (_target != null) {
      if (reduceMotion) {
        controller.value = _target!;
        return;
      }
      controller.animateWith(
        SpringSimulation(
          newSpring,
          controller.value,
          _target!,
          controller.velocity,
        ),
      );
    }
  }
}

/// A widget that builds its child using a spring animation.
///
/// Replaces the standard [AnimatedBuilder] usage when simple spring-based
/// transition to a target value is needed.
///
/// Automatically respects platform "Reduce Motion" accessibility settings.
/// When reduced motion is enabled, animations complete instantly.
class SpringBuilder extends StatefulWidget {
  final double value;
  final SpringDescription spring;
  final Widget Function(BuildContext context, double value, Widget? child)
  builder;
  final Widget? child;

  /// If true, ignores platform reduce motion setting.
  /// Use sparingly - only for essential motion that conveys meaning.
  final bool ignoreReduceMotion;

  const SpringBuilder({
    super.key,
    required this.value,
    required this.spring,
    required this.builder,
    this.child,
    this.ignoreReduceMotion = false,
  });

  @override
  State<SpringBuilder> createState() => _SpringBuilderState();
}

class _SpringBuilderState extends State<SpringBuilder>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late SpringAnimation _springAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, value: widget.value);
    _springAnim = SpringAnimation(_controller);
  }

  @override
  void didUpdateWidget(SpringBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Check if we should reduce motion
    final reduceMotion =
        !widget.ignoreReduceMotion &&
        MotionAdaptive.shouldReduceMotion(context);

    if (oldWidget.value != widget.value) {
      // Use reduced motion spring if platform requests it
      final spring = reduceMotion ? MotionTokens.reducedMotion : widget.spring;
      _springAnim.animateTo(widget.value, spring, reduceMotion: reduceMotion);
    } else if (oldWidget.spring != widget.spring) {
      final spring = reduceMotion ? MotionTokens.reducedMotion : widget.spring;
      _springAnim.retarget(spring, reduceMotion: reduceMotion);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) =>
          widget.builder(context, _controller.value, child),
      child: widget.child,
    );
  }
}

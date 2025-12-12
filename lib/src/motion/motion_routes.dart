import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'motion_tokens.dart';

/// A [PageRoute] that uses real spring physics for transitions.
///
/// Unlike the default page routes that use curve-based animations,
/// this route uses [SpringSimulation] for physically-accurate motion.
/// The spring characteristics can be customized via the [spring] parameter.
class SpringPageRoute<T> extends PageRoute<T> {
  final WidgetBuilder builder;
  final SpringDescription spring;

  /// The animation controller managed by this route.
  /// We manage it ourselves to use spring physics.
  AnimationController? _controller;

  SpringPageRoute({
    required this.builder,
    this.spring = MotionTokens.expressiveSlowSpatial,
    super.settings,
    super.fullscreenDialog,
  });

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  bool get opaque => true;

  @override
  bool get maintainState => true;

  /// Duration is an estimate for the spring to settle.
  /// Spring animations don't have a fixed duration, but we need to provide
  /// a value for the framework. This is a reasonable upper bound.
  @override
  Duration get transitionDuration => const Duration(milliseconds: 650);

  @override
  Duration get reverseTransitionDuration => const Duration(milliseconds: 500);

  @override
  AnimationController createAnimationController() {
    assert(_controller == null);
    _controller = AnimationController.unbounded(
      vsync: navigator!,
      debugLabel: 'SpringPageRoute',
    );
    return _controller!;
  }

  @override
  TickerFuture didPush() {
    // Use spring simulation for forward animation
    final simulation = SpringSimulation(spring, 0.0, 1.0, 0.0);
    _controller!.animateWith(simulation);
    return super.didPush();
  }

  @override
  bool didPop(T? result) {
    // Use spring simulation for reverse animation
    final simulation = SpringSimulation(spring, 1.0, 0.0, 0.0);
    _controller!.animateWith(simulation);
    return super.didPop(result);
  }

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return builder(context);
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    // Combine slide and fade for natural spring motion feel
    final slideIn = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(animation);

    final slideOut = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-0.3, 0.0), // Subtle parallax for outgoing page
    ).animate(secondaryAnimation);

    // Fade for polish
    final fade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animation,
        curve: const Interval(0.0, 0.5), // Fade in quickly
      ),
    );

    return SlideTransition(
      position: slideOut,
      child: SlideTransition(
        position: slideIn,
        child: FadeTransition(opacity: fade, child: child),
      ),
    );
  }
}

/// A [DialogRoute] that uses spring-driven animations.
///
/// For dialogs, we provide the spring to the transition animation controller
/// so the dialog opening/closing uses spring physics.
class SpringDialogRoute<T> extends DialogRoute<T> {
  final SpringDescription spring;
  AnimationController? _springController;

  SpringDialogRoute({
    required super.context,
    required super.builder,
    this.spring = MotionTokens.expressiveSlowSpatial,
    super.themes,
    super.barrierColor,
    super.barrierDismissible,
    super.barrierLabel,
    super.useSafeArea,
    super.settings,
    super.anchorPoint,
    super.traversalEdgeBehavior,
  });

  @override
  Duration get transitionDuration => const Duration(milliseconds: 650);

  @override
  AnimationController createAnimationController() {
    _springController = AnimationController.unbounded(
      vsync: navigator!,
      debugLabel: 'SpringDialogRoute',
    );
    return _springController!;
  }

  @override
  TickerFuture didPush() {
    final simulation = SpringSimulation(spring, 0.0, 1.0, 0.0);
    _springController!.animateWith(simulation);
    return super.didPush();
  }

  @override
  bool didPop(T? result) {
    final simulation = SpringSimulation(spring, 1.0, 0.0, 0.0);
    _springController!.animateWith(simulation);
    return super.didPop(result);
  }
}

/// A [ModalBottomSheetRoute] that uses spring-driven animations.
///
/// Uses [transitionAnimationController] to inject spring physics
/// into the bottom sheet's slide animation.
class SpringModalBottomSheetRoute<T> extends ModalBottomSheetRoute<T> {
  final SpringDescription spring;

  SpringModalBottomSheetRoute({
    required super.builder,
    required super.isScrollControlled,
    required TickerProvider vsync,
    this.spring = MotionTokens.expressiveSlowSpatial,
    super.barrierLabel,
    super.modalBarrierColor,
    super.enableDrag,
    super.showDragHandle,
    super.useSafeArea,
    super.anchorPoint,
    super.constraints,
    super.sheetAnimationStyle,
  }) : super(
         transitionAnimationController: AnimationController.unbounded(
           vsync: vsync,
           debugLabel: 'SpringModalBottomSheetRoute',
         ),
       );

  @override
  Duration get transitionDuration => const Duration(milliseconds: 650);

  @override
  TickerFuture didPush() {
    if (transitionAnimationController != null) {
      final simulation = SpringSimulation(spring, 0.0, 1.0, 0.0);
      transitionAnimationController!.animateWith(simulation);
    }
    return super.didPush();
  }

  @override
  bool didPop(T? result) {
    if (transitionAnimationController != null) {
      final simulation = SpringSimulation(spring, 1.0, 0.0, 0.0);
      transitionAnimationController!.animateWith(simulation);
    }
    return super.didPop(result);
  }
}

/// Helper function to push a route with spring physics.
Future<T?> pushSpringRoute<T>(
  BuildContext context,
  WidgetBuilder builder, {
  SpringDescription spring = MotionTokens.expressiveSlowSpatial,
  RouteSettings? settings,
  bool fullscreenDialog = false,
}) {
  return Navigator.of(context).push<T>(
    SpringPageRoute<T>(
      builder: builder,
      spring: spring,
      settings: settings,
      fullscreenDialog: fullscreenDialog,
    ),
  );
}

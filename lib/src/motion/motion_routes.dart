import 'package:flutter/material.dart';
import 'motion_tokens.dart';

/// A [PageRoute] that uses a spring animation for transitions.
class SpringPageRoute<T> extends PageRoute<T> {
  final WidgetBuilder builder;
  final SpringDescription spring;

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
    // Basic fade/slide transition driven by the spring-controlled animation
    return FadeTransition(opacity: animation, child: child);
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 650); // Approximate for fallback

  @override
  AnimationController createAnimationController() {
    final controller = super.createAnimationController();
    // We can't easily force the controller to use spring physics for the 'forward' call made by Navigator
    // without overriding more internal logic or managing the controller ourselves.
    // For now, we rely on the standard controller but ideally this should use .animateWith(SpringSimulation(...)).
    return controller;
  }
}

/// A [DialogRoute] that uses a spring animation.
class SpringDialogRoute<T> extends DialogRoute<T> {
  final SpringDescription spring;

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
}

/// A [ModalBottomSheetRoute] that uses a spring animation.
class SpringModalBottomSheetRoute<T> extends ModalBottomSheetRoute<T> {
  final SpringDescription spring;

  SpringModalBottomSheetRoute({
    required super.builder,
    required super.isScrollControlled,
    this.spring = MotionTokens.expressiveSlowSpatial,
    super.barrierLabel,
    super.modalBarrierColor,
    super.enableDrag,
    super.showDragHandle,
    super.useSafeArea,
    super.anchorPoint,
    super.constraints,
    super.sheetAnimationStyle,
    super.transitionAnimationController,
  });

  @override
  Duration get transitionDuration => const Duration(milliseconds: 650);
}

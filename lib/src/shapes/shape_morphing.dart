import 'package:flutter/material.dart';

/// A widget that implicitly animates between [ShapeBorder]s.
class ShapeMorphTransition extends ImplicitlyAnimatedWidget {
  /// Creates a shape morph transition.
  const ShapeMorphTransition({
    super.key,
    required this.shape,
    required this.child,
    super.curve = Curves.linear,
    super.duration = const Duration(milliseconds: 300),
    super.onEnd,
  });

  /// The target shape.
  final ShapeBorder shape;

  /// The widget below this widget in the tree.
  final Widget child;

  @override
  ImplicitlyAnimatedWidgetState<ShapeMorphTransition> createState() =>
      _ShapeMorphTransitionState();
}

class _ShapeMorphTransitionState
    extends ImplicitlyAnimatedWidgetState<ShapeMorphTransition> {
  ShapeBorderTween? _shape;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _shape =
        visitor(
              _shape,
              widget.shape,
              (dynamic value) => ShapeBorderTween(begin: value as ShapeBorder),
            )
            as ShapeBorderTween?;
  }

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: ShapeBorderClipper(
        shape: _shape?.evaluate(animation) ?? widget.shape,
        textDirection: Directionality.maybeOf(context),
      ),
      child: widget.child,
    );
  }
}

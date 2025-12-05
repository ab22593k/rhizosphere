import 'package:flutter/material.dart';
import 'corner_style.dart';
import 'corner_radius.dart';

/// A rounded rectangle border that uses [CornerStyle] tokens.
class TokenRoundedRectangleBorder extends OutlinedBorder {
  const TokenRoundedRectangleBorder({
    super.side = BorderSide.none,
    this.topStart = CornerStyle.none,
    this.topEnd = CornerStyle.none,
    this.bottomStart = CornerStyle.none,
    this.bottomEnd = CornerStyle.none,
  });

  /// The corner style for the top-start corner.
  final CornerStyle topStart;

  /// The corner style for the top-end corner.
  final CornerStyle topEnd;

  /// The corner style for the bottom-start corner.
  final CornerStyle bottomStart;

  /// The corner style for the bottom-end corner.
  final CornerStyle bottomEnd;

  @override
  TokenRoundedRectangleBorder copyWith({
    BorderSide? side,
    CornerStyle? topStart,
    CornerStyle? topEnd,
    CornerStyle? bottomStart,
    CornerStyle? bottomEnd,
  }) {
    return TokenRoundedRectangleBorder(
      side: side ?? this.side,
      topStart: topStart ?? this.topStart,
      topEnd: topEnd ?? this.topEnd,
      bottomStart: bottomStart ?? this.bottomStart,
      bottomEnd: bottomEnd ?? this.bottomEnd,
    );
  }

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(side.width);

  @override
  ShapeBorder scale(double t) {
    return TokenRoundedRectangleBorder(
      side: side.scale(t),
      topStart: topStart,
      topEnd: topEnd,
      bottomStart: bottomStart,
      bottomEnd: bottomEnd,
    );
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return _getPath(rect, textDirection: textDirection, inner: true);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return _getPath(rect, textDirection: textDirection, inner: false);
  }

  Path _getPath(
    Rect rect, {
    TextDirection? textDirection,
    required bool inner,
  }) {
    final radiusTopStart = CornerRadius.getValue(topStart);
    final radiusTopEnd = CornerRadius.getValue(topEnd);
    final radiusBottomStart = CornerRadius.getValue(bottomStart);
    final radiusBottomEnd = CornerRadius.getValue(bottomEnd);

    final radii = BorderRadiusDirectional.only(
      topStart: Radius.circular(radiusTopStart),
      topEnd: Radius.circular(radiusTopEnd),
      bottomStart: Radius.circular(radiusBottomStart),
      bottomEnd: Radius.circular(radiusBottomEnd),
    ).resolve(textDirection ?? TextDirection.ltr);

    if (inner) {
      return Path()..addRRect(radii.toRRect(rect).deflate(side.width));
    }
    return Path()..addRRect(radii.toRRect(rect));
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    if (side.style == BorderStyle.none) return;

    final path = getOuterPath(rect, textDirection: textDirection);
    final paint = side.toPaint();
    canvas.drawPath(path, paint);
  }

  @override
  ShapeBorder? lerpFrom(ShapeBorder? a, double t) {
    if (a is TokenRoundedRectangleBorder) {
      return TokenRoundedRectangleBorder(
        side: BorderSide.lerp(a.side, side, t),
        topStart: t < 0.5 ? a.topStart : topStart,
        topEnd: t < 0.5 ? a.topEnd : topEnd,
        bottomStart: t < 0.5 ? a.bottomStart : bottomStart,
        bottomEnd: t < 0.5 ? a.bottomEnd : bottomEnd,
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  ShapeBorder? lerpTo(ShapeBorder? b, double t) {
    if (b is TokenRoundedRectangleBorder) {
      return TokenRoundedRectangleBorder(
        side: BorderSide.lerp(side, b.side, t),
        topStart: t < 0.5 ? topStart : b.topStart,
        topEnd: t < 0.5 ? topEnd : b.topEnd,
        bottomStart: t < 0.5 ? bottomStart : b.bottomStart,
        bottomEnd: t < 0.5 ? bottomEnd : b.bottomEnd,
      );
    }
    return super.lerpTo(b, t);
  }
}

/// A cut corner border that uses [CornerStyle] tokens.
class TokenCutCornerBorder extends OutlinedBorder {
  const TokenCutCornerBorder({
    super.side = BorderSide.none,
    this.topStart = CornerStyle.none,
    this.topEnd = CornerStyle.none,
    this.bottomStart = CornerStyle.none,
    this.bottomEnd = CornerStyle.none,
  });

  final CornerStyle topStart;
  final CornerStyle topEnd;
  final CornerStyle bottomStart;
  final CornerStyle bottomEnd;

  @override
  TokenCutCornerBorder copyWith({
    BorderSide? side,
    CornerStyle? topStart,
    CornerStyle? topEnd,
    CornerStyle? bottomStart,
    CornerStyle? bottomEnd,
  }) {
    return TokenCutCornerBorder(
      side: side ?? this.side,
      topStart: topStart ?? this.topStart,
      topEnd: topEnd ?? this.topEnd,
      bottomStart: bottomStart ?? this.bottomStart,
      bottomEnd: bottomEnd ?? this.bottomEnd,
    );
  }

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(side.width);

  @override
  ShapeBorder scale(double t) {
    return TokenCutCornerBorder(
      side: side.scale(t),
      topStart: topStart,
      topEnd: topEnd,
      bottomStart: bottomStart,
      bottomEnd: bottomEnd,
    );
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return _getPath(rect, textDirection: textDirection, inner: true);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return _getPath(rect, textDirection: textDirection, inner: false);
  }

  Path _getPath(
    Rect rect, {
    TextDirection? textDirection,
    required bool inner,
  }) {
    final isRtl = textDirection == TextDirection.rtl;

    final radiusTopLeft = CornerRadius.getValue(isRtl ? topEnd : topStart);
    final radiusTopRight = CornerRadius.getValue(isRtl ? topStart : topEnd);
    final radiusBottomLeft = CornerRadius.getValue(
      isRtl ? bottomEnd : bottomStart,
    );
    final radiusBottomRight = CornerRadius.getValue(
      isRtl ? bottomStart : bottomEnd,
    );

    // Simplified cut corner logic for MVP
    // A robust implementation would handle RTL and complex path construction
    final path = Path();
    final offset = inner ? side.width : 0.0;

    // Top Left
    path.moveTo(rect.left + offset, rect.top + radiusTopLeft + offset);
    path.lineTo(rect.left + radiusTopLeft + offset, rect.top + offset);

    // Top Right
    path.lineTo(rect.right - radiusTopRight - offset, rect.top + offset);
    path.lineTo(rect.right - offset, rect.top + radiusTopRight + offset);

    // Bottom Right
    path.lineTo(rect.right - offset, rect.bottom - radiusBottomRight - offset);
    path.lineTo(rect.right - radiusBottomRight - offset, rect.bottom - offset);

    // Bottom Left
    path.lineTo(rect.left + radiusBottomLeft + offset, rect.bottom - offset);
    path.lineTo(rect.left + offset, rect.bottom - radiusBottomLeft - offset);

    path.close();
    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    if (side.style == BorderStyle.none) return;
    final path = getOuterPath(rect, textDirection: textDirection);
    canvas.drawPath(path, side.toPaint());
  }

  @override
  ShapeBorder? lerpFrom(ShapeBorder? a, double t) {
    if (a is TokenCutCornerBorder) {
      return TokenCutCornerBorder(
        side: BorderSide.lerp(a.side, side, t),
        topStart: t < 0.5 ? a.topStart : topStart,
        topEnd: t < 0.5 ? a.topEnd : topEnd,
        bottomStart: t < 0.5 ? a.bottomStart : bottomStart,
        bottomEnd: t < 0.5 ? a.bottomEnd : bottomEnd,
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  ShapeBorder? lerpTo(ShapeBorder? b, double t) {
    if (b is TokenCutCornerBorder) {
      return TokenCutCornerBorder(
        side: BorderSide.lerp(side, b.side, t),
        topStart: t < 0.5 ? topStart : b.topStart,
        topEnd: t < 0.5 ? topEnd : b.topEnd,
        bottomStart: t < 0.5 ? bottomStart : b.bottomStart,
        bottomEnd: t < 0.5 ? bottomEnd : b.bottomEnd,
      );
    }
    return super.lerpTo(b, t);
  }
}

/// A stadium border that uses [CornerStyle] tokens.
class TokenStadiumBorder extends OutlinedBorder {
  const TokenStadiumBorder({super.side = BorderSide.none});

  @override
  TokenStadiumBorder copyWith({BorderSide? side}) {
    return TokenStadiumBorder(side: side ?? this.side);
  }

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(side.width);

  @override
  ShapeBorder scale(double t) => TokenStadiumBorder(side: side.scale(t));

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    final radius = Radius.circular(rect.shortestSide / 2.0);
    return Path()
      ..addRRect(RRect.fromRectAndRadius(rect, radius).deflate(side.width));
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final radius = Radius.circular(rect.shortestSide / 2.0);
    return Path()..addRRect(RRect.fromRectAndRadius(rect, radius));
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    if (side.style == BorderStyle.none) return;
    final path = getOuterPath(rect, textDirection: textDirection);
    canvas.drawPath(path, side.toPaint());
  }

  @override
  ShapeBorder? lerpFrom(ShapeBorder? a, double t) {
    if (a is TokenStadiumBorder) {
      return TokenStadiumBorder(side: BorderSide.lerp(a.side, side, t));
    }
    return super.lerpFrom(a, t);
  }

  @override
  ShapeBorder? lerpTo(ShapeBorder? b, double t) {
    if (b is TokenStadiumBorder) {
      return TokenStadiumBorder(side: BorderSide.lerp(side, b.side, t));
    }
    return super.lerpTo(b, t);
  }
}

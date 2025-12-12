import 'package:flutter/material.dart';

import '../utils/contrast_checker.dart';
import '../utils/truncation_handler.dart';

class AccessibleText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final int? maxLines;
  final TextScaler? textScaler;
  final Widget? overflowWidget;
  final TextAlign? textAlign;
  final Color? backgroundColor;

  const AccessibleText({
    super.key,
    required this.text,
    this.style,
    this.maxLines,
    this.textScaler,
    this.overflowWidget,
    this.textAlign,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveScaler = textScaler ?? MediaQuery.textScalerOf(context);
    final theme = Theme.of(context);
    final effectiveStyle = style ?? theme.textTheme.bodyMedium!;

    // Contrast Check in Debug Mode
    assert(() {
      if (backgroundColor != null && effectiveStyle.color != null) {
        final ratio = ContrastChecker.calculateContrastRatio(
          effectiveStyle.color!,
          backgroundColor!,
        );
        final fontSize = effectiveStyle.fontSize ?? 14.0;
        final isBold = effectiveStyle.fontWeight == FontWeight.bold;
        if (!ContrastChecker.meetsWcagAA(
          ratio,
          fontSize: fontSize,
          isBold: isBold,
        )) {
          debugPrint(
            'Accessibility Warning: Text contrast ratio $ratio does not meet WCAG AA.',
          );
        }
      }
      return true;
    }());

    if (maxLines != null && overflowWidget == null) {
      // Automatically use TruncationHandler if maxLines is set but no custom overflow widget
      return TruncationHandler(
        text: text,
        style: effectiveStyle,
        maxLines: maxLines!,
        maxWidth: double.infinity, // Will be constrained by parent
      );
    }

    if (overflowWidget != null) {
      return overflowWidget!;
    }

    return Text(
      text,
      style: effectiveStyle,
      textAlign: textAlign,
      textScaler: effectiveScaler,
    );
  }
}

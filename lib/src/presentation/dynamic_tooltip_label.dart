import 'package:flutter/material.dart';

import 'utils/accessibility_extensions.dart';

class DynamicTooltipLabel extends StatelessWidget {
  final String text;
  final String? tooltipText;
  final bool truncationEnabled;
  final double? maxWidth;
  final Duration longPressDuration;
  final Duration tooltipWaitDuration;
  final TextStyle? style;

  const DynamicTooltipLabel({
    super.key,
    required this.text,
    this.tooltipText,
    this.truncationEnabled = true,
    this.maxWidth,
    this.longPressDuration = const Duration(milliseconds: 500),
    this.tooltipWaitDuration = const Duration(milliseconds: 150),
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final effectiveMaxWidth = maxWidth ?? constraints.maxWidth;

        // Check if text exceeds max width using TextPainter
        final span = TextSpan(text: text, style: style);
        final tp = TextPainter(
          text: span,
          maxLines: 1,
          textDirection: Directionality.of(context),
        );

        // We need infinity for layout width to measure intrinsic width
        tp.layout(maxWidth: double.infinity);
        final exceedsWidth = tp.width > effectiveMaxWidth;

        if (truncationEnabled && exceedsWidth) {
          return Tooltip(
            message: tooltipText ?? text,
            triggerMode: TooltipTriggerMode.longPress,
            waitDuration: tooltipWaitDuration,
            textStyle: style?.scaled(
              context,
            ), // Use scaled text style in tooltip
            child: SizedBox(
              width: effectiveMaxWidth,
              child: Text(
                text,
                style: style,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          );
        }

        return Text(text, style: style);
      },
    );
  }
}

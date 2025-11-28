import 'package:flutter/material.dart';

class TruncationHandler extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final int maxLines;
  final double maxWidth;

  const TruncationHandler({
    super.key,
    required this.text,
    required this.maxWidth,
    this.style,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final span = TextSpan(text: text, style: style);
        final tp = TextPainter(
          text: span,
          maxLines: maxLines,
          textDirection: Directionality.of(context),
        );
        tp.layout(maxWidth: constraints.maxWidth);

        if (tp.didExceedMaxLines) {
          return Tooltip(
            message: text,
            triggerMode: TooltipTriggerMode.longPress,
            child: Text(
              text,
              style: style,
              maxLines: maxLines,
              overflow: TextOverflow.ellipsis,
            ),
          );
        } else {
          return Text(text, style: style);
        }
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:rhizosphere/accessible_widgets/accessible_text.dart';

class ExpandableTruncatedText extends StatefulWidget {
  final String text;
  final int maxLines;
  final bool expanded;
  final String expandText;
  final String collapseText;
  final Duration animationDuration;
  final TextStyle? style;

  const ExpandableTruncatedText({
    super.key,
    required this.text,
    this.maxLines = 2,
    this.expanded = false,
    this.expandText = '...more',
    this.collapseText = '...less',
    this.animationDuration = const Duration(milliseconds: 200),
    this.style,
  });

  @override
  State<ExpandableTruncatedText> createState() =>
      _ExpandableTruncatedTextState();
}

class _ExpandableTruncatedTextState extends State<ExpandableTruncatedText> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.expanded;
  }

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedSize(
          duration: widget.animationDuration,
          child: AccessibleText(
            text: widget.text,
            style: widget.style,
            maxLines: _isExpanded ? null : widget.maxLines,
          ),
        ),
        GestureDetector(
          onTap: _toggleExpansion,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Text(
              _isExpanded ? widget.collapseText : widget.expandText,
              style: (widget.style ?? Theme.of(context).textTheme.bodyMedium)
                  ?.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}

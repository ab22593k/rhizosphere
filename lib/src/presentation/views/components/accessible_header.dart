import 'package:flutter/material.dart';

class AccessibleHeader extends StatelessWidget {
  final String text;
  final int
  level; // 1 for main, 2 for section, etc. (Semantics usually just cares if it is a header)

  const AccessibleHeader({super.key, required this.text, this.level = 1})
    : assert(text.length > 0, 'Header text cannot be empty');

  @override
  Widget build(BuildContext context) {
    // Validate word count (max 4 words for scannability)
    assert(() {
      final wordCount = text.trim().split(RegExp(r'\s+')).length;
      if (wordCount > 4) {
        throw AssertionError(
          'AccessibleHeader text "$text" has $wordCount words. '
          'Scannable headings must be 4 words or fewer.',
        );
      }
      return true;
    }());

    final style = level == 1
        ? Theme.of(context).textTheme.headlineMedium
        : Theme.of(context).textTheme.titleLarge;

    return Semantics(
      header: true,
      // Explicitly set the label to ensure the header itself identifies as the text
      label: text,
      // Exclude semantics of the child Text widget to avoid duplication
      excludeSemantics: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
        child: Text(text, style: style?.copyWith(fontWeight: FontWeight.bold)),
      ),
    );
  }
}

import 'package:flutter/material.dart';

/// An accessible header widget for section headings.
///
/// Uses [Semantics] with `header: true` to announce as a heading landmark
/// for screen reader navigation. For headers specifically, we DO use
/// `excludeSemantics: true` because:
///
/// 1. Headers are simple text - no interactive children that need semantics
/// 2. The Text widget would create a duplicate announcement ("Title, Title")
/// 3. There are no child states (disabled, selected, values) to preserve
///
/// This is a valid case for excludeSemantics, unlike buttons or cards
/// which have interactive children with their own semantic properties.
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

    // For headers, excludeSemantics IS appropriate because:
    // - Headers have no interactive children with semantic state
    // - Text widget would duplicate the announcement
    // - We want one clean "heading: Title" announcement
    return Semantics(
      header: true,
      label: text,
      excludeSemantics: true, // Intentional: prevent "Title, Title" duplication
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
        child: Text(text, style: style?.copyWith(fontWeight: FontWeight.bold)),
      ),
    );
  }
}

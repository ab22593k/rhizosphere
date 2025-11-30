import 'package:flutter/material.dart';

/// A button that adheres to accessibility best practices.
///
/// Features:
/// - **Touch Target**: Enforces a minimum size of 48x48 logical pixels (WCAG 2.1 SC 2.5.5).
/// - **Semantics**: Wraps the button in a [Semantics] widget to provide an explicit [semanticLabel],
///   ensuring screen readers announce the action clearly ("Submit Form") rather than just the visual text ("Click Me").
/// - **Focus**: Ensures the button is focusable for keyboard and switch users.
/// - **Actions**: Explicitly wires [onTap] to the semantic node to ensure action availability.
/// - **Scannability**: Enforces short, action-oriented labels (max 4 words).
class AccessibleButton extends StatelessWidget {
  /// The visual text displayed on the button.
  final String label;

  /// The callback when the button is activated.
  final VoidCallback onPressed;

  /// The label announced by screen readers.
  final String semanticLabel;

  const AccessibleButton({
    super.key,
    required this.label,
    required this.onPressed,
    required this.semanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    // Validate word count (max 4 words for scannability)
    assert(() {
      final wordCount = label.trim().split(RegExp(r'\s+')).length;
      if (wordCount > 4) {
        throw AssertionError(
          'AccessibleButton label "$label" has $wordCount words. '
          'Action buttons must be 4 words or fewer for fast scanning.',
        );
      }
      return true;
    }());

    // We use an explicit Semantics wrapper to override the default semantics
    // of the ElevatedButton. This allows us to provide a specific [semanticLabel]
    // that differs from the visual [label] (e.g., "Submit" vs "Next").
    // We explicitly set [focusable] and [onTap] to ensure keyboard navigation works.
    return Semantics(
      label: semanticLabel,
      button: true,
      enabled: true,
      onTap: onPressed,
      focusable: true,
      // Exclude child semantics to prevent the visual text ("Click Me") from
      // merging with or overriding our explicit semantic label.
      excludeSemantics: true,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(minimumSize: const Size(48, 48)),
          child: Text(label),
        ),
      ),
    );
  }
}

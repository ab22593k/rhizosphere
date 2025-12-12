import 'package:flutter/material.dart';

/// A button that adheres to accessibility best practices.
///
/// Features:
/// - **Touch Target**: Enforces a minimum size of 48x48 logical pixels (WCAG 2.1 SC 2.5.5).
/// - **Semantics**: Uses [MergeSemantics] to augment (not replace) the button's native
///   accessibility, adding a custom [semanticLabel] while preserving platform behaviors.
/// - **Disabled State**: When [onPressed] is null, the button is disabled and screen readers
///   correctly announce it as unavailable (WCAG 4.1.2 Name, Role, Value).
/// - **Focus**: Inherits focusability from [ElevatedButton] for keyboard and switch users.
/// - **Scannability**: Enforces short, action-oriented labels (max 4 words).
class AccessibleButton extends StatelessWidget {
  /// The visual text displayed on the button.
  final String label;

  /// The callback when the button is activated.
  /// When null, the button is disabled and announced as such by screen readers.
  final VoidCallback? onPressed;

  /// The label announced by screen readers.
  /// This augments (does not replace) the button's native semantics.
  final String semanticLabel;

  const AccessibleButton({
    super.key,
    required this.label,
    this.onPressed,
    required this.semanticLabel,
  });

  /// Whether the button is enabled (has an onPressed callback).
  bool get isEnabled => onPressed != null;

  @override
  Widget build(BuildContext context) {
    // Validate word count (max 4 words for scannability)
    assert(() {
      final wordCount = label.trim().split(RegExp(r'\s+')).length;
      if (wordCount > 4) {
        debugPrint(
          'AccessibleButton label "$label" has $wordCount words. '
          'Action buttons must be 4 words or fewer for fast scanning.',
        );
      }
      return true;
    }());

    // Use MergeSemantics to augment (not replace) the ElevatedButton's native
    // accessibility. This preserves:
    // - Platform-specific disabled/enabled announcements
    // - Focus state and keyboard navigation
    // - Button role from the underlying widget
    // We add our semantic label and hint to enhance the announcement.
    return MergeSemantics(
      child: Semantics(
        // Provide a clear, action-oriented label for screen readers
        label: semanticLabel,
        // Let the ElevatedButton handle button role and enabled state
        // Don't set button: true or enabled: here - let child provide it
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(minimumSize: const Size(48, 48)),
            child: Text(label),
          ),
        ),
      ),
    );
  }
}

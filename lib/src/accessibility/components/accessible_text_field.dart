import 'package:flutter/material.dart';

/// A text field optimized for accessibility.
///
/// Features:
/// - **Semantics**: Leverages Flutter's built-in TextField semantics by passing
///   [label] and [hint] to [InputDecoration]. This avoids creating redundant
///   semantic nodes that can confuse screen readers.
/// - **Contrast**: Uses an [OutlineInputBorder] to ensure the input area is
///   clearly delimited, aiding users with low vision (WCAG 1.4.11 Non-text Contrast).
/// - **Structure**: Wraps the standard [TextField] to ensure consistent
///   accessibility behaviors across the app.
///
/// Note: Do NOT wrap TextField in a Semantics widget with `textField: true`.
/// Flutter's TextField already creates a complex semantic node, and wrapping it
/// in another Semantics with `textField: true` creates nested accessible objects.
/// Screen readers (especially TalkBack on Android) may announce "Edit box, Edit box"
/// or fail to focus the inner input correctly.
class AccessibleTextField extends StatelessWidget {
  /// The label displayed above the field and announced by screen readers.
  final String label;

  /// The hint text displayed inside the field when empty.
  final String hint;

  /// Controller for the text input.
  final TextEditingController? controller;

  /// Focus node for managing keyboard focus.
  final FocusNode? focusNode;

  /// Called when the text field value changes.
  final ValueChanged<String>? onChanged;

  /// Called when the user submits the text field.
  final ValueSetter<String>? onSubmitted;

  /// Whether the text field is read-only.
  final bool readOnly;

  /// Whether the text field is enabled.
  final bool enabled;

  /// The type of keyboard to display.
  final TextInputType? keyboardType;

  /// Whether to obscure the text (for passwords).
  final bool obscureText;

  /// Maximum number of lines for the text field.
  final int? maxLines;

  /// Minimum number of lines for the text field.
  final int? minLines;

  /// Maximum length of the text.
  final int? maxLength;

  /// The text input action button.
  final TextInputAction? textInputAction;

  /// Autofill hints for the field.
  final Iterable<String>? autofillHints;

  const AccessibleTextField({
    super.key,
    required this.label,
    required this.hint,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onSubmitted,
    this.readOnly = false,
    this.enabled = true,
    this.keyboardType,
    this.obscureText = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.textInputAction,
    this.autofillHints,
  });

  @override
  Widget build(BuildContext context) {
    // Flutter's TextField automatically creates proper semantics from
    // InputDecoration's labelText and hintText. No need for a Semantics wrapper.
    return TextField(
      controller: controller,
      focusNode: focusNode,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      readOnly: readOnly,
      enabled: enabled,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: maxLines,
      minLines: minLines,
      maxLength: maxLength,
      textInputAction: textInputAction,
      autofillHints: autofillHints,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        // Outline border provides better visibility/contrast than underline only.
        border: const OutlineInputBorder(),
      ),
    );
  }
}

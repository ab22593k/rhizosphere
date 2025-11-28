import 'package:flutter/material.dart';

/// A text field optimized for accessibility.
///
/// Features:
/// - **Semantics**: Explicitly marks the widget as a text field with [label] and [hint] for screen readers.
/// - **Contrast**: Uses an [OutlineInputBorder] to ensure the input area is clearly delimited,
///   aiding users with low vision (WCAG 1.4.11 Non-text Contrast).
/// - **Structure**: Wraps the standard [TextField] to ensure consistent accessibility behaviors.
class AccessibleTextField extends StatelessWidget {
  /// The label displayed above the field and announced by screen readers.
  final String label;

  /// The hint text displayed inside the field when empty.
  final String hint;

  /// Controller for the text input.
  final TextEditingController? controller;

  /// Focus node for managing keyboard focus.
  final FocusNode? focusNode;

  const AccessibleTextField({
    super.key,
    required this.label,
    required this.hint,
    this.controller,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    // Wrap in Semantics to reinforce the label and hint for assistive technologies.
    // While TextField handles much of this, explicit Semantics ensures the
    // intended description is prioritized.
    return Semantics(
      textField: true,
      label: label,
      hint: hint,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          // Outline border provides better visibility/contrast than underline only.
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}

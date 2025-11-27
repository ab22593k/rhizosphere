import 'package:flutter/material.dart';

class AccessibleTextField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController? controller;

  const AccessibleTextField({
    super.key,
    required this.label,
    required this.hint,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: label, hintText: hint),
    );
  }
}

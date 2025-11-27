import 'package:flutter/material.dart';

class AccessibleButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final String semanticLabel;

  const AccessibleButton({
    super.key,
    required this.label,
    required this.onPressed,
    required this.semanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(label, semanticsLabel: semanticLabel),
    );
  }
}

import 'package:flutter/material.dart';

class GestureHandler extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;

  const GestureHandler({super.key, required this.child, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onTap, // Alternative gesture
      onVerticalDragEnd: (_) => onTap?.call(), // Swipe alternative
      child: child,
    );
  }
}

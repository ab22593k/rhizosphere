import 'package:flutter/material.dart';
import '../layout/window_size_class.dart';
import '../layout/adaptive_builder.dart';

class AdaptiveAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final List<Widget>? actions;

  const AdaptiveAppBar({required this.title, this.actions, super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(
      builder: (context, sizeClass, _) {
        switch (sizeClass) {
          case WindowSizeClass.compact:
            return AppBar(
              // Standard small
              title: title,
              centerTitle: true,
              actions: actions,
            );
          case WindowSizeClass.medium:
            // Using generic AppBar but center aligned is typical for Medium size class
            // or strictly sticking to M3 specs
            return AppBar(title: title, centerTitle: true, actions: actions);
          case WindowSizeClass.expanded:
            return AppBar(
              // Standard/Large
              title: title,
              centerTitle: false,
              actions: actions,
              toolbarHeight: 72, // Example of larger toolbar
            );
        }
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight); // This might need dynamic sizing logic if using Slivers
}

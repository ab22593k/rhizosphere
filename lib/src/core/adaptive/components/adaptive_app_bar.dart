import 'package:flutter/material.dart';
import '../layout/window_size_class.dart';
import '../layout/adaptive_builder.dart';

enum AdaptiveAppBarType { small, centerAligned, medium, large }

class AdaptiveAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final List<Widget>? actions;
  final AdaptiveAppBarType? type;

  const AdaptiveAppBar({
    required this.title,
    this.actions,
    this.type,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(
      builder: (context, sizeClass, _) {
        AdaptiveAppBarType effectiveType =
            type ?? _getTypeForSizeClass(sizeClass);

        switch (effectiveType) {
          case AdaptiveAppBarType.small:
            return AppBar(title: title, centerTitle: false, actions: actions);
          case AdaptiveAppBarType.centerAligned:
            return AppBar(title: title, centerTitle: true, actions: actions);
          case AdaptiveAppBarType.medium:
            return AppBar(
              title: title,
              centerTitle: false,
              actions: actions,
              toolbarHeight: 112,
              titleTextStyle: Theme.of(context).textTheme.headlineSmall,
            );
          case AdaptiveAppBarType.large:
            return AppBar(
              title: title,
              centerTitle: false,
              actions: actions,
              toolbarHeight: 152,
              titleTextStyle: Theme.of(context).textTheme.headlineMedium,
            );
        }
      },
    );
  }

  AdaptiveAppBarType _getTypeForSizeClass(WindowSizeClass sizeClass) {
    switch (sizeClass) {
      case WindowSizeClass.compact:
        return AdaptiveAppBarType.centerAligned;
      case WindowSizeClass.medium:
        return AdaptiveAppBarType.centerAligned;
      case WindowSizeClass.expanded:
        return AdaptiveAppBarType
            .small; // Keep it small/standard for desktop unless medium/large is explicitly requested
    }
  }

  @override
  Size get preferredSize {
    // If a specific type matches a known height, we could return it,
    // but without context we can't be sure if it's adaptive.
    // We return a standard height + extra buffer if type is known large.
    if (type == AdaptiveAppBarType.medium) return const Size.fromHeight(112);
    if (type == AdaptiveAppBarType.large) return const Size.fromHeight(152);
    return const Size.fromHeight(kToolbarHeight);
  }
}

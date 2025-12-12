import 'package:flutter/material.dart';
import '../../../adaptive/layout/window_size_class.dart';

enum ComponentType {
  floatingActionButton,
  appBar,
  navigationItem,
  card,
  button,
  listTile,
}

class ComponentStyle {
  final double? size;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final bool showLabels;
  final bool showIcons;
  final double? elevation;
  final Color? backgroundColor;
  final AlignmentGeometry? position;

  const ComponentStyle({
    this.size,
    this.padding,
    this.margin,
    this.showLabels = true,
    this.showIcons = true,
    this.elevation,
    this.backgroundColor,
    this.position,
  });
}

abstract class ComponentAdaptation {
  ComponentStyle getStyle(WindowSizeClass sizeClass);
}

class FabAdaptation implements ComponentAdaptation {
  @override
  ComponentStyle getStyle(WindowSizeClass sizeClass) {
    switch (sizeClass) {
      case WindowSizeClass.compact:
        return const ComponentStyle(
          size: 56,
          position: Alignment.bottomRight,
          margin: EdgeInsets.all(16),
        );
      case WindowSizeClass.medium:
        return const ComponentStyle(
          size: 56,
          position: Alignment.bottomRight,
          margin: EdgeInsets.all(24),
        );
      case WindowSizeClass.expanded:
        return const ComponentStyle(
          size: 96, // Large FAB
          position: Alignment.bottomRight,
          margin: EdgeInsets.all(32),
        );
    }
  }
}

// Add more adaptations as needed

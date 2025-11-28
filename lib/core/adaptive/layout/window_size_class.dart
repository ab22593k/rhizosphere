import 'package:flutter/material.dart';

enum WindowSizeClass {
  compact,
  medium,
  expanded;

  static const double compactMaxWidth = 600;
  static const double mediumMaxWidth = 840;

  static WindowSizeClass fromWidth(double width) {
    if (width < compactMaxWidth) {
      return WindowSizeClass.compact;
    } else if (width < mediumMaxWidth) {
      return WindowSizeClass.medium;
    } else {
      return WindowSizeClass.expanded;
    }
  }

  static WindowSizeClass fromConstraints(BoxConstraints constraints) {
    return fromWidth(constraints.maxWidth);
  }

  // Helper properties for convenience
  bool get isCompact => this == WindowSizeClass.compact;
  bool get isMedium => this == WindowSizeClass.medium;
  bool get isExpanded => this == WindowSizeClass.expanded;
}

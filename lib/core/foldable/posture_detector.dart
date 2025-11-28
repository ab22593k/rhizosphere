import 'dart:ui';
import 'package:flutter/material.dart';
import 'posture_storage.dart';

class PostureDetector extends StatefulWidget {
  final Widget child;
  final ValueChanged<PostureState>? onPostureChanged;

  const PostureDetector({
    required this.child,
    this.onPostureChanged,
    super.key,
  });

  @override
  State<PostureDetector> createState() => _PostureDetectorState();
}

class _PostureDetectorState extends State<PostureDetector> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final displayFeatures = mediaQuery.displayFeatures;

    // Basic logic: if hinge exists, check state
    // Note: displayFeatures usually gives physical areas.
    // Posture state logic is more complex (usually requires flutter_folding_ui or similar package if not exposed directly).
    // Standard MediaQuery doesn't give "folded" boolean directly easily without external plugin.
    // But assuming we detect hinge presence.

    PostureState state = PostureState.unfolded;
    if (displayFeatures.isNotEmpty) {
      for (final feature in displayFeatures) {
        if (feature.type == DisplayFeatureType.hinge ||
            feature.type == DisplayFeatureType.fold) {
          state = PostureState.partiallyFolded; // Assumption for demo
          break;
        }
      }
    }

    if (widget.onPostureChanged != null) {
      widget.onPostureChanged!(state);
    }

    return widget.child;
  }
}

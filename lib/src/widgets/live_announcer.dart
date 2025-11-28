import 'package:flutter/material.dart';

/// A widget that announces changes to screen readers.
///
/// Rationale:
/// - **Live Regions**: Uses [Semantics] with `liveRegion: true` to inform screen readers
///   of dynamic content changes (like form errors or status updates) without moving focus.
///   (WCAG 4.1.3 Status Messages).
class LiveAnnouncer extends StatelessWidget {
  /// The message to announce.
  final String message;

  /// The child widget to display (visually).
  final Widget child;

  const LiveAnnouncer({super.key, required this.message, required this.child});

  @override
  Widget build(BuildContext context) {
    return Semantics(liveRegion: true, label: message, child: child);
  }
}

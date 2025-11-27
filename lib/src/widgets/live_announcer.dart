import 'package:flutter/material.dart';

class LiveAnnouncer extends StatelessWidget {
  final String message;
  final Widget child;

  const LiveAnnouncer({
    super.key,
    required this.message,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      liveRegion: true,
      label: message,
      child: child,
    );
  }
}

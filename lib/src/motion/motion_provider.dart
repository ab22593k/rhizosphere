import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'motion_scheme.dart';

class MotionNotifier extends Notifier<MotionScheme> {
  @override
  MotionScheme build() {
    return MotionScheme.expressive; // Default is expressive per spec
  }

  void setScheme(MotionScheme scheme) {
    state = scheme;
  }
}

final motionProvider = NotifierProvider<MotionNotifier, MotionScheme>(() {
  return MotionNotifier();
});

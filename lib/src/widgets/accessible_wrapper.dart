import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/text_scaler.dart';
import '../providers/theme_provider.dart';

class AccessibleWrapper extends ConsumerWidget {
  final Widget child;

  const AccessibleWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(accessibilityProvider);

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaler: AppTextScaler.fromScale(config.textScaleFactor),
        highContrast: config.highContrast,
      ),
      child: child,
    );
  }
}

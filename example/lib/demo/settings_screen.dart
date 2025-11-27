import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rhizosphere/rhizosphere.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(accessibilityProvider);
    final notifier = ref.read(accessibilityProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('High Contrast'),
            subtitle: const Text('Increase contrast for better visibility'),
            value: config.highContrast,
            onChanged: (value) => notifier.toggleHighContrast(),
          ),
          ListTile(
            title: const Text('Text Scale'),
            subtitle: Text('${(config.textScaleFactor * 100).toInt()}%'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    notifier.setTextScale(
                      AppTextScaler.clampScale(config.textScaleFactor - 0.1),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    notifier.setTextScale(
                      AppTextScaler.clampScale(config.textScaleFactor + 0.1),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

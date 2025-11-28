import 'package:flutter/material.dart';
import 'package:rhizosphere/views/base_layout.dart';
import 'package:rhizosphere/views/components/accessible_header.dart';

class ShortcutsHelpView extends StatelessWidget {
  const ShortcutsHelpView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: 'Keyboard Shortcuts',
      body: ListView(
        children: const [
          AccessibleHeader(text: 'Navigation', level: 2),
          ListTile(
            title: Text('Tab'),
            subtitle: Text('Move focus to next element'),
          ),
          ListTile(
            title: Text('Shift + Tab'),
            subtitle: Text('Move focus to previous element'),
          ),
          ListTile(
            title: Text('Arrow Keys'),
            subtitle: Text('Scroll or navigate within lists'),
          ),
          ListTile(
            title: Text('Enter'),
            subtitle: Text('Activate focused element'),
          ),
          AccessibleHeader(text: 'Custom Actions', level: 2),
          ListTile(
            title: Text('Control + H'),
            subtitle: Text('Go to Home Screen'),
          ),
          ListTile(
            title: Text('Control + /'),
            subtitle: Text('Show this Shortcuts Help'),
          ),
        ],
      ),
    );
  }
}

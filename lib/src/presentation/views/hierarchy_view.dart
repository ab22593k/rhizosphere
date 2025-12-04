import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../presentation/views/base_layout.dart';
import '../../presentation/views/components/accessible_card.dart';
import '../../presentation/views/components/accessible_header.dart';
import '../../presentation/views/shortcuts_help_view.dart';
import '../../data/intents.dart';
import '../../data/navigation_item.dart';

class HierarchyView extends StatelessWidget {
  final List<NavigationItem> items;

  const HierarchyView({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: <LogicalKeySet, Intent>{
        LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.slash):
            const HelpIntent(),
        LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyH):
            const HomeIntent(),
      },
      child: Actions(
        actions: <Type, Action<Intent>>{
          HelpIntent: CallbackAction<HelpIntent>(
            onInvoke: (HelpIntent intent) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ShortcutsHelpView(),
                ),
              );
              return null;
            },
          ),
          HomeIntent: CallbackAction<HomeIntent>(
            onInvoke: (HomeIntent intent) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Home Shortcut Triggered')),
              );
              // Navigation logic would go here
              return null;
            },
          ),
        },
        child: BaseLayout(
          title: 'Accessible Hierarchy',
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AccessibleHeader(text: 'Categories', level: 1),
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return AccessibleCard(
                      title: item.title,
                      description: item.description,
                      onTap: () {
                        debugPrint('Tapped ${item.title}');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Selected: ${item.title}')),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

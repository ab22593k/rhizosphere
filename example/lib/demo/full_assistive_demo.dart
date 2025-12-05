import 'package:flutter/material.dart';
import 'package:rhizosphere/rhizosphere.dart';

/// A comprehensive demo showcasing multiple assistive technologies.
///
/// Demonstrates:
/// - Screen Reader Order (Traversal)
/// - Switch Access (Focus)
/// - Alternative Inputs (Gestures)
/// - Live Announcements
class FullAssistiveDemo extends StatefulWidget {
  const FullAssistiveDemo({super.key});

  @override
  State<FullAssistiveDemo> createState() => _FullAssistiveDemoState();
}

class _FullAssistiveDemoState extends State<FullAssistiveDemo> {
  String _status = 'Ready';
  int _counter = 0;

  void _handleAction(String actionName) {
    setState(() {
      _counter++;
      _status = '$actionName executed (Count: $_counter)';
    });
  }

  @override
  Widget build(BuildContext context) {
    // 1. AccessibleWrapper: Injects text scaling and custom scroll behavior
    // (RhizosphereScrollBehavior) into the widget tree.
    return AccessibleWrapper(
      child: BaseLayout(
        // 2. BaseLayout: Replaces Scaffold to provide automatic semantic landmarks.
        title: 'Assistive Tech Demo',
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Live Region Section ---
              // 3. AccessibleHeader: Enforces semantic hierarchy (Header Level 2)
              // and ensures labels are short/scannable (max 4 words).
              const AccessibleHeader(text: 'Live status updates', level: 2),

              const AccessibleText(
                text:
                    'The box below announces changes to screen readers automatically.',
              ),
              const SizedBox(height: 16),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).dividerColor),
                  borderRadius: BorderRadius.circular(8),
                ),
                // LiveAnnouncer: Triggers WCAG 4.1.3 status updates without moving focus.
                child: LiveAnnouncer(
                  message: _status,
                  child: Row(
                    children: [
                      const Icon(Icons.info_outline),
                      const SizedBox(width: 16),
                      Expanded(
                        child: AccessibleText(
                          text: _status,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // --- Semantic Order Section ---
              const AccessibleHeader(text: 'Semantic navigation', level: 2),
              const AccessibleText(
                text:
                    'These items are grouped logically. Screen readers should read the group label first, then the content.',
              ),
              const SizedBox(height: 16),

              MergeSemantics(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AccessibleText(
                      text: 'Group A',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const AccessibleText(
                      text: 'Description for group A content.',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // --- Input Alternatives Section ---
              const AccessibleHeader(text: 'Input alternatives', level: 2),
              const AccessibleText(
                text: 'Try tapping, long-pressing, or swiping the box below.',
              ),
              const SizedBox(height: 16),

              // GestureHandler: Adds LongPress and VerticalDrag support for motor impairments.
              GestureHandler(
                onTap: () => _handleAction('Gesture Box'),
                child: Container(
                  height: 100,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  // 4. AccessibleText with Background Color:
                  // This enables the ContrastChecker to warn you if the text isn't readable.
                  child: AccessibleText(
                    text: 'Interactive zone',
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.primaryContainer,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // --- Focus & Keyboard Section ---
              const AccessibleHeader(
                text: 'Keyboard & switch access',
                level: 2,
              ),
              const AccessibleText(
                text:
                    'These buttons have explicit focus order and large touch targets.',
              ),
              const SizedBox(height: 16),

              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  // AccessibleButton: Enforces 48x48dp touch target and clear semantic labels.
                  AccessibleButton(
                    label: 'Action 1',
                    semanticLabel: 'Perform Action 1',
                    onPressed: () => _handleAction('Button 1'),
                  ),
                  AccessibleButton(
                    label: 'Action 2',
                    semanticLabel: 'Perform Action 2',
                    onPressed: () => _handleAction('Button 2'),
                  ),
                  // AccessibleTextField: Ensures input borders are visible (high contrast).
                  const AccessibleTextField(
                    label: 'Input Data',
                    hint: 'Type here...',
                  ),
                ],
              ),

              // Extra padding for comfortable scrolling
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }
}

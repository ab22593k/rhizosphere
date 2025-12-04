import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rhizosphere/rhizosphere.dart';

class MotionShowcase extends ConsumerStatefulWidget {
  const MotionShowcase({super.key});

  @override
  ConsumerState<MotionShowcase> createState() => _MotionShowcaseState();
}

class _MotionShowcaseState extends ConsumerState<MotionShowcase> {
  // Toggle state for animation demo
  bool _toggled = false;

  void _toggle() {
    setState(() {
      _toggled = !_toggled;
    });
  }

  @override
  Widget build(BuildContext context) {
    final scheme = ref.watch(motionProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Motion System Showcase'),
        actions: [
          // Scheme Selector
          DropdownButton<MotionScheme>(
            value: scheme,
            icon: const Icon(Icons.style, color: Colors.white),
            dropdownColor: Theme.of(context).colorScheme.surface,
            onChanged: (MotionScheme? newScheme) {
              if (newScheme != null) {
                ref.read(motionProvider.notifier).setScheme(newScheme);
              }
            },
            items: MotionScheme.values.map<DropdownMenuItem<MotionScheme>>((
              MotionScheme value,
            ) {
              return DropdownMenuItem<MotionScheme>(
                value: value,
                child: Text(
                  value.name.toUpperCase(),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AccessibleHeader(text: 'Global Scheme: ${scheme.name}', level: 2),
            const SizedBox(height: 8),
            Text(
              'Tap boxes to trigger animation. Switch scheme to see instant retargeting.',
            ),
            const SizedBox(height: 24),

            // Global Toggle Button
            Center(
              child: AccessibleButton(
                label: _toggled ? 'Reset All' : 'Animate All',
                onPressed: _toggle,
                semanticLabel: 'Toggle all animations',
              ),
            ),
            const SizedBox(height: 32),

            AccessibleHeader(
              text: 'Spatial Tokens (Overshoot allowed)',
              level: 3,
            ),
            const SizedBox(height: 16),
            _buildTokenRow(
              context,
              'Fast',
              MotionSpeed.fast,
              MotionType.spatial,
            ),
            const SizedBox(height: 16),
            _buildTokenRow(
              context,
              'Default',
              MotionSpeed.defaultSpeed,
              MotionType.spatial,
            ),
            const SizedBox(height: 16),
            _buildTokenRow(
              context,
              'Slow',
              MotionSpeed.slow,
              MotionType.spatial,
            ),

            const SizedBox(height: 32),
            AccessibleHeader(text: 'Effects Tokens (No overshoot)', level: 3),
            const SizedBox(height: 16),
            _buildTokenRow(
              context,
              'Fast',
              MotionSpeed.fast,
              MotionType.effects,
            ),
            const SizedBox(height: 16),
            _buildTokenRow(
              context,
              'Default',
              MotionSpeed.defaultSpeed,
              MotionType.effects,
            ),
            const SizedBox(height: 16),
            _buildTokenRow(
              context,
              'Slow',
              MotionSpeed.slow,
              MotionType.effects,
            ),

            const SizedBox(height: 32),
            AccessibleHeader(text: 'Device Adaptive Scaling', level: 3),
            const SizedBox(height: 8),
            Text(
              'Current Scale Factor: ${MotionAdaptive.getDurationScale(context)}x',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTokenRow(
    BuildContext context,
    String label,
    MotionSpeed speed,
    MotionType type,
  ) {
    final scheme = ref.watch(motionProvider);
    // Resolve spring using the extension method
    final spring = scheme.resolve(speed, type);

    // Apply device scaling
    final scaleFactor = MotionAdaptive.getDurationScale(context);
    final effectiveSpring = spring.scaleDuration(scaleFactor);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label (${type.name}) - Mass: ${effectiveSpring.mass}, Stiffness: ${effectiveSpring.stiffness.toStringAsFixed(1)}, Damping: ${effectiveSpring.damping.toStringAsFixed(1)}',
        ),
        const SizedBox(height: 8),
        SpringBuilder(
          value: _toggled ? 1.0 : 0.0,
          spring: effectiveSpring,
          builder: (context, value, child) {
            return Container(
              height: 50,
              // Use value to animate width and color
              width: 100 + (200 * value),
              decoration: BoxDecoration(
                color: Color.lerp(
                  Theme.of(context).colorScheme.primaryContainer,
                  Theme.of(context).colorScheme.primary,
                  value,
                ),
                borderRadius: BorderRadius.circular(8 + (16 * value)),
              ),
              alignment: Alignment.center,
              child: Text(
                '${(value * 100).toInt()}%',
                style: TextStyle(
                  color: Color.lerp(
                    Theme.of(context).colorScheme.onPrimaryContainer,
                    Theme.of(context).colorScheme.onPrimary,
                    value,
                  ),
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

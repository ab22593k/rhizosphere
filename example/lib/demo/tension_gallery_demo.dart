import 'package:flutter/material.dart';
import 'package:rhizosphere/rhizosphere.dart';

class TensionGalleryDemo extends StatelessWidget {
  const TensionGalleryDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final shapeTheme = Theme.of(context).extension<ShapeTheme>()!;

    return Scaffold(
      appBar: AppBar(title: const Text('Tension Gallery')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sharp Cards + Pill Buttons',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Card(
              shape: shapeTheme.roundedRectangle(
                topStart: CornerStyle.xs,
                topEnd: CornerStyle.xs,
                bottomStart: CornerStyle.xs,
                bottomEnd: CornerStyle.xs,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text(
                      'This card has sharp (xs) corners to create tension with the pill button.',
                    ),
                    const SizedBox(height: 16),
                    FilledButton(
                      onPressed: () {},
                      style: FilledButton.styleFrom(
                        shape: shapeTheme.stadium(),
                      ),
                      child: const Text('Pill Button'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'Asymmetric Tension',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Container(
              height: 100,
              decoration: ShapeDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                shape: shapeTheme.roundedRectangle(
                  topStart: CornerStyle.l,
                  bottomEnd: CornerStyle.l,
                  topEnd: CornerStyle.none,
                  bottomStart: CornerStyle.none,
                ),
              ),
              child: const Center(child: Text('Leaf Shape')),
            ),
          ],
        ),
      ),
    );
  }
}

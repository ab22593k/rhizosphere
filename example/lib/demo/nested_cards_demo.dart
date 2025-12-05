import 'package:flutter/material.dart';
import 'package:rhizosphere/rhizosphere.dart';

class NestedCardsDemo extends StatelessWidget {
  const NestedCardsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final shapeTheme = Theme.of(context).extension<ShapeTheme>()!;

    return Scaffold(
      appBar: AppBar(title: const Text('Optical Roundness')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Container(
            width: 300,
            height: 300,
            padding: const EdgeInsets.all(24),
            decoration: ShapeDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              shape: shapeTheme.roundedRectangle(
                topStart: CornerStyle.xl,
                topEnd: CornerStyle.xl,
                bottomStart: CornerStyle.xl,
                bottomEnd: CornerStyle.xl,
              ),
            ),
            child: Container(
              decoration: ShapeDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                shape: RoundedRectangleBorder(
                  borderRadius: context.adjustForNesting(
                    shapeTheme.borderRadius(CornerStyle.xl),
                    24, // padding
                  ),
                ),
              ),
              child: const Center(child: Text('Nested with Optical Roundness')),
            ),
          ),
        ),
      ),
    );
  }
}

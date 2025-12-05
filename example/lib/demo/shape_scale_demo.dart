import 'package:flutter/material.dart';
import 'package:rhizosphere/rhizosphere.dart';

class ShapeScaleDemo extends StatelessWidget {
  const ShapeScaleDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final shapeTheme = Theme.of(context).extension<ShapeTheme>()!;

    return Scaffold(
      appBar: AppBar(title: const Text('Shape Scale Reference')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: CornerStyle.values.map((style) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                SizedBox(
                  width: 100,
                  child: Text(
                    style.name,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 60,
                    decoration: ShapeDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      shape: shapeTheme.roundedRectangle(
                        topStart: style,
                        topEnd: style,
                        bottomStart: style,
                        bottomEnd: style,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        style.value == -1.0 ? 'Full' : '${style.value}dp',
                        style: TextStyle(
                          color: Theme.of(
                            context,
                          ).colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

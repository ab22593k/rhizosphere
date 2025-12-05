import 'package:flutter/material.dart';
import 'package:rhizosphere/rhizosphere.dart';

class MorphingButtonsDemo extends StatefulWidget {
  const MorphingButtonsDemo({super.key});

  @override
  State<MorphingButtonsDemo> createState() => _MorphingButtonsDemoState();
}

class _MorphingButtonsDemoState extends State<MorphingButtonsDemo> {
  bool _isPressed = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final shapeTheme = Theme.of(context).extension<ShapeTheme>()!;

    return Scaffold(
      appBar: AppBar(title: const Text('Morphing Buttons')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Press to Morph',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTapDown: (_) => setState(() => _isPressed = true),
              onTapUp: (_) => setState(() => _isPressed = false),
              onTapCancel: () => setState(() => _isPressed = false),
              child: ShapeMorphTransition(
                shape: _isPressed
                    ? shapeTheme.roundedRectangle(
                        topStart: CornerStyle.s,
                        topEnd: CornerStyle.s,
                        bottomStart: CornerStyle.s,
                        bottomEnd: CornerStyle.s,
                      )
                    : shapeTheme.stadium(),
                child: Container(
                  width: 200,
                  height: 56,
                  color: Theme.of(context).colorScheme.primary,
                  alignment: Alignment.center,
                  child: Text(
                    _isPressed ? 'Pressed (Small)' : 'Normal (Stadium)',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 48),
            Text(
              'Loading Morph',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: () {
                setState(() => _isLoading = !_isLoading);
              },
              child: ShapeMorphTransition(
                shape: _isLoading
                    ? shapeTheme.roundedRectangle(
                        topStart: CornerStyle.full,
                        topEnd: CornerStyle.full,
                        bottomStart: CornerStyle.full,
                        bottomEnd: CornerStyle.full,
                      ) // Circle
                    : shapeTheme.roundedRectangle(
                        topStart: CornerStyle.m,
                        topEnd: CornerStyle.m,
                        bottomStart: CornerStyle.m,
                        bottomEnd: CornerStyle.m,
                      ), // Rect
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: _isLoading ? 56 : 200,
                  height: 56,
                  color: Theme.of(context).colorScheme.secondary,
                  alignment: Alignment.center,
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                          'Tap to Load',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

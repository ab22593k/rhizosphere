import 'package:flutter/material.dart';
import 'package:rhizosphere/rhizosphere.dart';

class LoadingIndicatorsDemo extends StatefulWidget {
  const LoadingIndicatorsDemo({super.key});

  @override
  State<LoadingIndicatorsDemo> createState() => _LoadingIndicatorsDemoState();
}

class _LoadingIndicatorsDemoState extends State<LoadingIndicatorsDemo>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final shapeTheme = Theme.of(context).extension<ShapeTheme>()!;

    return Scaffold(
      appBar: AppBar(title: const Text('Morphing Indicators')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Shape Morphing Loader',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 32),
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return ShapeMorphTransition(
                  shape: _controller.value < 0.5
                      ? shapeTheme.roundedRectangle(
                          topStart: CornerStyle.xs,
                          topEnd: CornerStyle.xs,
                          bottomStart: CornerStyle.xs,
                          bottomEnd: CornerStyle.xs,
                        )
                      : shapeTheme.stadium(),
                  child: Container(
                    width: 60,
                    height: 60,
                    color: Color.lerp(
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.secondary,
                      _controller.value,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 48),
            Text(
              'Pulsing Shapes',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _PulsingShape(
                  controller: _controller,
                  delay: 0.0,
                  shapeTheme: shapeTheme,
                  style: CornerStyle.s,
                ),
                const SizedBox(width: 16),
                _PulsingShape(
                  controller: _controller,
                  delay: 0.3,
                  shapeTheme: shapeTheme,
                  style: CornerStyle.l,
                ),
                const SizedBox(width: 16),
                _PulsingShape(
                  controller: _controller,
                  delay: 0.6,
                  shapeTheme: shapeTheme,
                  style: CornerStyle.full,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PulsingShape extends StatelessWidget {
  const _PulsingShape({
    required this.controller,
    required this.delay,
    required this.shapeTheme,
    required this.style,
  });

  final AnimationController controller;
  final double delay;
  final ShapeTheme shapeTheme;
  final CornerStyle style;

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: CurvedAnimation(
        parent: controller,
        curve: Interval(delay, 1.0, curve: Curves.elasticOut),
      ),
      child: Container(
        width: 40,
        height: 40,
        decoration: ShapeDecoration(
          color: Theme.of(context).colorScheme.tertiary,
          shape: style == CornerStyle.full
              ? shapeTheme.stadium()
              : shapeTheme.roundedRectangle(
                  topStart: style,
                  topEnd: style,
                  bottomStart: style,
                  bottomEnd: style,
                ),
        ),
      ),
    );
  }
}

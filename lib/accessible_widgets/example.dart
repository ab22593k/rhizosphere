import 'package:flutter/material.dart';
import 'package:rhizosphere/rhizosphere.dart';

/// A comprehensive example of using accessible widgets.
class AccessibleWidgetsExample extends StatelessWidget {
  const AccessibleWidgetsExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const DynamicTooltipLabel(
          text: 'Accessible Widgets Example Page Title That Is Too Long',
          tooltipText: 'Full accessible title shown on long press',
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Accessible Image with Alt Text
            const AccessibleImage(
              image: AssetImage(
                'assets/example.png',
              ), // Ensure asset exists or use NetworkImage
              altText: 'A descriptive alt text for screen readers',
              caption: 'Optional visible caption below the image',
            ),
            const SizedBox(height: 24),

            // 2. Accessible Text with Dynamic Scaling
            const AccessibleText(
              text:
                  'This text scales automatically with system settings. '
                  'It ensures sufficient contrast ratios and respects user preferences.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),

            // 3. Expandable Truncated Text
            const ExpandableTruncatedText(
              text:
                  'This is a very long text block that will be truncated initially. '
                  'Users can tap "more" to expand and read the full content. '
                  'This pattern is accessible and avoids information hiding '
                  'without cluttering the initial view. It animates smoothly '
                  'and ensures touch targets are large enough.',
              maxLines: 3,
            ),
            const SizedBox(height: 24),

            // 4. Truncation Handler (automatic fallback)
            const SizedBox(
              width: 200,
              child: AccessibleText(
                text:
                    'Text that is too wide for its container will show an ellipsis '
                    'and be accessible via long-press tooltip.',
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

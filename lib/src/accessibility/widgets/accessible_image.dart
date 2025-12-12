import 'package:flutter/material.dart';
import 'image_caption.dart';

/// An image widget that properly handles accessibility semantics.
///
/// For meaningful images (isDecorative = false):
/// - Wraps in Semantics with image role and descriptive label
/// - Label must be non-empty and <= 125 characters
///
/// For decorative images (isDecorative = true):
/// - Completely excludes from accessibility tree using ExcludeSemantics
/// - Prevents screen readers from announcing purely visual elements
/// - Follows WCAG 1.1.1 (Non-text Content) guidance
class AccessibleImage extends StatelessWidget {
  final ImageProvider image;
  final String semanticsLabel;
  final String? caption;
  final bool isDecorative;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Widget? errorWidget;
  final TextStyle? captionStyle;

  const AccessibleImage({
    super.key,
    required this.image,
    required this.semanticsLabel,
    this.caption,
    this.isDecorative = false,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.errorWidget,
    this.captionStyle,
  }) : assert(
         isDecorative ||
             (semanticsLabel.length > 0 && semanticsLabel.length <= 125),
         'Semantics label must be non-empty and <= 125 characters for meaningful images.',
       );

  @override
  Widget build(BuildContext context) {
    final imageWidget = Image(
      image: image,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        return errorWidget ??
            Container(
              width: width ?? 100,
              height: height ?? 100,
              color: Colors.grey[300],
              child: Icon(Icons.broken_image, color: Colors.grey[600]),
            );
      },
    );

    // For decorative images, completely exclude from semantics tree.
    // This prevents AT from announcing purely visual elements.
    // For meaningful images, provide proper image role and label.
    final accessibleWidget = isDecorative
        ? ExcludeSemantics(child: imageWidget)
        : Semantics(image: true, label: semanticsLabel, child: imageWidget);

    if (caption != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          accessibleWidget,
          ImageCaption(text: caption!, style: captionStyle),
        ],
      );
    }

    return accessibleWidget;
  }
}

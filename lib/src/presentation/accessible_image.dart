import 'package:flutter/material.dart';
import 'image_caption.dart';

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

    final semanticsWidget = Semantics(
      label: isDecorative ? '' : semanticsLabel,
      excludeSemantics: isDecorative,
      image: true,
      child: imageWidget,
    );

    if (caption != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          semanticsWidget,
          ImageCaption(text: caption!, style: captionStyle),
        ],
      );
    }

    return semanticsWidget;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// A widget that renders an SVG shape from the assets/shapes directory.
class SvgShape extends StatelessWidget {
  const SvgShape({super.key, required this.assetName, this.size, this.color});

  /// The name of the SVG asset in assets/shapes/.
  ///
  /// Example: 'material_shape_circle.svg'
  final String assetName;

  /// The size of the shape.
  final Size? size;

  /// The color to apply to the shape.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/shapes/$assetName',
      width: size?.width,
      height: size?.height,
      colorFilter: color != null
          ? ColorFilter.mode(color!, BlendMode.srcIn)
          : null,
    );
  }
}

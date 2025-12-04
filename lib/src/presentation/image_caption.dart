import 'package:flutter/material.dart';

class ImageCaption extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const ImageCaption({super.key, required this.text, this.style});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(
        text,
        style: style ?? Theme.of(context).textTheme.bodySmall,
        textAlign: TextAlign.center,
      ),
    );
  }
}

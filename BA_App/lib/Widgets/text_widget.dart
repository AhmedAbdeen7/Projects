import 'package:flutter/material.dart';

class TextItem extends StatelessWidget {
  const TextItem(
      {super.key, required this.text, required this.Top, required this.Left});
  final String text;
  final double Top;
  final double Left;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: Top,
      left: Left,
      child: Text(text),
    );
  }
}

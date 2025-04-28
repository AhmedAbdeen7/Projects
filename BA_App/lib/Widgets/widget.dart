import 'package:flutter/material.dart';

class WidgetItem extends StatelessWidget {
  const WidgetItem(
      {super.key,
      required this.link,
      required this.Top,
      required this.Left,
      this.Height,
      this.Width});
  final String link;
  final double Top;
  final double Left;
  final double? Width;
  final double? Height;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: Top,
      left: Left,
      width: Width,
      height: Height,
      child: Image.asset(link),
    );
  }
}

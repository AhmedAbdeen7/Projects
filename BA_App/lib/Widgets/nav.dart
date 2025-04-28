import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' show radians;

class CurvedBottomNavigationBar extends StatefulWidget {
  const CurvedBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<CurvedBottomNavigationBar> createState() =>
      _CurvedBottomNavigationBarState();
}

class _CurvedBottomNavigationBarState extends State<CurvedBottomNavigationBar> {
  int _selectedIndex = 0;
  double _iconSize = 28.0;
  double _activeIconSize = 36.0;
  double _raisedOffset = -12.0;
  Color _selectedColor = Colors.red;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30.0)),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            CustomPaint(
              size: Size(MediaQuery.of(context).size.width, 80),
              painter: CurvedPainter(context: context),
            ),
            SizedBox(
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(0, Icons.grid_view),
                  _buildNavItem(1, Icons.calendar_month),
                  _buildNavItem(2, Icons.home),
                  _buildNavItem(3, Icons.question_mark),
                  _buildNavItem(4, Icons.person),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData iconData) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: 56,
        height: isSelected ? 56 : 48,
        alignment: Alignment.center,
        child: AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          top: isSelected ? _raisedOffset : 0,
          child: Icon(
            iconData,
            size: isSelected ? _activeIconSize : _iconSize,
            color: isSelected ? _selectedColor : Colors.grey,
          ),
        ),
      ),
    );
  }
}

class CurvedPainter extends CustomPainter {
  final BuildContext context;

  CurvedPainter({required this.context});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    double width = MediaQuery.of(context).size.width;
    double height = 80.0;

    double curveHeightPercentage = 0.3; // Height of the curve
    double curveHeight = height * curveHeightPercentage;

    Path path = Path();
    path.moveTo(0, height); // Start at bottom left
    path.lineTo(0, curveHeight); // Go up to start of curve
    path.quadraticBezierTo(
      width / 2, // x control point (center of the bar)
      -curveHeight, // y control point (above the bar)
      width, // x end point (right side of the bar)
      curveHeight, // y end point (start of curve on the right)
    );
    path.lineTo(width, height); // Go back down to bottom right
    path.lineTo(0, height); // Complete the path
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

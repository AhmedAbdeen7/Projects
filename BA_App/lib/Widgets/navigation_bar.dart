import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final Function(int)? onItemTapped;
  final int? selectedIndex;

  const CustomBottomNavigationBar({
    super.key,
    this.onItemTapped,
    this.selectedIndex,
  });

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int? _activeIndex = 0;

  @override
  void initState() {
    super.initState();
    _activeIndex = widget.selectedIndex;
  }

  @override
  void didUpdateWidget(CustomBottomNavigationBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedIndex != oldWidget.selectedIndex) {
      setState(() {
        _activeIndex = widget.selectedIndex;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;

    // Device classification
    final isSmallPhone = screenHeight < 600; // Under 5"
    final isNormalPhone = screenHeight < 800; // 5"-6.5"
    final isLargePhone = screenHeight < 1000; // 6.7"-7.5"
    final isTablet = screenHeight >= 1000; // 7.9" and up

    // Navigation bar height
    final navBarHeight =
        isSmallPhone
            ? 72.0
            : isNormalPhone
            ? 80.0
            : isLargePhone
            ? 90.0
            : 100.0;

    // Icon container sizes
    final baseContainerSize =
        isSmallPhone
            ? 36.0
            : isNormalPhone
            ? 42.0
            : isLargePhone
            ? 48.0
            : 54.0;

    final selectedContainerSize =
        isSmallPhone
            ? 44.0
            : isNormalPhone
            ? 52.0
            : isLargePhone
            ? 60.0
            : 68.0;

    // Icon image sizes (slightly smaller than container)
    final baseIconSize =
        isSmallPhone
            ? 28.0
            : isNormalPhone
            ? 32.0
            : isLargePhone
            ? 36.0
            : 40.0;

    final selectedIconSize =
        isSmallPhone
            ? 34.0
            : isNormalPhone
            ? 38.0
            : isLargePhone
            ? 42.0
            : 46.0;

    // Curve and elevation parameters
    final curveHeight =
        isSmallPhone
            ? 16.0
            : isNormalPhone
            ? 20.0
            : isLargePhone
            ? 24.0
            : 28.0;

    final homeLiftHeight =
        isSmallPhone
            ? 14.0
            : isNormalPhone
            ? 18.0
            : isLargePhone
            ? 22.0
            : 26.0;

    return Container(
      height: navBarHeight,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0xFFB4B4B4),
            blurRadius: 20.0,
            spreadRadius: 0.0,
            offset: Offset(-5, -10),
          ),
        ],
      ),
      child: Stack(
        children: [
          CustomPaint(
            size: Size(screenWidth, navBarHeight),
            painter: BottomNavPainter(curveHeight: curveHeight),
          ),
          for (int i = 0; i < 5; i++)
            _buildIcon(
              context,
              i,
              screenWidth,
              navBarHeight,
              baseContainerSize,
              selectedContainerSize,
              baseIconSize,
              selectedIconSize,
              isHome: i == 2,
              isSelected: _activeIndex == i && _activeIndex != -1,
              homeLiftHeight: homeLiftHeight,
            ),
        ],
      ),
    );
  }

  Widget _buildIcon(
    BuildContext context,
    int index,
    double screenWidth,
    double navBarHeight,
    double baseContainerSize,
    double selectedContainerSize,
    double baseIconSize,
    double selectedIconSize, {
    required bool isHome,
    required bool isSelected,
    required double homeLiftHeight,
  }) {
    final iconPaths = [
      'assets/images/Qr Code.png',
      'assets/images/Calendar.png',
      'assets/images/Home.png',
      'assets/images/FAQ.png',
      'assets/images/Profile.png',
    ];

    // Calculate vertical position
    final baseTopPosition = navBarHeight * 0.32;
    final topPosition =
        isSelected && isHome
            ? baseTopPosition - homeLiftHeight
            : baseTopPosition;

    // Calculate horizontal position
    final itemWidth = screenWidth / 5;
    final leftPosition =
        (index * itemWidth) +
        (itemWidth / 2) -
        (isSelected ? selectedContainerSize : baseContainerSize) / 2;

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      top: topPosition,
      left: leftPosition,
      child: GestureDetector(
        onTap: () => _handleItemTap(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          width: isSelected ? selectedContainerSize : baseContainerSize,
          height: isSelected ? selectedContainerSize : baseContainerSize,
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFE51818) : Colors.transparent,
            shape: BoxShape.circle,
            boxShadow:
                isSelected
                    ? [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        spreadRadius: 1,
                        offset: const Offset(0, 4),
                      ),
                    ]
                    : null,
          ),
          child: Center(
            child: Image.asset(
              iconPaths[index],
              color: isSelected ? Colors.white : const Color(0xFF7D7D7D),
              width: isSelected ? selectedIconSize : baseIconSize,
              height: isSelected ? selectedIconSize : baseIconSize,
            ),
          ),
        ),
      ),
    );
  }

  void _handleItemTap(int index) {
    if (widget.onItemTapped != null) {
      setState(() {
        _activeIndex = index;
        widget.onItemTapped!(index);
      });
    }
  }
}

class BottomNavPainter extends CustomPainter {
  final double curveHeight;

  BottomNavPainter({required this.curveHeight});

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = const Color(0xFFFFFFFF)
          ..style = PaintingStyle.fill;

    final path =
        Path()
          ..moveTo(0, 0)
          ..quadraticBezierTo(
            size.width * 0.3,
            -curveHeight,
            size.width * 0.5,
            -curveHeight,
          )
          ..quadraticBezierTo(size.width * 0.7, -curveHeight, size.width, 0)
          ..lineTo(size.width, size.height)
          ..lineTo(0, size.height)
          ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

// import 'package:flutter/material.dart';

// class CustomBottomNavigationBar extends StatefulWidget {
//   final Function(int)? onItemTapped;
//   final int? selectedIndex;

//   const CustomBottomNavigationBar({
//     super.key,
//     this.onItemTapped,
//     this.selectedIndex,
//   });

//   @override
//   _CustomBottomNavigationBarState createState() =>
//       _CustomBottomNavigationBarState();
// }

// class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
//   int? _activeIndex = 0;

//   @override
//   void initState() {
//     super.initState();
//     _activeIndex = widget.selectedIndex;
//   }

//   @override
//   void didUpdateWidget(CustomBottomNavigationBar oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (widget.selectedIndex != oldWidget.selectedIndex) {
//       setState(() {
//         _activeIndex = widget.selectedIndex;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(builder: (context, constraints) {
//       final width = constraints.maxWidth;
//       // Calculate responsive height (15% of screen height or minimum 80px)
//       final height = max(MediaQuery.of(context).size.height * 0.15, 80.0);

//       return Container(
//         height: height,
//         decoration: const BoxDecoration(
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Color(0xFFB4B4B4), // Shadow color
//               blurRadius: 20.0, // Blur radius
//               spreadRadius: 0.0, // Spread radius
//               offset: Offset(-5, -10), // Offset in the y direction
//             ),
//           ],
//         ),
//         child: Stack(
//           children: [
//             // CustomPaint will rebuild because it's part of the widget tree that uses the state
//             CustomPaint(
//               size: Size(width, height),
//               painter: BottomNavPainter(selectedIndex: _activeIndex),
//             ),
//             for (int i = 0; i < 5; i++) _buildIcon(context, i, width, height),
//           ],
//         ),
//       );
//     });
//   }

//   Widget _buildIcon(
//       BuildContext context, int index, double width, double height) {
//     List<String> iconPaths = [
//       'assets/images/Qr Code.png',
//       'assets/images/Calendar.png',
//       'assets/images/Home.png',
//       'assets/images/FAQ.png',
//       'assets/images/Profile.png',
//     ];

//     // No highlight when selectedIndex == -1
//     final isSelected = _activeIndex == index && _activeIndex != -1;
//     final isHome = index == 2;

//     // Calculate responsive dimensions
//     final iconSize = width * 0.12; // 12% of screen width
//     final selectedIconSize = width * 0.14; // 14% of screen width
//     final topPadding = height * 0.29; // 29% of nav bar height

//     return AnimatedPositioned(
//       duration: const Duration(milliseconds: 300),
//       curve: Curves.easeInOut,
//       // Move home icon to top of curve when selected
//       top: isSelected && isHome ? 0 : topPadding,
//       // Position horizontally based on screen width
//       left: (index * (width / 5)) +
//           (width / 10 - (isSelected ? selectedIconSize : iconSize) / 2),
//       child: GestureDetector(
//         onTap: () {
//           if (widget.onItemTapped != null) {
//             setState(() {
//               _activeIndex = index;
//               widget.onItemTapped!(index); // Notify the parent
//             });
//           }
//         },
//         child: AnimatedContainer(
//           duration: const Duration(milliseconds: 300),
//           curve: Curves.easeInOut,
//           width: isSelected ? selectedIconSize : iconSize,
//           height: isSelected ? selectedIconSize : iconSize,
//           decoration: BoxDecoration(
//             color: isSelected ? const Color(0xFFE51818) : Colors.transparent,
//             shape: BoxShape.circle,
//           ),
//           child: Center(
//             child: Image.asset(
//               iconPaths[index],
//               color: isSelected ? Colors.white : Colors.grey,
//               width: isSelected ? selectedIconSize * 0.9 : iconSize * 0.9,
//               height: isSelected ? selectedIconSize * 0.9 : iconSize * 0.9,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class BottomNavPainter extends CustomPainter {
//   final int? selectedIndex;

//   BottomNavPainter({required this.selectedIndex});

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = const Color(0xFFFFFFFF) // White color for the background
//       ..style = PaintingStyle.fill;

//     final path = Path();

//     // Define the curve control points for a smooth, symmetrical shape using relative sizing
//     double leftCurveControlX = size.width * 0.3; // 30% from left edge
//     double leftCurveControlY = size.height * -0.2; // 20% above the top edge
//     double rightCurveControlX = size.width * 0.7; // 70% from left edge
//     double rightCurveControlY = size.height * -0.2; // 20% above the top edge
//     double centerDip = size.height * -0.2; // How deep the center dip goes

//     // Draw the navigation bar shape with a symmetrical top curve
//     path.moveTo(0, 0); // Start at the top-left corner
//     path.quadraticBezierTo(leftCurveControlX, leftCurveControlY,
//         size.width * 0.5, centerDip); // Left curve
//     path.quadraticBezierTo(
//         rightCurveControlX, rightCurveControlY, size.width, 0); // Right curve
//     path.lineTo(size.width, size.height); // Extend to the bottom-right corner
//     path.lineTo(0, size.height); // Extend to the bottom-left corner
//     path.close();

//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return true; // Repaint whenever the selected index changes
//   }
// }

// // Helper function to get maximum value
// double max(double a, double b) {
//   return a > b ? a : b;
// }

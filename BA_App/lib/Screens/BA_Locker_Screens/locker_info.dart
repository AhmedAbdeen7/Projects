// import 'package:flutter/material.dart';

// class LockerInfoPage extends StatelessWidget {
//   final int lockerId;

//   const LockerInfoPage({Key? key, required this.lockerId}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = MediaQuery.of(context).size.height;
//     double screenWidth = MediaQuery.of(context).size.width;

//     return Scaffold(
//       appBar: AppBar(
//         title: Row(
//           children: [
//             Image.asset('assets/images/BA_Logo.png', height: 40),
//             const Spacer(),
//           ],
//         ),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.symmetric(
//           horizontal: screenWidth * 0.05, // 5% of screen width
//           vertical: screenHeight * 0.03, // 3% of screen height
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             Center(
//               child: Text(
//                 'Locker Booking',
//                 style: TextStyle(
//                   fontFamily: 'Alegreya',
//                   color: const Color.fromARGB(255, 124, 15, 7),
//                   fontWeight: FontWeight.bold,
//                   fontSize: screenHeight * 0.05,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//             SizedBox(height: screenHeight * 0.02),
//             Image.asset(
//               'assets/images/Lockers.png',
//               width: screenWidth * 0.9,
//               height: screenHeight * 0.4, // Adaptive height
//               fit: BoxFit.cover,
//             ),
//             SizedBox(height: screenHeight * 0.03),
//             Center(
//               child: Container(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 24,
//                   vertical: 24,
//                 ),
//                 decoration: BoxDecoration(
//                   color: const Color.fromARGB(255, 238, 41, 27),
//                   borderRadius: BorderRadius.circular(25),
//                 ),
//                 child: Text(
//                   'Your locker number is\n $lockerId',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: screenWidth * 0.08,
//                     fontFamily: "Poppins",
//                     fontWeight: FontWeight.w600,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             ),
//             SizedBox(height: screenHeight * 0.05), // Extra padding for spacing
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:ba_app/Screens/mainscreen.dart';
import 'package:flutter/material.dart';
import 'package:ba_app/Screens/Navigation_Bar_Screens/homepage.dart';

class LockerInfoPage extends StatelessWidget {
  final int lockerId;

  const LockerInfoPage({Key? key, required this.lockerId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize:
              MainAxisSize
                  .min, // Ensures Row only takes as much space as needed
          children: [
            SizedBox(
              height:
                  kToolbarHeight * 0.8, // Adjust height based on AppBar size
              child: Image.asset('assets/images/BA_Logo.png'),
            ),
            const Spacer(), // Keep the spacer if needed
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => MainScreen()),
              (route) => false, // Removes all previous screens from the stack
            );
          },
        ),
      ),

      body: LayoutBuilder(
        builder: (context, constraints) {
          // Use the smaller dimension to maintain proportions
          final baseSize =
              constraints.maxHeight < constraints.maxWidth
                  ? constraints.maxHeight
                  : constraints.maxWidth;

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: baseSize * 0.05,
              vertical: baseSize * 0.03,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Center(
                    child: Text(
                      'Locker Booking',
                      style: TextStyle(
                        fontFamily: 'Alegreya',
                        color: const Color.fromARGB(255, 124, 15, 7),
                        fontWeight: FontWeight.bold,
                        fontSize: baseSize * 0.05,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: baseSize * 0.02),
                  AspectRatio(
                    aspectRatio:
                        16 / 9, // Standard widescreen aspect ratio for image
                    child: Image.asset(
                      'assets/images/Lockers.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: baseSize * 0.03),
                  Center(
                    child: FractionallySizedBox(
                      widthFactor: 0.8, // Takes 80% of available width
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: baseSize * 0.05,
                          vertical: baseSize * 0.05,
                        ),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 238, 41, 27),
                          borderRadius: BorderRadius.circular(baseSize * 0.04),
                        ),
                        child: Text(
                          'Your locker number is\n $lockerId',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: baseSize * 0.06, // Slightly smaller font
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: baseSize * 0.05),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

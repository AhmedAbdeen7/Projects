// import 'package:flutter/material.dart';

// class Locker extends StatelessWidget {
//   const Locker({super.key});
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Scaffold(
//       appBar: AppBar(
//         title: Row(
//           children: [
//             Image.asset(
//               'assets/images/BA_Logo.png', // Path to your image asset
//               height: 40, // Adjust the height as needed
//             ),
//           ],
//         ),
//         backgroundColor: Colors.white, // Optional: change background color
//       ),
//       body: SingleChildScrollView(
//         // Wrap the Column in a SingleChildScrollView
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment:
//               CrossAxisAlignment.stretch, // Ensure children fill the width
//           children: <Widget>[
//             // Image Section
//             Image.asset(
//               'assets/images/Lockers.png', // Replace with your image asset
//               height: 300, // Adjust as needed
//               fit: BoxFit.cover,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: <Widget>[
//                   const Text(
//                     '🎉 Exciting news from the BA!\nLockers on the first floor of BEC are now available for monthly booking!',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 10),
//                   const Text(
//                     'Secure yours today and keep your stuff safe in style! 🔐💼',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 20),
//                   LayoutBuilder(
//                     builder:
//                         (BuildContext context, BoxConstraints constraints) {
//                       // Calculate button width based on screen width
//                       double buttonWidth =
//                           constraints.maxWidth * 0.6; // Adjust factor as needed
//                       double buttonPaddingHorizontal =
//                           constraints.maxWidth * 0.1;
//                       double buttonHeight = 60.0;
//                       return ElevatedButton(
//                         onPressed: () {
//                           Navigator.pushNamed(context, '/lockers_booking');
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.redAccent[200],
//                           padding: EdgeInsets.symmetric(
//                               horizontal: buttonPaddingHorizontal,
//                               vertical:
//                                   0), //Remove Vertical Padding, now the height is fixed
//                           textStyle: const TextStyle(fontSize: 18),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(30.0),
//                           ),
//                           minimumSize: Size(buttonWidth,
//                               buttonHeight), // Set width and height
//                         ),
//                         child: const Text(
//                           'Book Now',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class Locker extends StatelessWidget {
  const Locker({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize:
              MainAxisSize.min, // Ensures the Row wraps its content properly
          children: [
            SizedBox(
              height: kToolbarHeight * 0.8, // Give a fixed height
              child: Image.asset('assets/images/BA_Logo.png'),
            ),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Use the smaller dimension to maintain proportions
          final baseSize =
              constraints.maxHeight < constraints.maxWidth
                  ? constraints.maxHeight
                  : constraints.maxWidth;

          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // Image Section with fixed aspect ratio
                AspectRatio(
                  aspectRatio: 16 / 9, // Standard widescreen aspect ratio
                  child: Image.asset(
                    'assets/images/Lockers.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(baseSize * 0.04),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '🎉 Exciting news from the BA!\nLockers on the first floor of BEC are now available for monthly booking!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: baseSize * 0.035,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: baseSize * 0.02),
                      Text(
                        'Secure yours today and keep your stuff safe in style! 🔐💼',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: baseSize * 0.035,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: baseSize * 0.04),
                      FractionallySizedBox(
                        widthFactor: 0.6, // 60% of available width
                        child: Container(
                          height: baseSize * 0.12, // 12% of base size
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              baseSize * 0.06,
                            ),
                            color: Colors.redAccent[200],
                          ),
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/lockers_booking');
                            },
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  baseSize * 0.06,
                                ),
                              ),
                            ),
                            child: Text(
                              'Book Now',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: baseSize * 0.04,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

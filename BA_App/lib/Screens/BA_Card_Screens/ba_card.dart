import 'package:flutter/material.dart';
import 'package:ba_app/Screens/BA_Card_Screens/ba_card_apparel.dart';
import 'package:ba_app/Screens/BA_Card_Screens/ba_card_f_b.dart';
import 'package:ba_app/Screens/BA_Card_Screens/ba_card_well_being.dart';
import 'package:ba_app/Screens/BA_Card_Screens/ba_card_supermarkets.dart';
import 'package:ba_app/Screens/BA_Card_Screens/ba_card_sports.dart';
import 'package:ba_app/Screens/BA_Card_Screens/ba_card_entertainment.dart';
import 'package:ba_app/Screens/BA_Card_Screens/ba_card_services.dart';

class BACardScreen extends StatelessWidget {
  const BACardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/BA_Logo.png',
              height:
                  (MediaQuery.of(context).size.height > 750)
                      ? MediaQuery.of(context).size.height * 0.1
                      : 40,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.15,
                ), // Add left padding here
                child: Text(
                  'BA Card',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize:
                        (MediaQuery.of(context).size.height > 900)
                            ? MediaQuery.of(context).size.height * 0.04
                            : 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFDE1B1B),
                  ),
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Use the minimum of width or height to determine sizes
          final baseSize =
              constraints.maxWidth < constraints.maxHeight
                  ? constraints.maxWidth
                  : constraints.maxHeight;

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(baseSize * 0.04), // 4% padding
              child: Column(
                children: [
                  // Top Image
                  Container(
                    width: double.infinity,
                    height: baseSize * 0.3, // 30% of base size
                    margin: EdgeInsets.only(bottom: baseSize * 0.04),
                    child: Image.asset(
                      "assets/images/ba_card/BA_Card.png",
                      fit: BoxFit.contain,
                    ),
                  ),

                  // Grid of Categories
                  GridView.count(
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: baseSize * 0.03, // 3% spacing
                    crossAxisSpacing: baseSize * 0.03, // 3% spacing
                    childAspectRatio: 0.85, // Slightly taller than wide
                    children: [
                      _buildCategoryButton(
                        context,
                        baseSize,
                        "assets/images/ba_card/F&B.png",
                        "F&B",
                        BaCardF_B(),
                      ),
                      _buildCategoryButton(
                        context,
                        baseSize,
                        "assets/images/ba_card/Supermarket.png",
                        "Supermarkets",
                        const BaCardSupermarkets(),
                      ),
                      _buildCategoryButton(
                        context,
                        baseSize,
                        "assets/images/ba_card/Sport.png",
                        "Sports",
                        const BaCardSports(),
                      ),
                      _buildCategoryButton(
                        context,
                        baseSize,
                        "assets/images/ba_card/Services.png",
                        "Services",
                        const BaCardServices(),
                      ),
                      _buildCategoryButton(
                        context,
                        baseSize,
                        "assets/images/ba_card/Apparel.png",
                        "Apparel",
                        const BaCardApparel(),
                      ),
                      _buildCategoryButton(
                        context,
                        baseSize,
                        "assets/images/ba_card/Entertainment.png",
                        "Entertainment",
                        const BaCardEntertainment(),
                      ),
                    ],
                  ),

                  // Wellness Button
                  Padding(
                    padding: EdgeInsets.only(top: baseSize * 0.05),
                    child: _buildCategoryButton(
                      context,
                      baseSize,
                      "assets/images/ba_card/Wellness.png",
                      "Wellness",
                      const BaCardBeauty(),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategoryButton(
    BuildContext context,
    double baseSize,
    String imagePath,
    String label,
    Widget destination,
  ) {
    final buttonSize = baseSize * 0.22; // 22% of base size

    return InkWell(
      onTap:
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (ctx) => destination),
          ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: buttonSize,
            height: buttonSize,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(buttonSize * 0.15),
                child: Image.asset(imagePath, fit: BoxFit.contain),
              ),
            ),
          ),
          SizedBox(height: buttonSize * 0.05),
          SizedBox(
            width: buttonSize * 1.5,
            child: Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: baseSize * 0.035, // 3.5% of base size
                fontWeight: FontWeight.bold,
                color: const Color(0xFF8B8181),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:ba_app/Screens/BA_Card_Screens/ba_card_apparel.dart';
// import 'package:ba_app/Screens/BA_Card_Screens/ba_card_f_b.dart';
// import 'package:ba_app/Screens/BA_Card_Screens/ba_card_well_being.dart';
// import 'package:ba_app/Screens/BA_Card_Screens/ba_card_supermarkets.dart';
// import 'package:ba_app/Screens/BA_Card_Screens/ba_card_sports.dart';
// import 'package:ba_app/Screens/BA_Card_Screens/ba_card_entertainment.dart';
// import 'package:ba_app/Screens/BA_Card_Screens/ba_card_services.dart';

// class BACardScreen extends StatelessWidget {
//   const BACardScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;

//     return Scaffold(
//       appBar: AppBar(
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Image.asset('assets/images/BA_Logo.png', height: 40),
//             Flexible(
//               child: Center(
//                 child: Text(
//                   'BA Card',
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(
//                     fontSize:
//                         screenWidth < 360 ? 24 : 30, // Responsive font size
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xFFDE1B1B),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         backgroundColor: Colors.white,
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8.0),
//             child: Column(
//               children: [
//                 // Top Image with AspectRatio for consistency
//                 AspectRatio(
//                   aspectRatio: 16 / 9,
//                   child: Container(
//                     margin: const EdgeInsets.symmetric(vertical: 10),
//                     child: FittedBox(
//                       fit: BoxFit.contain,
//                       child: Image.asset("assets/images/ba_card/BA_Card.png"),
//                     ),
//                   ),
//                 ),

//                 // Responsive GridView
//                 GridView.builder(
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: screenWidth > 600 ? 4 : 3,
//                     childAspectRatio: 0.9, // Slightly taller than wide
//                     crossAxisSpacing: 10,
//                     mainAxisSpacing: 15,
//                   ),
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   padding: EdgeInsets.all(screenWidth < 360 ? 8 : 16),
//                   itemCount: 6,
//                   itemBuilder: (context, index) {
//                     // Category data arrays
//                     final List<String> imagePaths = [
//                       "assets/images/ba_card/F&B.png",
//                       "assets/images/ba_card/Supermarket.png",
//                       "assets/images/ba_card/Sport.png",
//                       "assets/images/ba_card/Services.png",
//                       "assets/images/ba_card/Apparel.png",
//                       "assets/images/ba_card/Entertainment.png",
//                     ];
//                     final List<String> labels = [
//                       "F&B",
//                       "Supermarkets",
//                       "Sports",
//                       "Services",
//                       "Apparel",
//                       "Entertainment",
//                     ];
//                     final List<Widget> destinations = [
//                       BaCardF_B(),
//                       const BaCardSupermarkets(),
//                       const BaCardSports(),
//                       const BaCardServices(),
//                       const BaCardApparel(),
//                       const BaCardEntertainment(),
//                     ];

//                     return _buildCategoryButton(
//                       context,
//                       imagePaths[index],
//                       labels[index],
//                       destinations[index],
//                     );
//                   },
//                 ),

//                 // Centered bottom widget (Wellness)
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 20),
//                   child: _buildCategoryButton(
//                     context,
//                     "assets/images/ba_card/Wellness.png",
//                     "Wellness",
//                     const BaCardBeauty(),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // Responsive category button builder
//   Widget _buildCategoryButton(
//     BuildContext context,
//     String imagePath,
//     String label,
//     Widget destination,
//   ) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     // Adaptive sizing based on screen width
//     final buttonSize = (screenWidth / (screenWidth > 600 ? 8 : 5)).clamp(
//       60.0,
//       90.0,
//     );

//     return InkWell(
//       onTap:
//           () => Navigator.push(
//             context,
//             MaterialPageRoute(builder: (ctx) => destination),
//           ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             width: buttonSize,
//             height: buttonSize,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               shape: BoxShape.circle,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.5),
//                   spreadRadius: 2,
//                   blurRadius: 5,
//                   offset: const Offset(0, 3),
//                 ),
//               ],
//             ),
//             child: Center(
//               child: FittedBox(
//                 fit: BoxFit.contain,
//                 child: Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: Image.asset(imagePath),
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 4),
//           Container(
//             width: buttonSize * 1.2,
//             child: Text(
//               label,
//               maxLines: 1,
//               textAlign: TextAlign.center,
//               overflow: TextOverflow.ellipsis,
//               style: TextStyle(
//                 fontSize: screenWidth < 360 ? 14 : 16,
//                 color: Color(0xFF8B8181),
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // import 'package:flutter/material.dart';
// // import 'package:ba_app/Screens/Ba_card/ba_card_apparel.dart';
// // import 'package:ba_app/Screens/Ba_card/ba_card_f_b.dart';
// // import 'package:ba_app/Screens/Ba_card/ba_card_well_being.dart';
// // import 'package:ba_app/Screens/Ba_card/ba_card_supermarkets.dart';
// // import 'package:ba_app/Screens/Ba_card/ba_card_sports.dart';
// // import 'package:ba_app/Screens/Ba_card/ba_card_entertainment.dart';
// // import 'package:ba_app/Screens/Ba_card/ba_card_services.dart';

// // class BACardScreen extends StatelessWidget {
// //   const BACardScreen({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     final screenWidth = MediaQuery.of(context).size.width;
// //     final screenHeight = MediaQuery.of(context).size.height;

// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Row(
// //           children: [
// //             Image.asset(
// //               'assets/images/BA_Logo.png',
// //               height: 40,
// //             ),
// //             const SizedBox(width: 50),
// //             const Text(
// //               'BA Card',
// //               style: TextStyle(
// //                 fontSize: 30,
// //                 fontWeight: FontWeight.bold,
// //                 color: Color(0xFFDE1B1B),
// //               ),
// //             ),
// //           ],
// //         ),
// //         backgroundColor: Colors.white,
// //       ),
// //       body: SingleChildScrollView(
// //         child: Column(
// //           children: [
// //             // Top Image
// //             Container(
// //               width: screenWidth * 0.8,
// //               height: screenHeight * 0.25,
// //               margin: const EdgeInsets.symmetric(vertical: 20),
// //               child: Image.asset(
// //                 "assets/images/ba_card/BA_Card.png",
// //                 fit: BoxFit.contain,
// //               ),
// //             ),

// //             // Grid of Categories
// //             GridView.count(
// //               crossAxisCount: 3, // 3 items per row
// //               shrinkWrap: true,
// //               physics: const NeverScrollableScrollPhysics(),
// //               padding: const EdgeInsets.all(16),
// //               mainAxisSpacing: 20,
// //               crossAxisSpacing: 20,
// //               children: [
// //                 _buildCategoryButton(
// //                   context,
// //                   "assets/images/ba_card/F&B.png",
// //                   "F&B",
// //                   BaCardF_B(),
// //                 ),
// //                 _buildCategoryButton(
// //                   context,
// //                   "assets/images/ba_card/Supermarket.png",
// //                   "Supermarkets",
// //                   const BaCardSupermarkets(),
// //                 ),
// //                 _buildCategoryButton(
// //                   context,
// //                   "assets/images/ba_card/Sport.png",
// //                   "Sports",
// //                   const BaCardSports(),
// //                 ),
// //                 _buildCategoryButton(
// //                   context,
// //                   "assets/images/ba_card/Services.png",
// //                   "Services",
// //                   const BaCardServices(),
// //                 ),
// //                 _buildCategoryButton(
// //                   context,
// //                   "assets/images/ba_card/Apparel.png",
// //                   "Apparel",
// //                   const BaCardApparel(),
// //                 ),
// //                 _buildCategoryButton(
// //                   context,
// //                   "assets/images/ba_card/Entertainment.png",
// //                   "Entertainment",
// //                   const BaCardEntertainment(),
// //                 ),
// //               ],
// //             ),

// //             // Center Bottom Widget (Wellness)
// //             Container(
// //               margin: const EdgeInsets.only(top: 20, bottom: 40),
// //               child: _buildCategoryButton(
// //                 context,
// //                 "assets/images/ba_card/Wellness.png",
// //                 "Wellness",
// //                 const BaCardBeauty(),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   // Helper method to build a category button
// //   Widget _buildCategoryButton(
// //     BuildContext context,
// //     String imagePath,
// //     String label,
// //     Widget destination,
// //   ) {
// //     return InkWell(
// //       onTap: () => Navigator.push(
// //         context,
// //         MaterialPageRoute(builder: (ctx) => destination),
// //       ),
// //       child: Column(
// //         children: [
// //           Container(
// //             width: 80,
// //             height: 80,
// //             decoration: BoxDecoration(
// //               color: Colors.white,
// //               shape: BoxShape.circle,
// //               boxShadow: [
// //                 BoxShadow(
// //                   color: Colors.grey.withOpacity(0.5),
// //                   spreadRadius: 2,
// //                   blurRadius: 5,
// //                   offset: const Offset(0, 3),
// //                 ),
// //               ],
// //             ),
// //             child: Center(
// //               child: Image.asset(imagePath),
// //             ),
// //           ),
// //           const SizedBox(height: 8),
// //           Text(
// //             label,
// //             style: const TextStyle(
// //               fontSize: 16,
// //               color: Color(0xFF8B8181),
// //               fontWeight: FontWeight.bold,
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

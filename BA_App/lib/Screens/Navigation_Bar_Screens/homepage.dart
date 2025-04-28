import 'package:flutter/material.dart';
import 'package:ba_app/Screens/Other_Screens/Declaration_page.dart';
import 'package:ba_app/Screens/Other_Screens/coming_soon.dart';
import 'package:ba_app/Screens/BA_Card_Screens/ba_card.dart';
import 'package:ba_app/Screens/BA_Locker_Screens/locker.dart';
import 'package:ba_app/Screens/Other_Screens/ba_notes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final List<String> _baCardImages = [
    'assets/images/BA Card.png',
    'assets/images/ELfar_scroll.png',
    'assets/images/1980_scroll.png',
    "assets/images/Jimmy's_scroll.png",
    'assets/images/Gyoza_scroll.png',
  ];

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;

    // Calculate text scaling factor
    double getTextScaleFactor() {
      if (screenHeight < 600) return 0.9; // Small phones
      if (screenHeight < 800) return 1.0; // Normal phones
      if (screenHeight < 1000) return 1.2; // Large phones/small tablets
      return 1.5; // 10-inch tablets and larger
    }

    final textScaleFactor = getTextScaleFactor();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.04,
              vertical: screenHeight * 0.02,
            ),
            child: Column(
              children: [
                // Logo
                Center(
                  child: Image.asset(
                    "assets/images/BA_Logo.png",
                    height: screenHeight * 0.08,
                    fit: BoxFit.contain,
                  ),
                ),

                SizedBox(height: screenHeight * 0.03),

                // Featured Announcements
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Featured Announcements:",
                    style: TextStyle(
                      fontSize: 18 * textScaleFactor,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),

                SizedBox(height: screenHeight * 0.02),

                // Coming Soon Box
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.03,
                    horizontal: screenWidth * 0.05,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFAF3033),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    "Coming Soon",
                    style: TextStyle(
                      fontSize: 28 * textScaleFactor,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                SizedBox(height: screenHeight * 0.04),

                // Dashboard Section
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Dashboard",
                    style: TextStyle(
                      fontSize: 18 * textScaleFactor,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),

                SizedBox(height: screenHeight * 0.02),

                // Dashboard Grid
                GridView.count(
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: 0.85,
                  children: [
                    _buildDashboardItem(
                      imagePath: "assets/images/locker.webp",
                      title: "Locker\nBooking",
                      onTap:
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const Locker()),
                          ),
                      imageHeight: screenHeight * 0.08,
                      textSize: 12 * textScaleFactor,
                    ),
                    _buildDashboardItem(
                      imagePath: "assets/images/Package.png",
                      title: "BA\nPacks",
                      onTap:
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ComingSoon(),
                            ),
                          ),
                      imageHeight: screenHeight * 0.08,
                      textSize: 12 * textScaleFactor,
                    ),
                    _buildDashboardItem(
                      imagePath: "assets/images/BA_notes.png",
                      title: "BA\nNotes",
                      onTap:
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => Ba_Notes()),
                          ),
                      imageHeight: screenHeight * 0.08,
                      textSize: 12 * textScaleFactor,
                    ),
                    _buildDashboardItem(
                      imagePath: "assets/images/computer.png",
                      title: "Registration",
                      onTap:
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ComingSoon(),
                            ),
                          ),
                      imageHeight: screenHeight * 0.08,
                      textSize: 12 * textScaleFactor,
                    ),
                    _buildDashboardItem(
                      imagePath: "assets/images/Declaration_guide.png",
                      title: "Declaration\nGuide",
                      onTap:
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DeclarationPage(),
                            ),
                          ),
                      imageHeight: screenHeight * 0.08,
                      textSize: 12 * textScaleFactor,
                    ),
                    _buildDashboardItem(
                      imagePath: "assets/images/syllabus.png",
                      title: "Syllabus",
                      onTap:
                          () =>
                              Navigator.pushNamed(context, '/syllabus_depart'),
                      imageHeight: screenHeight * 0.08,
                      textSize: 12 * textScaleFactor,
                    ),
                  ],
                ),

                SizedBox(height: screenHeight * 0.04),

                // BA Card Section
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "BA Card",
                        style: TextStyle(
                          fontSize: 18 * textScaleFactor,
                          // fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                      InkWell(
                        onTap:
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const BACardScreen(),
                              ),
                            ),
                        child: Text(
                          "View More",
                          style: TextStyle(
                            color: const Color(0xFF70B9BE),
                            fontSize: 14 * textScaleFactor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: screenHeight * 0.22,
                  child: PageView.builder(
                    itemCount: _baCardImages.length + 1, // +1 for "View All"
                    itemBuilder: (context, index) {
                      if (index == _baCardImages.length) {
                        return InkWell(
                          onTap:
                              () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const BACardScreen(),
                                ),
                              ),
                          child: _buildViewAllCard(
                            screenWidth,
                            textScaleFactor,
                          ),
                        );
                      }
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: _buildBACardItem(_baCardImages[index]),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDashboardItem({
    required String imagePath,
    required String title,
    required VoidCallback onTap,
    required double imageHeight,
    required double textSize,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: imageHeight * 1.4,
            width: imageHeight * 1.4,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/Style.png'),
                fit: BoxFit.contain,
              ),
            ),
            child: Center(
              child: Image.asset(
                imagePath,
                height: imageHeight,
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: textSize,
              fontStyle: FontStyle.normal,
              color: Color(0xFF2F394E),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBACardItem(String imagePath) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(imagePath, fit: BoxFit.contain),
      ),
    );
  }

  Widget _buildViewAllCard(double screenWidth, double textScaleFactor) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (ctx) => (const BACardScreen())),
                );
              },
              child: Text(
                'View All',
                style: TextStyle(
                  fontSize: screenWidth * 0.1,
                  color: const Color(0xFFE51818),
                  fontWeight: FontWeight.bold,
                  fontFamily: "Moul",
                  shadows: [
                    Shadow(
                      offset: const Offset(2.0, 2.0),
                      blurRadius: 3.0,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: screenWidth * 0.02),
            Icon(
              Icons.arrow_forward,
              color: const Color(0xFFE51818),
              size: screenWidth * 0.1,
            ),
          ],
        ),
      ),
    );
  }
}
// import 'package:ba_app/Screens/Other_Screens/Declaration_page.dart';
// import 'package:flutter/material.dart';
// import 'package:ba_app/Screens/Other_Screens/coming_soon.dart';
// import 'package:ba_app/Screens/BA_Card_Screens/ba_card.dart';
// import 'dart:async';

// // import 'package:ba_app/Registration/registration.dart';
// import 'package:ba_app/Screens/BA_Locker_Screens/locker.dart';
// import 'package:ba_app/Screens/Other_Screens/ba_notes.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => HomeScreenState();
// }

// class HomeScreenState extends State<HomeScreen> {
//   int _selectedIndex = 2;
//   final PageController _pageController = PageController(initialPage: 1000);
//   late Timer _timer;

//   // Navigation functions
//   void navigateToCustomPage(Widget page) {
//     Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));
//   }

//   void navigateToFullScreenPage(Widget page) {
//     Navigator.of(
//       context,
//       rootNavigator: true,
//     ).push(MaterialPageRoute(builder: (context) => page));
//   }

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   void _tapWidget(BuildContext context) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (ctx) => const ComingSoon()),
//     );
//   }

//   @override
//   void initState() {
//     super.initState();

//     // Start the auto-scroll timer
//     _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
//       _pageController.nextPage(
//         duration: const Duration(milliseconds: 400),
//         curve: Curves.easeInOut,
//       );
//     });
//   }

//   @override
//   void dispose() {
//     // Dispose the timer and page controller to prevent memory leaks
//     _timer.cancel();
//     _pageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Get the screen dimensions
//     final Size screenSize = MediaQuery.of(context).size;
//     final double screenWidth = screenSize.width;
//     final double screenHeight = screenSize.height;

//     // Custom navigation bar height is 120 pixels based on your code
//     final double navBarHeight = 120.0;

//     return Scaffold(
//       body: SafeArea(
//         child: ListView(
//           // Add padding to account for your custom navigation bar
//           padding: EdgeInsets.only(
//             left: screenWidth * 0.04,
//             right: screenWidth * 0.04,
//             bottom: navBarHeight + 10, // Add extra 10px for safety
//           ),
//           children: [
//             // Logo section
//             SizedBox(height: screenHeight * 0.02),
//             Image.asset(
//               "assets/images/BA_Logo.png",
//               height: screenHeight * 0.08,
//             ),

//             SizedBox(height: screenHeight * 0.02),

//             // Featured Announcements section
//             const Text(
//               "Featured Announcements:",
//               style: TextStyle(fontSize: 18, fontStyle: FontStyle.normal),
//             ),

//             SizedBox(height: screenHeight * 0.02),

//             // Coming Soon box
//             Center(
//               child: Container(
//                 width: screenWidth * 0.85,
//                 padding: EdgeInsets.symmetric(
//                   vertical: screenHeight * 0.04,
//                   horizontal: screenWidth * 0.04,
//                 ),
//                 decoration: BoxDecoration(
//                   color: const Color(0xFFAF3033),
//                   borderRadius: BorderRadius.circular(16.0),
//                   boxShadow: const [
//                     BoxShadow(
//                       color: Colors.grey,
//                       blurRadius: 8.0,
//                       offset: Offset(0, 4),
//                     ),
//                   ],
//                 ),
//                 child: const Text(
//                   "Coming Soon",
//                   style: TextStyle(
//                     fontSize: 35.0,
//                     fontFamily: 'Alegreya',
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xFFFFFFFF),
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             ),

//             SizedBox(height: screenHeight * 0.03),

//             // Dashboard section
//             const Text("Dashboard", style: TextStyle(fontSize: 20)),

//             SizedBox(height: screenHeight * 0.02),

//             // Dashboard grid
//             GridView.count(
//               crossAxisCount: 3,
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               childAspectRatio: 0.85,
//               children: [
//                 // Locker Booking
//                 _buildDashboardItem(
//                   context: context,
//                   imagePath: "assets/images/locker.webp",
//                   title: "Locker\nBooking",
//                   onTap:
//                       () => navigateToCustomPage(
//                         const Locker(),
//                       ), // Navigate to LockerScreen
//                   backgroundImage: 'assets/images/Style.png',
//                 ),

//                 // BA Packs
//                 _buildDashboardItem(
//                   context: context,
//                   imagePath: "assets/images/Package.png",
//                   title: "BA\nPacks",
//                   onTap: () => _tapWidget(context),
//                   backgroundImage: 'assets/images/Style.png',
//                 ),

//                 // BA Notes
//                 _buildDashboardItem(
//                   context: context,
//                   imagePath: "assets/images/BA_notes.png",
//                   title: "BA\nNotes",
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (ctx) => Ba_Notes()),
//                     );
//                   },
//                   backgroundImage: 'assets/images/Style.png',
//                 ),

//                 // Registration
//                 _buildDashboardItem(
//                   context: context,
//                   imagePath: "assets/images/computer.png",
//                   title: "Registration",
//                   onTap: () => _tapWidget(context),
//                   backgroundImage: 'assets/images/Style.png',
//                 ),

//                 // Declaration Guide
//                 _buildDashboardItem(
//                   context: context,
//                   imagePath: "assets/images/Declaration_guide.png",
//                   title: "Declaration\nGuide",
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (ctx) => DeclarationPage()),
//                     );
//                   },
//                   backgroundImage: 'assets/images/Style.png',
//                 ),

//                 // Syllabus
//                 _buildDashboardItem(
//                   context: context,
//                   imagePath: "assets/images/syllabus.png",
//                   title: "Syllabus",
//                   onTap: () {
//                     Navigator.pushNamed(context, '/syllabus_depart');
//                   },
//                   backgroundImage: 'assets/images/Style.png',
//                 ),
//               ],
//             ),

//             SizedBox(height: screenHeight * 0.03),

//             // BA Card section
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text("BA Card", style: TextStyle(fontSize: 20)),
//                 InkWell(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (ctx) => (const BACardScreen()),
//                       ),
//                     );
//                   },
//                   child: const Text(
//                     "View More",
//                     style: TextStyle(
//                       color: Color(0xFF70B9BE),
//                       fontSize: 14,
//                       fontFamily: "Lato",
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ],
//             ),

//             SizedBox(height: screenHeight * 0.02),

//             // BA Card horizontal list
//             SizedBox(
//               height: screenHeight * 0.2,
//               child: PageView.builder(
//                 controller: PageController(),
//                 scrollDirection: Axis.horizontal,
//                 physics: const BouncingScrollPhysics(),
//                 itemBuilder: (context, index) {
//                   final repeatedIndex = index % _imagePaths.length;
//                   return Padding(
//                     padding: EdgeInsets.symmetric(
//                       horizontal: screenWidth * 0.02,
//                     ),
//                     child: _buildImageItem(
//                       _imagePaths[repeatedIndex],
//                       screenWidth,
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Helper method to build dashboard items
//   Widget _buildDashboardItem({
//     required BuildContext context,
//     required String imagePath,
//     required String title,
//     required VoidCallback onTap,
//     String? backgroundImage,
//   }) {
//     return Column(
//       children: [
//         InkWell(
//           onTap: onTap,
//           child: Stack(
//             alignment: Alignment.center,
//             children: [
//               if (backgroundImage != null) Image.asset(backgroundImage),
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(10.0),
//                 child: Image.asset(
//                   imagePath,
//                   height: MediaQuery.of(context).size.height * 0.08,
//                   fit: BoxFit.contain,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(height: 8),
//         Text(
//           title,
//           textAlign: TextAlign.center,
//           style: const TextStyle(fontSize: 12),
//         ),
//       ],
//     );
//   }

//   final List<String> _imagePaths = [
//     'assets/images/BA Card.png',
//     'assets/images/ELfar_scroll.png',
//     'assets/images/1980_scroll.png',
//     "assets/images/Jimmy's_scroll.png",
//     'assets/images/Gyoza_scroll.png',
//     'assets/images/View_All.png',
//   ];

//   Widget _buildImageItem(String imagePath, double screenWidth) {
//     if (imagePath == 'assets/images/ELfar_scroll.png') {
//       return Container(
//         width: screenWidth * 0.8,
//         decoration: BoxDecoration(
//           color: const Color.fromARGB(255, 255, 255, 255),
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(40),
//           child: Image.asset(imagePath, fit: BoxFit.contain),
//         ),
//       );
//     } else if (imagePath == 'assets/images/View_All.png') {
//       return Container(
//         width: screenWidth * 0.85,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(20.0),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.5),
//               spreadRadius: 2,
//               blurRadius: 5,
//               offset: const Offset(0, 3),
//             ),
//           ],
//         ),
//         child: Center(
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               InkWell(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (ctx) => (const BACardScreen())),
//                   );
//                 },
//                 child: Text(
//                   'View All',
//                   style: TextStyle(
//                     fontSize: screenWidth * 0.1,
//                     color: const Color(0xFFE51818),
//                     fontWeight: FontWeight.bold,
//                     fontFamily: "Moul",
//                     shadows: [
//                       Shadow(
//                         offset: const Offset(2.0, 2.0),
//                         blurRadius: 3.0,
//                         color: Colors.grey.withOpacity(0.5),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(width: screenWidth * 0.02),
//               Icon(
//                 Icons.arrow_forward,
//                 color: const Color(0xFFE51818),
//                 size: screenWidth * 0.1,
//               ),
//             ],
//           ),
//         ),
//       );
//     } else {
//       return Container(
//         width: screenWidth * 0.7,
//         decoration: BoxDecoration(
//           color: const Color.fromARGB(255, 255, 255, 255),
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(40),
//           child: Image.asset(imagePath, fit: BoxFit.contain),
//         ),
//       );
//     }
//   }
// }

import 'package:flutter/material.dart';

class Departbutton extends StatelessWidget {
  final VoidCallback tap;
  const Departbutton({super.key, required this.title, required this.tap});
  final String title;
  @override
  Widget build(BuildContext context) {
    // return ClipPath(
    //   clipper: CustomShapeClipper(),
    // child:
    return InkWell(
      onTap: tap,
      splashColor: const Color.fromARGB(255, 156, 5, 5),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 140,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: const Color(0xFFEFEFEF),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  offset: const Offset(5.0, 4.0),
                  blurRadius: 7,
                  spreadRadius: 0)
            ]),
        child: Text(title,
            style: const TextStyle(
                color: Color.fromARGB(255, 183, 25, 25),
                fontWeight: FontWeight.bold,
                fontSize: 19)),
      ),
    );
  }
}

class CustomShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height / 2);
    path.quadraticBezierTo(
        size.width / 4, size.height, size.width / 2, size.height);
    path.quadraticBezierTo(
        3 * size.width / 4, size.height, size.width, size.height / 2);
    path.lineTo(size.width, 0);
    // path.lineTo(0, size.height);

    // path.lineTo(size.width, size.height);
    // path.lineTo(size.width, 0);
    // path.quadraticBezierTo(size.width * 0.4, size.height * 0.4, size.width, 0);
    // path.lineTo(size.width * 0.9, 0);
    // path.lineTo(size.width, size.height * 0.2);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}


// import 'package:flutter/material.dart';
// import 'package:ba_app/Screens/coming_soon.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => HomeScreenState();
// }

// class HomeScreenState extends State<HomeScreen> {
//   int _selectedIndex = 2;

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   void _tapWidget(BuildContext context) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (ctx) => ComingSoon(),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Get the screen width using MediaQuery
//     final double screenWidth = MediaQuery.of(context).size.width;

//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Container(
//           color: Colors.white,
//           height: 1400,
//           child: Stack(
//             children: [
//               Positioned(
//                 top: 44,
//                 left: 16,
//                 child: Image.asset(
//                   "D:/ba_app/assets/images/BA_Logo.png",
//                 ),
//               ),
//               const Positioned(
//                 top: 108,
//                 left: 16,
//                 child: Text("Featured Announcements:",
//                     style:
//                         TextStyle(fontSize: 18, fontStyle: FontStyle.normal)),
//               ),
//               const Positioned(
//                   top: 230,
//                   left: 155,
//                   child: Text("Coming Soon",
//                       style: TextStyle(
//                           fontSize: 17,
//                           fontWeight: FontWeight.bold,
//                           color: Color.fromARGB(255, 173, 26, 15)))),
//               const Positioned(
//                 top: 342,
//                 left: 19,
//                 child: Text("Dashboard", style: TextStyle(fontSize: 20)),
//               ),
//               InkWell(
//                 onTap: () => _tapWidget(context),
//                 borderRadius: BorderRadius.circular(16),
//                 child: Positioned(
//                   top: 390,
//                   left: 12,
//                   child: Image.asset("D:/ba_app/assets/images/Picture.png"),
//                 ),
//               ),
//               const Positioned(
//                 top: 475,
//                 left: 46,
//                 child: Text("Locker"),
//               ),
//               const Positioned(top: 491, left: 45, child: Text("Booking")),
//               Positioned(
//                 top: 393,
//                 left: 159,
//                 child: Image.asset('D:/ba_app/assets/images/Style.png'),
//               ),
//               InkWell(
//                 onTap: () => _tapWidget(context),
//                 borderRadius: BorderRadius.circular(16),
//                 child: Positioned(
//                   top: 396,
//                   left: 164,
//                   child: Image.asset("D:/ba_app/assets/images/Package.png"),
//                 ),
//               ),
//               const Positioned(
//                 top: 478,
//                 left: 189,
//                 child: Text("BA"),
//               ),
//               const Positioned(
//                 top: 495,
//                 left: 180,
//                 child: Text("Packs"),
//               ),
//               Positioned(
//                 top: 393,
//                 left: 287,
//                 child: Image.asset('D:/ba_app/assets/images/Style.png'),
//               ),
//               Positioned(
//                 top: 378,
//                 left: 284,
//                 child: Image.asset("D:/ba_app/assets/images/BA_notes.png"),
//               ),
//               const Positioned(
//                 top: 478,
//                 left: 316,
//                 child: Text("BA"),
//               ),
//               const Positioned(
//                 top: 498,
//                 left: 306,
//                 child: Text("Notes"),
//               ),
//               Positioned(
//                 top: 532,
//                 left: 28,
//                 child: Image.asset('D:/ba_app/assets/images/Style.png'),
//               ),
//               Positioned(
//                 top: 535,
//                 left: 32,
//                 child: Image.asset("D:/ba_app/assets/images/computer.png"),
//               ),
//               Positioned(
//                 top: 532,
//                 left: 159,
//                 child: Image.asset("D:/ba_app/assets/images/Style.png"),
//               ),
//               Positioned(
//                 top: 534,
//                 left: 159,
//                 child: Image.asset(
//                     "D:/ba_app/assets/images/Declaration_guide.png"),
//               ),
//               const Positioned(
//                 top: 615,
//                 left: 30,
//                 child: Text("Registration"),
//               ),
//               const Positioned(
//                 top: 615,
//                 left: 162,
//                 child: Text("Declaration"),
//               ),
//               const Positioned(
//                 top: 630,
//                 left: 179,
//                 child: Text("Guide"),
//               ),
//               Positioned(
//                 top: 535,
//                 left: 287,
//                 child: Image.asset('D:/ba_app/assets/images/Style.png'),
//               ),
//               Positioned(
//                 top: 534,
//                 left: 284,
//                 child: Image.asset('D:/ba_app/assets/images/syllabus.png'),
//               ),
//               const Positioned(
//                 top: 620,
//                 left: 299,
//                 child: Text("Syllabus"),
//               ),
//               const Positioned(
//                 top: 722,
//                 left: 28,
//                 child: Text("BA Card", style: TextStyle(fontSize: 20)),
//               ),
//               const Positioned(
//                 top: 725,
//                 left: 320,
//                 child: Text("View More",
//                     style: TextStyle(
//                         color: Color.fromARGB(255, 7, 164, 212),
//                         fontSize: 14,
//                         fontWeight: FontWeight.bold)),
//               ),

//               // Fixing the horizontal ListView issue:
//               Positioned(
//                 top: 750, // Adjust the top position for your layout
//                 left: 0, // Align to the left
//                 right: 0, // Align to the right
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: SizedBox(
//                     height: 200, // Set a height for the horizontal list
//                     child: ListView(
//                       scrollDirection: Axis.horizontal,
//                       children: [
//                         _buildImageItem(
//                             'assets/images/BA Card.png', screenWidth),
//                         _buildImageItem('D:/ba_app/assets/images/syllabus.png',
//                             screenWidth),
//                         _buildImageItem('D:/ba_app/assets/images/syllabus.png',
//                             screenWidth),
//                         _buildImageItem('D:/ba_app/assets/images/syllabus.png',
//                             screenWidth),
//                       ],
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // Updated _buildImageItem to take screenWidth as argument
//   Widget _buildImageItem(String imagePath, double screenWidth) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 8.0),
//       width:
//           0.8 * screenWidth, // Set the width of each item to the screen width
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(10.0),
//         child: Center(
//           child: Image.asset(
//             imagePath,
//             fit: BoxFit.cover, // Makes the image cover the container
//           ),
//         ),
//       ),
//     );
//   }
// }
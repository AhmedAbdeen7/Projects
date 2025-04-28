import 'package:flutter/material.dart';

class BaCardApparel extends StatelessWidget {
  const BaCardApparel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('assets/images/BA_Logo.png', height: 40),
            const Expanded(
              child: Center(
                child: Text(
                  'BA Card',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Lato",
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
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.all(baseSize * 0.04), // 4% padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Image
                  Center(
                    child: Container(
                      width: baseSize * 0.6, // 60% of base size
                      height: baseSize * 0.2, // 20% of base size
                      margin: EdgeInsets.only(bottom: baseSize * 0.04),
                      child: Image.asset(
                        "assets/images/ba_card/BA_Card.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  // Title
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: baseSize * 0.04),
                    child: Text(
                      "Apparel",
                      style: TextStyle(
                        color: const Color(0xFF8B8181),
                        fontSize: baseSize * 0.05, // 5% of base size
                        fontFamily: "Lato",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: baseSize * 0.04),

                  // Grid of Items
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: baseSize * 0.03, // 3% spacing
                    crossAxisSpacing: baseSize * 0.03, // 3% spacing
                    childAspectRatio: 0.85, // Slightly taller than wide
                    children: [
                      _buildVendorItem(
                        context,
                        baseSize,
                        "assets/images/Riot.png",
                        "Riot (sports wear)",
                        "Online",
                        "10%",
                      ),
                      _buildVendorItem(
                        context,
                        baseSize,
                        "assets/images/Sotrah.png",
                        "Sotrah",
                        "Online",
                        "10%",
                      ),
                      _buildVendorItem(
                        context,
                        baseSize,
                        "assets/images/Hana.png",
                        "Hana-egy",
                        "Online",
                        "10%",
                      ),
                      _buildVendorItem(
                        context,
                        baseSize,
                        "assets/images/Exstacy.png",
                        "Exstacy",
                        "Online",
                        "15%",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildVendorItem(
    BuildContext context,
    double baseSize,
    String imagePath,
    String vendor,
    String location,
    String discount,
  ) {
    return Container(
      padding: EdgeInsets.all(baseSize * 0.03), // 3% padding
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(baseSize * 0.02), // 2% radius
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: baseSize * 0.35, // 35% of base size
              height: baseSize * 0.2, // 20% of base size
              child: Image.asset(imagePath, fit: BoxFit.contain),
            ),
          ),
          SizedBox(height: baseSize * 0.02),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Vendor: $vendor",
                style: TextStyle(
                  fontSize: baseSize * 0.03, // 3% of base size
                  fontWeight: FontWeight.bold,
                  fontFamily: "Lato",
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: baseSize * 0.01),
              Text(
                "Location: $location",
                style: TextStyle(fontSize: baseSize * 0.03, fontFamily: "Lato"),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: baseSize * 0.01),
              Row(
                children: [
                  Text(
                    "Discount: ",
                    style: TextStyle(
                      fontSize: baseSize * 0.03,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Lato",
                    ),
                  ),
                  Text(
                    discount,
                    style: TextStyle(
                      color: const Color(0xFFDE1B1B),
                      fontSize: baseSize * 0.03,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Lato",
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// // import 'package:ba_app/main.dart';
// // import 'package:ba_app/Screens/mainscreen.dart';
// // import 'package:ba_app/Screens/Navigation_Bar_screens/homepage.dart';
// // import 'package:ba_app/Widgets/ba_text.dart';
// // import 'package:ba_app/Widgets/widget.dart';

// class BaCardApparel extends StatelessWidget {
//   const BaCardApparel({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;

//     return Scaffold(
//       appBar: AppBar(
//         title: Row(
//           children: [
//             Image.asset('assets/images/BA_Logo.png', height: 40),
//             const SizedBox(width: 50),
//             const Text(
//               'BA Card',
//               style: TextStyle(
//                 fontSize: 30,
//                 fontWeight: FontWeight.bold,
//                 fontFamily: "Lato",
//                 color: Color(0xFFDE1B1B),
//               ),
//             ),
//           ],
//         ),
//         backgroundColor: Colors.white,
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           color: Colors.white,
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Top Image
//               Center(
//                 child: Image.asset(
//                   "assets/images/ba_card/BA_Card.png",
//                   width: screenWidth * 0.4,
//                   height: screenHeight * 0.15,
//                   fit: BoxFit.contain,
//                 ),
//               ),
//               const SizedBox(height: 20),

//               // Title
//               const Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 16.0),
//                 child: Text(
//                   "Apparel",
//                   style: TextStyle(
//                     color: Color(0xFF8B8181),
//                     fontSize: 20,
//                     fontFamily: "Lato",
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),

//               // Grid of Items
//               GridView.count(
//                 crossAxisCount: 2, // 2 items per row
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 mainAxisSpacing: 20,
//                 crossAxisSpacing: 20,
//                 childAspectRatio:
//                     0.8, // Adjust this value to control item height
//                 children: [
//                   _buildVendorItem(
//                     context,
//                     "assets/images/Riot.png",
//                     "Riot (sports wear)",
//                     "Online",
//                     "10%",
//                   ),
//                   _buildVendorItem(
//                     context,
//                     "assets/images/Sotrah.png",
//                     "Sotrah",
//                     "Online",
//                     "10%",
//                   ),
//                   _buildVendorItem(
//                     context,
//                     "assets/images/Hana.png",
//                     "Hana-egy",
//                     "Online",
//                     "10%",
//                   ),
//                   _buildVendorItem(
//                     context,
//                     "assets/images/Exstacy.png",
//                     "Exstacy",
//                     "Online",
//                     "15%",
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // Helper method to build a vendor item
//   Widget _buildVendorItem(
//     BuildContext context,
//     String imagePath,
//     String vendor,
//     String location,
//     String discount,
//   ) {
//     return Container(
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             spreadRadius: 1,
//             blurRadius: 3,
//             offset: const Offset(0, 2),
//           ),
//         ],
//         border: Border.all(color: Colors.grey.shade200),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Center(
//             child: Image.asset(
//               imagePath,
//               width: MediaQuery.of(context).size.width * 0.4,
//               height: MediaQuery.of(context).size.height * 0.15,
//               fit: BoxFit.contain,
//             ),
//           ),
//           const SizedBox(height: 8),
//           // Custom implementation instead of BACardText
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Vendor: $vendor",
//                 style: const TextStyle(
//                   fontSize: 12,
//                   fontWeight: FontWeight.bold,
//                   fontFamily: "Lato",
//                 ),
//                 overflow: TextOverflow.ellipsis,
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 "Location: $location",
//                 style: const TextStyle(fontSize: 12, fontFamily: "Lato"),
//                 overflow: TextOverflow.ellipsis,
//               ),
//               const SizedBox(height: 4),
//               Row(
//                 children: [
//                   const Text(
//                     "Discount: ",
//                     style: TextStyle(
//                       fontSize: 12,
//                       fontWeight: FontWeight.bold,
//                       fontFamily: "Lato",
//                     ),
//                   ),
//                   Text(
//                     discount,
//                     style: const TextStyle(
//                       color: Color(0xFFDE1B1B), // Red color for discount
//                       fontSize: 12,
//                       fontWeight: FontWeight.bold,
//                       fontFamily: "Lato",
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

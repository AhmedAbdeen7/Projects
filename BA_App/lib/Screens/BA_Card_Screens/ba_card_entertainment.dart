import 'package:flutter/material.dart';

class BaCardEntertainment extends StatelessWidget {
  const BaCardEntertainment({super.key});

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
              padding: EdgeInsets.symmetric(
                horizontal: baseSize * 0.05, // 5% padding
                vertical: baseSize * 0.04, // 4% padding
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header section
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: baseSize * 0.3, // 30% of base size
                        height: baseSize * 0.2, // 20% of base size
                        child: Image.asset(
                          "assets/images/ba_card/BA_Card.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(width: baseSize * 0.05),
                      Text(
                        "Entertainment",
                        style: TextStyle(
                          color: const Color(0xFF8B8181),
                          fontSize: baseSize * 0.05, // 5% of base size
                          fontFamily: "Lato",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: baseSize * 0.05),

                  // Grid of Items with consistent styling
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: baseSize * 0.03, // 3% spacing
                    crossAxisSpacing: baseSize * 0.03, // 3% spacing
                    childAspectRatio: 0.7, // Adjusted aspect ratio
                    children: [
                      _buildVendorItem(
                        context,
                        baseSize,
                        "assets/images/ba_card/AutoVroom.png",
                        "Autovroom",
                        "Obour & New Cairo",
                        "15%",
                      ),
                      _buildVendorItem(
                        context,
                        baseSize,
                        "assets/images/ba_card/BNKR.png",
                        "Bunker",
                        "Golden Square",
                        "10%",
                      ),
                      _buildVendorItem(
                        context,
                        baseSize,
                        "assets/images/ba_card/Trapped.png",
                        "Trapped",
                        "CFC & North 90",
                        "20%",
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
          // Vendor image
          Center(
            child: Container(
              height: baseSize * 0.15, // 15% of base size
              child: Image.asset(imagePath, fit: BoxFit.contain),
            ),
          ),
          SizedBox(height: baseSize * 0.03),

          // Vendor name
          Row(
            children: [
              Text(
                "Vendor: ",
                style: TextStyle(
                  color: const Color(0xFF000000),
                  fontSize: baseSize * 0.03, // 3% of base size
                  fontWeight: FontWeight.bold,
                  fontFamily: "Lato",
                ),
              ),
              Expanded(
                child: Text(
                  vendor,
                  style: TextStyle(
                    color: const Color(0xFF000000),
                    fontSize: baseSize * 0.03,
                    fontFamily: "Lato",
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: baseSize * 0.02),

          // Location
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Location: ",
                style: TextStyle(
                  color: const Color(0xFF000000),
                  fontSize: baseSize * 0.03,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Lato",
                ),
              ),
              Expanded(
                child: Text(
                  location,
                  style: TextStyle(
                    color: const Color(0xFF000000),
                    fontSize: baseSize * 0.03,
                    fontFamily: "Lato",
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ],
          ),
          SizedBox(height: baseSize * 0.02),

          // Discount with red text for the value
          Row(
            children: [
              Text(
                "Discount: ",
                style: TextStyle(
                  color: const Color(0xFF000000),
                  fontSize: baseSize * 0.03,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Lato",
                ),
              ),
              Expanded(
                child: Text(
                  discount,
                  style: TextStyle(
                    color: const Color(0xFFDE1B1B),
                    fontSize: baseSize * 0.03,
                    fontFamily: "Lato",
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
// import 'package:flutter/material.dart';

// class BaCardEntertainment extends StatelessWidget {
//   const BaCardEntertainment({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Row(
//           children: [
//             Image.asset(
//               'assets/images/BA_Logo.png',
//               height: 40,
//             ),
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
//           width: double.infinity,
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Header section
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Image.asset(
//                     "assets/images/ba_card/BA_Card.png",
//                     width: 128,
//                     height: 83,
//                   ),
//                   const SizedBox(width: 48),
//                   const Text(
//                     "Entertainment",
//                     style: TextStyle(
//                       color: Color(0xFF8B8181),
//                       fontSize: 20,
//                       fontFamily: "Lato",
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 40),

//               // Grid of Items with consistent styling
//               GridView.count(
//                 crossAxisCount: 2, // 2 items per row
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 mainAxisSpacing: 20,
//                 crossAxisSpacing: 15,
//                 childAspectRatio: 0.65, // Adjusted to prevent overflow
//                 children: [
//                   _buildVendorItem(
//                     "assets/images/ba_card/AutoVroom.png",
//                     "Autovroom",
//                     "Obour & New Cairo",
//                     "15%",
//                   ),
//                   _buildVendorItem(
//                     "assets/images/ba_card/BNKR.png",
//                     "Bunker",
//                     "Golden Square",
//                     "10%",
//                   ),
//                   _buildVendorItem(
//                     "assets/images/ba_card/Trapped.png",
//                     "Trapped",
//                     "CFC & North 90",
//                     "20%",
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // Updated helper method to build a vendor item with consistent styling
//   Widget _buildVendorItem(
//     String imagePath,
//     String vendor,
//     String location,
//     String discount,
//   ) {
//     return Container(
//       padding: const EdgeInsets.all(15),
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
//           // Vendor image
//           Center(
//             child: Image.asset(
//               imagePath,
//               height: 90,
//               fit: BoxFit.contain,
//             ),
//           ),
//           const SizedBox(height: 15),

//           // Vendor name
//           Row(
//             children: [
//               const Text(
//                 "Vendor: ",
//                 style: TextStyle(
//                   color: Color(0xFF000000),
//                   fontSize: 12,
//                   fontWeight: FontWeight.bold,
//                   fontFamily: "Lato",
//                 ),
//               ),
//               Expanded(
//                 child: Text(
//                   vendor,
//                   style: const TextStyle(
//                     color: Color(0xFF000000),
//                     fontSize: 12,
//                     fontFamily: "Lato",
//                   ),
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 10),

//           // Location
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 "Location: ",
//                 style: TextStyle(
//                   color: Color(0xFF000000),
//                   fontSize: 12,
//                   fontWeight: FontWeight.bold,
//                   fontFamily: "Lato",
//                 ),
//               ),
//               Expanded(
//                 child: Text(
//                   location,
//                   style: const TextStyle(
//                     color: Color(0xFF000000),
//                     fontSize: 12,
//                     fontFamily: "Lato",
//                   ),
//                   overflow: TextOverflow.ellipsis,
//                   maxLines: 2,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 10),

//           // Discount with red text for the value
//           Row(
//             children: [
//               const Text(
//                 "Discount: ",
//                 style: TextStyle(
//                   color: Color(0xFF000000),
//                   fontSize: 12,
//                   fontWeight: FontWeight.bold,
//                   fontFamily: "Lato",
//                 ),
//               ),
//               Expanded(
//                 child: Text(
//                   discount,
//                   style: const TextStyle(
//                     color: Color(0xFFDE1B1B), // Red color for discount
//                     fontSize: 12,
//                     fontFamily: "Lato",
//                     fontWeight: FontWeight.bold,
//                   ),
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

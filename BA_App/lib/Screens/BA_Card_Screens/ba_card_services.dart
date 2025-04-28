import 'package:flutter/material.dart';

class BaCardServices extends StatelessWidget {
  const BaCardServices({super.key});

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
                        "Services",
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

                  // Service card
                  Center(
                    child: _buildServiceCard(
                      context,
                      baseSize,
                      "assets/images/ba_card/ParknGleam.png",
                      "Park N' Gleam",
                      [
                        "Online - On Demand",
                        "https://www.instagram.com/parkngleam?",
                        "igsh=MTd27XNicHhIOX7nOQ ==",
                      ],
                      "25%",
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

  Widget _buildServiceCard(
    BuildContext context,
    double baseSize,
    String imagePath,
    String serviceName,
    List<String> locationInfo,
    String discount,
  ) {
    return Container(
      width: baseSize * 0.8, // 80% of base size
      margin: EdgeInsets.only(bottom: baseSize * 0.04),
      padding: EdgeInsets.all(baseSize * 0.04), // 4% padding
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Service image
          Container(
            height: baseSize * 0.25, // 25% of base size
            child: Image.asset(imagePath, fit: BoxFit.contain),
          ),
          SizedBox(height: baseSize * 0.04),

          // Service information
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Vendor: ",
                style: TextStyle(
                  color: const Color(0xFF000000),
                  fontSize: baseSize * 0.04, // 4% of base size
                  fontWeight: FontWeight.bold,
                  fontFamily: "Lato",
                ),
              ),
              Text(
                serviceName,
                style: TextStyle(
                  color: const Color(0xFF000000),
                  fontSize: baseSize * 0.04,
                  fontFamily: "Lato",
                ),
              ),
            ],
          ),
          SizedBox(height: baseSize * 0.03),

          // Location information
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Location: ",
                style: TextStyle(
                  color: const Color(0xFF000000),
                  fontSize: baseSize * 0.04,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Lato",
                ),
              ),
              SizedBox(height: baseSize * 0.02),

              // Location details
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children:
                    locationInfo.map((info) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: baseSize * 0.01),
                        child: Text(
                          info,
                          style: TextStyle(
                            color: const Color(0xFF000000),
                            fontSize: baseSize * 0.035, // 3.5% of base size
                            fontFamily: "Lato",
                          ),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }).toList(),
              ),
            ],
          ),
          SizedBox(height: baseSize * 0.03),

          // Discount
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Discount: ",
                style: TextStyle(
                  color: const Color(0xFF000000),
                  fontSize: baseSize * 0.04,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Lato",
                ),
              ),
              Text(
                discount,
                style: TextStyle(
                  color: const Color(0xFFDE1B1B),
                  fontSize: baseSize * 0.04,
                  fontFamily: "Lato",
                  fontWeight: FontWeight.bold,
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

// class BaCardServices extends StatelessWidget {
//   const BaCardServices({super.key});
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
//                     "Services",
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

//               // Service card with styling similar to vendor cards
//               Center(
//                 child: _buildServiceCard(
//                   "assets/images/ba_card/ParknGleam.png",
//                   "Park N' Gleam",
//                   [
//                     "Online - On Demand",
//                     "https://www.instagram.com/parkngleam?",
//                     "igsh=MTd27XNicHhIOX7nOQ ==",
//                   ],
//                   "25%",
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildServiceCard(
//     String imagePath,
//     String serviceName,
//     List<String> locationInfo,
//     String discount,
//   ) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 20),
//       padding: const EdgeInsets.all(20),
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
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           // Service image
//           Image.asset(
//             imagePath,
//             height: 150,
//             fit: BoxFit.contain,
//           ),
//           const SizedBox(height: 20),

//           // Service information
//           Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Text(
//                 "Vendor: ",
//                 style: TextStyle(
//                   color: Color(0xFF000000),
//                   fontSize: 14,
//                   fontWeight: FontWeight.bold,
//                   fontFamily: "Lato",
//                 ),
//               ),
//               Text(
//                 serviceName,
//                 style: const TextStyle(
//                   color: Color(0xFF000000),
//                   fontSize: 14,
//                   fontFamily: "Lato",
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 15),

//           // Location information
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const Text(
//                 "Location: ",
//                 style: TextStyle(
//                   color: Color(0xFF000000),
//                   fontSize: 14,
//                   fontWeight: FontWeight.bold,
//                   fontFamily: "Lato",
//                 ),
//               ),
//               const SizedBox(height: 5),

//               // Location details
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: locationInfo.map((info) {
//                   return Padding(
//                     padding: const EdgeInsets.only(bottom: 5),
//                     child: Text(
//                       info,
//                       style: const TextStyle(
//                         color: Color(0xFF000000),
//                         fontSize: 14,
//                         fontFamily: "Lato",
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   );
//                 }).toList(),
//               ),
//             ],
//           ),
//           const SizedBox(height: 15),

//           // Discount
//           Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Text(
//                 "Discount: ",
//                 style: TextStyle(
//                   color: Color(0xFF000000),
//                   fontSize: 14,
//                   fontWeight: FontWeight.bold,
//                   fontFamily: "Lato",
//                 ),
//               ),
//               Text(
//                 discount,
//                 style: const TextStyle(
//                   color: Color(0xFFDE1B1B),
//                   fontSize: 14,
//                   fontFamily: "Lato",
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

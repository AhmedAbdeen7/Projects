import 'package:flutter/material.dart';

class BaCardSports extends StatelessWidget {
  const BaCardSports({super.key});

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
                        "Sports",
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

                  // Sports vendors in a row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Muscle Temple
                      Expanded(
                        child: _buildVendorCard(
                          context,
                          baseSize,
                          "assets/images/ba_card/Muscle Temple.png",
                          "Muscle Temple",
                          ["New Cairo, Cairo"],
                          "45%",
                        ),
                      ),
                      SizedBox(width: baseSize * 0.03), // 3% spacing
                      // Z10
                      Expanded(
                        child: _buildVendorCard(
                          context,
                          baseSize,
                          "assets/images/ba_card/Z10.png",
                          "Z10",
                          [
                            "Gateway Mall, Rehab",
                            "Rivera Heights",
                            "Eairmont NC",
                          ],
                          "35%",
                        ),
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

  Widget _buildVendorCard(
    BuildContext context,
    double baseSize,
    String imagePath,
    String vendorName,
    List<String> locations,
    String discount,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: baseSize * 0.04),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Vendor: ",
                style: TextStyle(
                  color: const Color(0xFF000000),
                  fontSize: baseSize * 0.035, // 3.5% of base size
                  fontWeight: FontWeight.bold,
                  fontFamily: "Lato",
                ),
              ),
              Expanded(
                child: Text(
                  vendorName,
                  style: TextStyle(
                    color: const Color(0xFF000000),
                    fontSize: baseSize * 0.035,
                    fontFamily: "Lato",
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: baseSize * 0.03),

          // Location
          Text(
            "Location: ",
            style: TextStyle(
              color: const Color(0xFF000000),
              fontSize: baseSize * 0.035,
              fontWeight: FontWeight.bold,
              fontFamily: "Lato",
            ),
          ),
          SizedBox(height: baseSize * 0.02),

          // Location list
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
                locations.map((location) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: baseSize * 0.01),
                    child: Text(
                      location,
                      style: TextStyle(
                        color: const Color(0xFF000000),
                        fontSize: baseSize * 0.035,
                        fontFamily: "Lato",
                      ),
                    ),
                  );
                }).toList(),
          ),
          SizedBox(height: baseSize * 0.03),

          // Discount
          Row(
            children: [
              Text(
                "Discount: ",
                style: TextStyle(
                  color: const Color(0xFF000000),
                  fontSize: baseSize * 0.035,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Lato",
                ),
              ),
              Expanded(
                child: Text(
                  discount,
                  style: TextStyle(
                    color: const Color(0xFFDE1B1B),
                    fontSize: baseSize * 0.035,
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

import 'package:flutter/material.dart';

class BaCardBeauty extends StatelessWidget {
  const BaCardBeauty({super.key});

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
                        "Beauty&Wellness",
                        style: TextStyle(
                          color: const Color(0xFF8B8181),
                          fontSize:
                              baseSize *
                              0.045, // 4.5% of base size (slightly smaller for long title)
                          fontFamily: "Lato",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: baseSize * 0.05),

                  // Vendor rows
                  _buildVendorRow(
                    context,
                    baseSize,
                    "assets/images/The hair addict.png",
                    "Hair Addict",
                    "Online",
                    "15%",
                    "assets/images/Bubblzz.png",
                    "Bubblzz",
                    "Online (use code\nAucbubblzz2022)",
                    "15%",
                  ),
                  SizedBox(height: baseSize * 0.03),

                  _buildVendorRow(
                    context,
                    baseSize,
                    "assets/images/Ali Yehya.png",
                    "Ali Yehia",
                    "Concord Plaza Mall",
                    "20%",
                    "assets/images/Mohamed Fouad.png",
                    "Mohamed Fouad",
                    "Promenade Mall, El\nNarges Midtown Mall\nHeliopolis, El Nozha\nNasr City",
                    "25%",
                  ),
                  SizedBox(height: baseSize * 0.03),

                  _buildVendorRow(
                    context,
                    baseSize,
                    "assets/images/El masri.png",
                    "El Masry Jewelry",
                    "15 Haroun el\nrasheed, meedan al gamea,\nMasr el Gedida",
                    "20% Gold, 60%\nDiamonds",
                    "assets/images/La coupe.png",
                    "La Coupe",
                    "Masr el Gedida\nBranch only",
                    "20%",
                  ),
                  SizedBox(height: baseSize * 0.03),

                  _buildVendorRow(
                    context,
                    baseSize,
                    "assets/images/Waheed.png",
                    "Nabil Waheed",
                    "Chill Out Rehab\nMobil Golden Square Mobil Al\nNarges\nMobil North 90th Street",
                    "20%",
                    "assets/images/KUTS.png",
                    "Kuts",
                    "New Cairo, Agora\nMall",
                    "10%",
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildVendorRow(
    BuildContext context,
    double baseSize,
    String imagePath1,
    String vendor1,
    String location1,
    String discount1,
    String imagePath2,
    String vendor2,
    String location2,
    String discount2,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _buildVendorCard(
            context,
            baseSize,
            imagePath1,
            vendor1,
            location1,
            discount1,
          ),
        ),
        SizedBox(width: baseSize * 0.03), // 3% spacing
        Expanded(
          child: _buildVendorCard(
            context,
            baseSize,
            imagePath2,
            vendor2,
            location2,
            discount2,
          ),
        ),
      ],
    );
  }

  Widget _buildVendorCard(
    BuildContext context,
    double baseSize,
    String imagePath,
    String vendor,
    String location,
    String discount,
  ) {
    return Container(
      padding: EdgeInsets.all(baseSize * 0.03), // 3% padding
      margin: EdgeInsets.only(bottom: baseSize * 0.02),
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
                  fontSize: baseSize * 0.035, // 3.5% of base size
                  fontWeight: FontWeight.bold,
                  fontFamily: "Lato",
                ),
              ),
              Expanded(
                child: Text(
                  vendor,
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
          SizedBox(height: baseSize * 0.02),

          // Location
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Location: ",
                style: TextStyle(
                  color: const Color(0xFF000000),
                  fontSize: baseSize * 0.035,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Lato",
                ),
              ),
              Expanded(
                child: Text(
                  location,
                  style: TextStyle(
                    color: const Color(0xFF000000),
                    fontSize: baseSize * 0.035,
                    fontFamily: "Lato",
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 4,
                ),
              ),
            ],
          ),
          SizedBox(height: baseSize * 0.02),

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
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

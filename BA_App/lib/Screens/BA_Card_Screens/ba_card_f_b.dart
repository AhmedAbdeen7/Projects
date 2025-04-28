import 'package:flutter/material.dart';

class BaCardF_B extends StatelessWidget {
  const BaCardF_B({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('assets/images/BA Logo Red.png', height: 40),
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
          final baseSize =
              constraints.maxWidth < constraints.maxHeight
                  ? constraints.maxWidth
                  : constraints.maxHeight;

          return SingleChildScrollView(
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(
                horizontal: baseSize * 0.05,
                vertical: baseSize * 0.04,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header section
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: baseSize * 0.3,
                        height: baseSize * 0.2,
                        child: Image.asset(
                          "assets/images/ba_card/BA_Card.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(width: baseSize * 0.05),
                      Text(
                        "F&B",
                        style: TextStyle(
                          color: const Color(0xFF8B8181),
                          fontSize: baseSize * 0.05,
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
                    "assets/images/Jimmy's.png",
                    "Jimmy's",
                    "District 5 - The lake, District",
                    "10%",
                    "assets/images/Diner.png",
                    "3 Diner",
                    "The Drive By, Waterway Development",
                    "10%",
                  ),
                  SizedBox(height: baseSize * 0.03),

                  _buildVendorRow(
                    context,
                    baseSize,
                    "assets/images/Blaze.png",
                    "Blaze",
                    "El Nozha Street, Mall of Arabia, Madinaty, Mohandeseen",
                    "10%",
                    "assets/images/Lobster.png",
                    "Lobster Kitchen",
                    "Horeya Street, Almaza - St. Roll",
                    "10%",
                  ),
                  SizedBox(height: baseSize * 0.03),

                  _buildVendorRow(
                    context,
                    baseSize,
                    "assets/images/Hummus.png",
                    "Hummus and Go",
                    "18 Bagdad street, Alkorba",
                    "10%",
                    "assets/images/1980.png",
                    "1980",
                    "Maadi - Mivida - New Giza - District 5, Gate B",
                    "10%",
                  ),
                  SizedBox(height: baseSize * 0.03),

                  _buildVendorRow(
                    context,
                    baseSize,
                    "assets/images/Hola Tacos.png",
                    "Hola Tacos",
                    "The Field, Maadi - Hydeout, New Cairo - Northed, Zahra Sahel",
                    "15%",
                    "assets/images/20 grams.png",
                    "Twenty Grams",
                    "Arkan Plaza, Sheikh Zayed - Garden 8, Newcairo - Nutcracker- Uvenues",
                    "10%",
                  ),
                  SizedBox(height: baseSize * 0.03),

                  _buildVendorRow(
                    context,
                    baseSize,
                    "assets/images/Gyoza.png",
                    "Gyoza",
                    "Lake District, Mivida",
                    "10%",
                    "assets/images/Sno.png",
                    "Snő",
                    "Maadi - District 5 - ST.Roll New Cairo - Mivida New Cairo - Uptown Cairo - Sodic Villette",
                    "10% on Cakes",
                  ),
                  SizedBox(height: baseSize * 0.03),

                  _buildVendorRow(
                    context,
                    baseSize,
                    "assets/images/Ayadina.png",
                    "Ayadina",
                    "City Stars Mall - Korba - Mall of Arabia - Madinaty Open Air Mall",
                    "10%",
                    "assets/images/Baba Bear.png",
                    "Boba Bear",
                    "Promenade El Narges Mall, New Cairo - Eni Station, New Cairo - Almaza",
                    "15%",
                  ),
                  SizedBox(height: baseSize * 0.03),

                  _buildVendorRow(
                    context,
                    baseSize,
                    "assets/images/nathan's.png",
                    "Nathan's",
                    "Lake District, Mivida - St.roll-Leven Square",
                    "20%",
                    "assets/images/Kazdora.png",
                    "Kazdoura",
                    "G7 Complex, New Cairo",
                    "7%",
                  ),
                  SizedBox(height: baseSize * 0.03),

                  _buildVendorRow(
                    context,
                    baseSize,
                    "assets/images/CAF.png",
                    "CAF",
                    "5A by the Waterway - White by the Waterway - Park St, Sheikh Zayed - District 5 - Egyptian Museum",
                    "10%",
                    "assets/images/Duck Donuts.png",
                    "Duck Donuts",
                    "CFC Mall - Zamalek (Mohamed Mazhar St) - Maadi (Zahraa El Maadi A1 Gas station) - Madinaty (The Strip Mall)",
                    "20%",
                  ),
                  SizedBox(height: baseSize * 0.03),

                  _buildVendorRow(
                    context,
                    baseSize,
                    "assets/images/Loulie's.png",
                    "Loulie's",
                    "Promenade, El Narges - Almaza",
                    "20%",
                    "assets/images/Wildwing.png",
                    "The Wild Wing",
                    "N 90, Chillout Midor",
                    "15%",
                  ),
                  SizedBox(height: baseSize * 0.03),

                  _buildVendorRow(
                    context,
                    baseSize,
                    "assets/images/Joe's.png",
                    "Joe's",
                    "Leven Square - El Malahy",
                    "15%",
                    "assets/images/Croccante.png",
                    "Croccante",
                    "Swell Lake, Sheikh Zayed",
                    "10%",
                  ),
                  SizedBox(height: baseSize * 0.03),

                  _buildVendorRow(
                    context,
                    baseSize,
                    "assets/images/Stone.png",
                    "Stone",
                    "Leven Square - El Malahy",
                    "15%",
                    "assets/images/Finery.png",
                    "The Finery",
                    "North Lanes",
                    "15%",
                  ),
                  SizedBox(height: baseSize * 0.03),

                  _buildVendorRow(
                    context,
                    baseSize,
                    "assets/images/Tarab.png",
                    "Tarab",
                    "Mobile Lotus Gas Station",
                    "15%",
                    "assets/images/Crunchy_batata.png",
                    "Crunchy batata",
                    "Korba",
                    "30%",
                  ),
                  SizedBox(height: baseSize * 0.03),

                  _buildVendorRow(
                    context,
                    baseSize,
                    "assets/images/Tiko's.png",
                    "Tikos",
                    "ElShorouk - El Obour - Madinet Nasr - Masr el gedida - Maadi - Tagam3o",
                    "20%",
                    "assets/images/Pizza_time.png",
                    "Pizza Time",
                    "ElShorouk - El Obour - Madinet Nasr - Masr el gedida - Maadi - Tagam3o",
                    "20%",
                  ),
                  SizedBox(height: baseSize * 0.03),

                  // Last single card (Karak Tap)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: baseSize * 0.01),
                    child: _buildVendorCard(
                      context,
                      baseSize,
                      "assets/images/Karak tap.png",
                      "Karak Tap",
                      "Chillout Madinaty",
                      "15%",
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
        SizedBox(width: baseSize * 0.03),
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
      padding: EdgeInsets.all(baseSize * 0.03),
      margin: EdgeInsets.only(bottom: baseSize * 0.02),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(baseSize * 0.02),
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
              height: baseSize * 0.15,
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
                  fontSize: baseSize * 0.035,
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

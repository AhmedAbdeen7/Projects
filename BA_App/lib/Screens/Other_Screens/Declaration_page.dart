import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ba_app/Screens/Other_Screens/gpacalculator.dart';
import 'package:ba_app/Screens/Other_Screens/pdf_page.dart';

class DeclarationPage extends StatefulWidget {
  DeclarationPage({super.key});

  @override
  State<DeclarationPage> createState() => DeclarationPage_State();
}

class DeclarationPage_State extends State<DeclarationPage> {
  Uri? _url;

  @override
  void initState() {
    super.initState();
    _fetchUrlFromSupabase();
  }

  Future<void> _fetchUrlFromSupabase() async {
    try {
      // Use select() without specifying columns to get all fields
      final response =
          await Supabase.instance.client
              .from('links')
              .select()
              .eq('Name', 'Declaration_info')
              .maybeSingle(); // Use maybeSingle() instead of single()

      // Debug print to see what data is being returned
      print("Supabase response: $response");

      // Correctly access the Link field from the response
      if (response != null && response['Link'] != null) {
        setState(() {
          _url = Uri.parse(response['Link']);
        });
      } else {
        print("URL not found for 'Declaration_info'. Response: $response");
      }
    } catch (e) {
      print("Error fetching URL: $e");
    }
  }

  // Future<void> _launchURL() async {
  //   if (_url == null) {
  //     print("URL is not available.");
  //     return;
  //   }
  //   if (!await launchUrl(_url!)) {
  //     throw 'Could not launch $_url';
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    // Define scaling factors for responsive design
    final double scaleFactor = screenWidth / 400; // Base width is 400px
    final double scaledPadding = 20 * scaleFactor; // Scale padding
    final double declarationFontSize =
        24 * scaleFactor; // Scale Declaration Info text
    final double gpaFontSize = 16 * scaleFactor; // Scale GPA Calculator text
    final double logoHeight = 40 * scaleFactor; // Scale logo height

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/images/BA_Logo.png',
              height: logoHeight, // Responsive logo size
            ),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: scaledPadding),
            child: Column(
              children: <Widget>[
                SizedBox(height: screenHeight * 0.15),
                // Declaration Info Button
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => PDFViewerPage(pdfUrl: _url.toString()),
                      ),
                    );
                  },
                  child: Container(
                    width: screenWidth * 0.8,
                    height: screenHeight * 0.27,
                    decoration: BoxDecoration(
                      color: const Color(0xFFDD0C0C),
                      borderRadius: BorderRadius.circular(
                        25 * scaleFactor,
                      ), // Scaled border radius
                    ),
                    child: Center(
                      child: Text(
                        'Declaration Info',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: declarationFontSize, // Responsive font size
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.15),
                // GPA Calculator Button
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GPACalculator(),
                      ),
                    );
                  },
                  child: Container(
                    width: 150 * scaleFactor, // Scaled width
                    height: 50 * scaleFactor, // Scaled height
                    decoration: BoxDecoration(
                      color: const Color(0xFFDD0C0C),
                      borderRadius: BorderRadius.circular(
                        25 * scaleFactor,
                      ), // Scaled border radius
                    ),
                    child: Center(
                      child: Text(
                        'GPA Calculator',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: gpaFontSize, // Responsive font size
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ComingSoon extends StatelessWidget {
  const ComingSoon({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset("assets/images/BA_Logo.png"),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
      ),
      backgroundColor: Colors.white, // Set background color to white
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(45.0), // Padding inside the box
          decoration: BoxDecoration(
            color: const Color(0xFFAF3033), // Box color
            borderRadius: BorderRadius.circular(16.0), // Rounded corners
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 8.0,
                offset: Offset(0, 4), // Shadow position
              ),
            ],
          ),
          child: const Text(
            "Coming Soon",
            style: TextStyle(
              fontSize: 35.0,
              fontFamily: 'Alegreya', // Font size
              fontWeight: FontWeight.bold, // Font weight
              color: Color(0xFFFFFFFF), // Text color
            ),
            textAlign: TextAlign.center, // Align text to center
          ),
        ),
      ),
    );
  }
}

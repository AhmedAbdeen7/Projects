import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Ba_Notes extends StatefulWidget {
  Ba_Notes({super.key});

  @override
  State<Ba_Notes> createState() => _Ba_NotesState();
}

class _Ba_NotesState extends State<Ba_Notes> {
  Uri? _url;

  @override
  void initState() {
    super.initState();
    _fetchUrlFromSupabase();
  }

  Future<void> _fetchUrlFromSupabase() async {
    try {
      final response = await Supabase.instance.client
          .from('links')
          .select('Link')
          .eq('Name', 'Notes')
          .single();

      if (response != null && response['Link'] != null) {
        setState(() {
          _url = Uri.parse(response['Link']);
        });
      } else {
        throw Exception("URL not found for the given name.");
      }
    } catch (e) {
      print("Error fetching URL: $e");
    }
  }

  Future<void> _launchURL() async {
    if (_url == null) {
      print("URL is not available.");
      return;
    }
    if (!await launchUrl(_url!)) {
      throw 'Could not launch $_url';
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Image.asset("assets/images/BA_Logo.png"),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: screenHeight * 0.05),
              Text(
                'Notes',
                style: TextStyle(
                  fontFamily: 'Alegreya',
                  color: const Color.fromARGB(255, 124, 15, 7),
                  fontWeight: FontWeight.bold,
                  fontSize: screenHeight * 0.05,
                ),
              ),
              SizedBox(height: screenHeight * 0.15),
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const <Widget>[
                    Text(
                      ' 🎉 Click this button to join BA on Linktree 🎉',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.05),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: _launchURL,
                  child: const Text(
                    "Linktree button",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFDD0C0C), // Red background
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30), // Rounded edges
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.09,
                        vertical: screenHeight * 0.05),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

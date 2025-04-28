import 'package:flutter/material.dart';
import 'package:ba_app/Widgets/navigation_bar.dart';
import 'package:ba_app/Screens/Navigation_Bar_screens/qr_code.dart';
import 'package:ba_app/Screens/Navigation_Bar_screens/profile.dart';
import 'package:ba_app/Screens/Navigation_Bar_screens/homepage.dart';
import 'package:ba_app/Screens/Navigation_Bar_screens/faq.dart';
import 'package:ba_app/Screens/Navigation_Bar_screens/calendar.dart';

// Example custom page not in the main navigation bar
// Import custom page
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int _selectedIndex = 2; // Default to Home Page

  final List<Widget> _pages = [
    QRCodeGenerator(),
    CustomCalendar(),
    HomeScreen(),
    const FeedbackScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void navigateToCustomPage(Widget page) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: CustomBottomNavigationBar(
        onItemTapped: _onItemTapped,
        selectedIndex: _selectedIndex,
      ),
    );
  }
}

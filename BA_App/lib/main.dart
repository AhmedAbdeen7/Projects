import 'dart:async';
import 'package:ba_app/Screens/mainscreen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:ba_app/Screens/Login_Screens/reset_password.dart';
import 'package:ba_app/Screens/Login_Screens/authscreen.dart';

// import 'package:flutter/material.dart';
// import 'package:uni_links/uni_links.dart';
// import 'dart:async';
// import 'package:flutter/services.dart'; // For PlatformException handling
// import 'package:ba_app/Screens/Other_Screens/Declaration_page.dart';
// import 'package:ba_app/Screens/Other_Screens/gpacalculator.dart';
// import 'package:go_router/go_router.dart';
import 'package:ba_app/Screens/Supabase/router.dart';
// import 'package:ba_app/Screens/Login_Screens/sign_upscreen.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:app_links/app_links.dart'; // Add this package

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:ba_app/Registration/registration.dart';
// import 'package:ba_app/Screens/mainscreen.dart';
// import 'package:ba_app/Screens/BA_Locker_Screens/locker.dart';
import 'package:ba_app/Screens/BA_Locker_Screens/lockers_booking.dart';
import 'package:ba_app/Screens/Other_Screens/ba_notes.dart';
import 'package:ba_app/Screens/Syllabus_Screens/syllabus_depart.dart';
// import 'package:ba_app/Registration/Departments/sections.dart';
// import 'package:ba_app/Registration/Departments/courses.dart';
// import "package:ba_app/Screens/BA_Card_Screens/ba_card.dart";
import 'package:ba_app/Screens/Navigation_Bar_screens/homepage.dart';
// import 'package:ba_app/Screens/authscreen.dart';
// import 'package:ba_app/Screens/Login_Screens/reset_password.dart';
// import 'package:app_links/app_links.dart';

void main() async {
  await Supabase.initialize(
    url: 'https://ucbgmxjmyurvixvhbotp.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVjYmdteGpteXVydml4dmhib3RwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzEwOTgwMTcsImV4cCI6MjA0NjY3NDAxN30.nzbUjWkfZkrhbjjuDPZ3OIrIvX9JNdCwXe4SfjUTFKg',
    authOptions: const FlutterAuthClientOptions(
      authFlowType: AuthFlowType.pkce, // Now properly nested
    ),
  );
  runApp(
    MaterialApp(
      home: AuthScreen(),
      routes: {
        '/lockers_booking': (context) => LockersBooking(),
        '/notes': (context) => Ba_Notes(),
        '/syllabus_depart': (context) => DepartmentPage(),
        '/login': (context) => AuthScreen(),
        // '/reset-password': (context) => ResetPasswordPage(),
      },
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _appLinks = AppLinks();
  late StreamSubscription<Uri?> _linkSubscription;
  late final StreamSubscription<AuthState> _authSubscription;
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    // _initAppLinks();
    _initDeepLinkHandling();
    _setupAuthListener();
  }

  // Future<void> _initAppLinks() async {
  //   // Get the initial link
  //   final Uri? initialUri = await _appLinks.getInitialUri();
  //   if (initialUri != null) {
  //     _handleIncomingLink(initialUri);
  //   }

  //   // Listen for subsequent links
  //   _appLinks.uriLinkStream.listen((Uri? uri) {
  //     if (uri != null) {
  //       _handleIncomingLink(uri);
  //     }
  //   });
  // }

  // void _handleIncomingLink(Uri uri) {
  //   // Handle the incoming link here
  //   print('Received link: $uri');
  //   // Navigate or perform actions based on the link
  // }

  Future<void> _initDeepLinkHandling() async {
    try {
      // Handle initial link for cold start
      // Handle initial link (cold start)
      final Uri? initialUri = await _appLinks.getInitialLink();
      if (initialUri != null) {
        _handleDeepLink(initialUri);
      }

      // Listen for deep link updates while app is running
      _linkSubscription = _appLinks.uriLinkStream.listen((Uri? link) {
        if (link != null) {
          _handleDeepLink(link);
        }
      });
    } catch (e) {
      print('Error handling deep links: $e');
    }
  }

  void _handleDeepLink(Uri uri) {
    print('Received deep link: $uri');
    // Navigate based on the URI path or query parameters
    if (uri.path == '/reset-password') {
      _navigatorKey.currentState?.pushNamed('/reset-password');
    }
  }

  void _setupAuthListener() {
    _authSubscription = Supabase.instance.client.auth.onAuthStateChange.listen((
      data,
    ) {
      final event = data.event;

      if (event == AuthChangeEvent.passwordRecovery) {
        // Navigate to the reset password screen when recovery event is detected
        _navigatorKey.currentState?.pushNamed('/reset-password');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: router);
  }
}

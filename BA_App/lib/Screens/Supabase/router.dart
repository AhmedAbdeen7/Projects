import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:ba_app/Screens/Login_Screens/authscreen.dart';
import 'package:ba_app/Screens/Login_Screens/reset_password.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ba_app/Screens/Navigation_Bar_screens/homepage.dart';
import 'package:ba_app/Screens/Login_Screens/forgot_password.dart';

final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => HomeScreen()),
    GoRoute(path: '/login', builder: (context, state) => AuthScreen()),
    GoRoute(
      path: '/forgot-password',
      builder: (context, state) => ForgotPasswordScreen(),
    ),
    GoRoute(
      path: '/reset-password',
      builder: (context, state) => ResetPasswordScreen(),
    ),
  ],
  // Add this redirect for handling auth state
  redirect: (context, state) {
    final auth = Supabase.instance.client.auth;
    final session = auth.currentSession;
    final currentLocation = state.matchedLocation; // Changed from subloc

    final isAuthRoute =
        currentLocation == '/login' ||
        currentLocation == '/forgot-password' ||
        currentLocation == '/reset-password';

    // Allow access to reset-password route
    if (currentLocation == '/reset-password') return null;

    // Redirect unauthenticated users to login
    if (session == null && !isAuthRoute) {
      return '/login';
    }

    // Redirect authenticated users away from auth routes
    if (session != null && isAuthRoute) {
      return '/';
    }

    // No redirect
    return null;
  },
);

// final router = GoRouter(
//   routes: [
//     GoRoute(
//       path: '/',
//       redirect: (context, state) => '/login',
//     ),
//     GoRoute(
//       path: '/login',
//       pageBuilder: (context, state) => MaterialPage(
//         child: AuthScreen(),
//       ),
//     ),
//     GoRoute(
//       path: '/reset-password/:token',
//       pageBuilder: (context, state) => MaterialPage(
//         child: ResetPasswordScreen(
//           token: state.pathParameters['token']!,
//         ),
//       ),
//     ),
//   ],
// );

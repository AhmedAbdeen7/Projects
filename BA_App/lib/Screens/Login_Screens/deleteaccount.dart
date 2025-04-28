import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:math';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> deleteUserAccount(BuildContext context) async {
  final supabase = Supabase.instance.client;
  final user = supabase.auth.currentUser;

  // Enhanced scaling calculation
  final double screenWidth = MediaQuery.of(context).size.width;
  final double screenHeight = MediaQuery.of(context).size.height;
  final double scale =
      min(screenWidth / 375, screenHeight / 812) *
      1.2; // 20% larger base scaling
  final double largeScreenFactor =
      screenWidth > 600 ? 1.5 : 1.0; // Additional scaling for tablets

  if (user == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'No user is signed in!',
          style: TextStyle(fontSize: 16 * scale * largeScreenFactor),
        ),
        behavior: SnackBarBehavior.floating,
        width: 350 * scale * largeScreenFactor,
        padding: EdgeInsets.all(20 * scale * largeScreenFactor),
      ),
    );
    return;
  }

  // Enhanced confirmation dialog
  bool confirmDelete = await showDialog(
    context: context,
    builder:
        (context) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20 * scale * largeScreenFactor),
          ),
          child: Container(
            padding: EdgeInsets.all(25 * scale * largeScreenFactor),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Delete Account",
                  style: TextStyle(
                    fontSize: 24 * scale * largeScreenFactor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 25 * scale * largeScreenFactor),
                Text(
                  "Are you sure you want to permanently delete your account? "
                  "This action cannot be undone and all your data will be lost.",
                  style: TextStyle(fontSize: 18 * scale * largeScreenFactor),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30 * scale * largeScreenFactor),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: 25 * scale * largeScreenFactor,
                          vertical: 15 * scale * largeScreenFactor,
                        ),
                      ),
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          fontSize: 18 * scale * largeScreenFactor,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: EdgeInsets.symmetric(
                          horizontal: 25 * scale * largeScreenFactor,
                          vertical: 15 * scale * largeScreenFactor,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            10 * scale * largeScreenFactor,
                          ),
                        ),
                      ),
                      child: Text(
                        "Delete",
                        style: TextStyle(
                          fontSize: 18 * scale * largeScreenFactor,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
  );

  if (!confirmDelete) return;

  try {
    final userId = user.id;

    // Step 1: Delete user-related data from database
    await supabase.from('university_users').delete().eq('user_id', userId);

    // Step 2: Call Edge Function to delete user from auth
    final response = await http.post(
      Uri.parse(
        'https://ucbgmxjmyurvixvhbotp.supabase.co/functions/v1/delete-user-test',
      ),
      headers: {
        'Authorization': 'Bearer ${supabase.auth.currentSession?.accessToken}',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'user_id': userId}),
    );

    if (response.statusCode != 200) {
      throw Exception(jsonDecode(response.body)['error']);
    }

    // Step 3: Sign out the user
    await supabase.auth.signOut();

    // Step 4: Navigate back to login screen
    Navigator.of(context).pushReplacementNamed('/login');

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Account deleted successfully',
          style: TextStyle(fontSize: 18 * scale * largeScreenFactor),
        ),
        behavior: SnackBarBehavior.floating,
        width: 400 * scale * largeScreenFactor,
        padding: EdgeInsets.all(25 * scale * largeScreenFactor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15 * scale * largeScreenFactor),
        ),
      ),
    );
  } catch (error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Error deleting account: ${error.toString()}',
          style: TextStyle(fontSize: 18 * scale * largeScreenFactor),
        ),
        behavior: SnackBarBehavior.floating,
        width: 400 * scale * largeScreenFactor,
        padding: EdgeInsets.all(25 * scale * largeScreenFactor),
        backgroundColor: Colors.red,
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// Future<void> deleteUserAccount(BuildContext context) async {
//   final supabase = Supabase.instance.client;
//   final user = supabase.auth.currentUser;

//   if (user == null) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('No user is signed in!')),
//     );
//     return;
//   }

//   // Show confirmation dialog
//   bool confirmDelete = await showDialog(
//     context: context,
//     builder: (context) => AlertDialog(
//       title: Text("Delete Account"),
//       content: Text(
//           "Are you sure you want to delete your account? This action cannot be undone."),
//       actions: [
//         TextButton(
//           onPressed: () => Navigator.of(context).pop(false),
//           child: Text("Cancel"),
//         ),
//         TextButton(
//           onPressed: () => Navigator.of(context).pop(true),
//           child: Text("Delete"),
//         ),
//       ],
//     ),
//   );

//   if (!confirmDelete) return; // Exit if user cancels

//   try {
//     final userId = user.id; // Get the user's UUID

//     // Step 1: Delete user-related data from database
//     await supabase.from('university_users').delete().eq('user_id', userId);

//     // Step 2: Call Edge Function to delete user from auth
//     final response = await http.post(
//       Uri.parse(
//           'https://ucbgmxjmyurvixvhbotp.supabase.co/functions/v1/delete-user-test'),
//       headers: {
//         'Authorization': 'Bearer ${supabase.auth.currentSession?.accessToken}',
//         'Content-Type': 'application/json',
//       },
//       body: jsonEncode({'user_id': userId}),
//     );

//     if (response.statusCode != 200) {
//       throw Exception(jsonDecode(response.body)['error']);
//     }

//     // Step 3: Sign out the user
//     await supabase.auth.signOut();

//     // Step 4: Navigate back to login screen
//     Navigator.of(context).pushReplacementNamed('/login');

//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Account deleted successfully')),
//     );
//   } catch (error) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Error deleting account: $error')),
//     );
//   }
// }

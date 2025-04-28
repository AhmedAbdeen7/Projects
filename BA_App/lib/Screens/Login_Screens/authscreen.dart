import 'package:ba_app/Screens/mainscreen.dart';
import 'package:ba_app/Screens/Login_Screens/sign_upscreen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ba_app/Screens/Login_Screens/forgot_password.dart';
import 'dart:math'; // Add this import at the top

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return AuthScreenState();
  }
}

class AuthScreenState extends State<AuthScreen> {
  // [Keep all your existing controllers and state variables]
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _resetEmailController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _isResettingPassword = false;

  // [Keep all your existing methods exactly as they were]
  Future<void> _signIn() async {
    final id = _idController.text.trim();
    final password = _passwordController.text.trim();

    if (id.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            id.isEmpty
                ? "Please enter your ID."
                : "Please enter your password.",
          ),
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final supabase = Supabase.instance.client;

      // Fetch the user's email from the database using their university ID
      final response =
          await supabase
              .from('university_users')
              .select('email')
              .eq('university_id', id)
              .single();

      final email = response['email'] ?? '';

      if (email.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Login failed. Please check your credentials."),
          ),
        );
        return;
      }

      // Sign in using Supabase Auth
      final authResponse = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (authResponse.session != null && authResponse.user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Login failed. Please check your credentials."),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Unexpected error occurred: ${e.toString()}')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _resetPassword() async {
    final id = _resetEmailController.text.trim();

    if (id.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter your university ID.")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final supabase = Supabase.instance.client;

      // Fetch user's email from database
      final response =
          await supabase
              .from('university_users')
              .select('email')
              .eq('university_id', id)
              .maybeSingle();

      if (response == null || response['email'] == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No account found with this ID.")),
        );
        return;
      }

      final email = response['email'];

      // Send password reset email
      await supabase.auth.resetPasswordForEmail(
        email,
        redirectTo: 'https://ucbgmxjmyurvixvhbotp.supabase.co/reset-password',
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password reset link sent to your email."),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Reference dimensions (based on a 375x812 design - iPhone 13)
    const double referenceWidth = 375.0;
    const double referenceHeight = 812.0;

    // Get actual screen dimensions
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    // Calculate scaling factors
    final double widthScale = screenWidth / referenceWidth;
    final double heightScale = screenHeight / referenceHeight;
    // Use the smaller scale to prevent overflow
    final double scale = min(widthScale, heightScale);

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "assets/images/BA_Logo.png",
          width: 150 * scale, // 150/375 = 40% of screen width
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 37.5 * scale,
          ), // 10% of screen width
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 81.2 * scale), // 10% of screen height
              Text(
                'Log in',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30 * scale, // 30pt in reference design
                ),
              ),
              SizedBox(height: 40.6 * scale), // 5% of screen height
              SizedBox(
                height: 60 * scale, // Fixed height for text field
                child: TextField(
                  controller: _idController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'ID',
                  ),
                ),
              ),
              SizedBox(height: 24.36 * scale), // 3% of screen height
              SizedBox(
                height: 60 * scale, // Fixed height for text field
                child: TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        size: 24 * scale, // Scale icon size
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                  obscureText: _obscurePassword,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(top: 8 * scale),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ForgotPasswordScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 215, 19, 5),
                        fontSize: 14 * scale,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.36 * scale), // 3% of screen height
              SizedBox(
                height: 50 * scale, // Fixed button height
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 215, 19, 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5 * scale),
                    ),
                  ),
                  onPressed: _isLoading ? null : _signIn,
                  child:
                      _isLoading
                          ? SizedBox(
                            width: 20 * scale,
                            height: 20 * scale,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2 * scale,
                            ),
                          )
                          : Text(
                            'log in',
                            style: TextStyle(
                              fontSize: 20 * scale,
                              color: Colors.white,
                              fontFamily: 'Alegreya',
                            ),
                          ),
                ),
              ),
              SizedBox(height: 40.6 * scale), // 5% of screen height
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (ctx) => const SignupScreen()),
                  );
                },
                child: Text(
                  "Don't have an account",
                  style: TextStyle(color: Colors.grey, fontSize: 14 * scale),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// import 'package:ba_app/Screens/mainscreen.dart';
// import 'package:ba_app/Screens/Login_Screens/sign_upscreen.dart';
// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:ba_app/Screens/Login_Screens/forgot_password.dart';

// class AuthScreen extends StatefulWidget {
//   const AuthScreen({super.key});

//   @override
//   State<StatefulWidget> createState() {
//     return AuthScreenState();
//   }
// }

// class AuthScreenState extends State<AuthScreen> {
//   final TextEditingController _idController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _resetEmailController = TextEditingController();
//   bool _isLoading = false;
//   bool _obscurePassword = true;
//   bool _isResettingPassword = false;

//   // Method to handle password reset
//   // Future<void> _resetPassword() async {
//   //   final id = _resetEmailController.text.trim();

//   //   if (id.isEmpty) {
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       const SnackBar(content: Text("Please enter your university ID.")),
//   //     );
//   //     return;
//   //   }

//   //   setState(() {
//   //     _isLoading = true;
//   //   });

//   //   try {
//   //     final supabase = Supabase.instance.client;

//   //     // Fetch the user's email from the database using their university ID
//   //     final response = await supabase
//   //         .from('university_users')
//   //         .select('email')
//   //         .eq('university_id', id)
//   //         .single();

//   //     final email = response['email'] ?? '';

//   //     if (email.isEmpty) {
//   //       ScaffoldMessenger.of(context).showSnackBar(
//   //         const SnackBar(content: Text("No account found with this ID.")),
//   //       );
//   //       return;
//   //     }

//   //     // Send a password reset email using Supabase Auth
//   //     await supabase.auth.resetPasswordForEmail(email);

//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       const SnackBar(
//   //           content: Text("Password reset link sent to your email.")),
//   //     );

//   //     // Close the reset password dialog
//   //     setState(() {
//   //       _isResettingPassword = false;
//   //     });
//   //   } catch (e) {
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       SnackBar(content: Text('Error: ${e.toString()}')),
//   //     );
//   //   } finally {
//   //     setState(() {
//   //       _isLoading = false;
//   //     });
//   //   }
//   // }

//   Future<void> _signIn() async {
//     final id = _idController.text.trim();
//     final password = _passwordController.text.trim();

//     if (id.isEmpty || password.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             id.isEmpty
//                 ? "Please enter your ID."
//                 : "Please enter your password.",
//           ),
//         ),
//       );
//       return;
//     }

//     setState(() {
//       _isLoading = true;
//     });

//     try {
//       final supabase = Supabase.instance.client;

//       // Fetch the user's email from the database using their university ID
//       final response =
//           await supabase
//               .from('university_users')
//               .select('email')
//               .eq('university_id', id)
//               .single();

//       final email = response['email'] ?? '';

//       if (email.isEmpty) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text("Login failed. Please check your credentials."),
//           ),
//         );
//         return;
//       }

//       // Sign in using Supabase Auth
//       final authResponse = await supabase.auth.signInWithPassword(
//         email: email,
//         password: password,
//       );

//       if (authResponse.session != null && authResponse.user != null) {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const MainScreen()),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text("Login failed. Please check your credentials."),
//           ),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Unexpected error occurred: ${e.toString()}')),
//       );
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   Future<void> _resetPassword() async {
//     final id = _resetEmailController.text.trim();

//     if (id.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Please enter your university ID.")),
//       );
//       return;
//     }

//     setState(() {
//       _isLoading = true;
//     });

//     try {
//       final supabase = Supabase.instance.client;

//       // Fetch user's email from database
//       final response =
//           await supabase
//               .from('university_users')
//               .select('email')
//               .eq('university_id', id)
//               .maybeSingle();

//       if (response == null || response['email'] == null) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("No account found with this ID.")),
//         );
//         return;
//       }

//       final email = response['email'];

//       // Send password reset email
//       await supabase.auth.resetPasswordForEmail(
//         email,
//         redirectTo: 'https://ucbgmxjmyurvixvhbotp.supabase.co/reset-password',
//       );

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text("Password reset link sent to your email."),
//         ),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;

//     // Show password reset dialog
//     void _showResetPasswordDialog() {
//       showDialog(
//         context: context,
//         builder:
//             (context) => AlertDialog(
//               title: const Text('Reset Password'),
//               content: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   const Text(
//                     'Enter your university ID to receive a password reset link',
//                   ),
//                   const SizedBox(height: 16),
//                   TextField(
//                     controller: _resetEmailController,
//                     decoration: const InputDecoration(
//                       border: OutlineInputBorder(),
//                       hintText: 'University ID',
//                     ),
//                   ),
//                 ],
//               ),
//               actions: [
//                 TextButton(
//                   onPressed: () => Navigator.pop(context),
//                   child: const Text('Cancel'),
//                 ),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color.fromARGB(255, 215, 19, 5),
//                   ),
//                   onPressed:
//                       _isLoading
//                           ? null
//                           : () {
//                             Navigator.pop(context);
//                             _resetPassword();
//                           },
//                   child:
//                       _isLoading
//                           ? const CircularProgressIndicator()
//                           : const Text(
//                             'Reset Password',
//                             style: TextStyle(color: Colors.white),
//                           ),
//                 ),
//               ],
//             ),
//       );
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: Image.asset(
//           "assets/images/BA_Logo.png",
//           width: screenWidth * 0.4,
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.white,
//         automaticallyImplyLeading: true,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               SizedBox(height: screenHeight * 0.1),
//               const Text(
//                 'Log in',
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
//               ),
//               SizedBox(height: screenHeight * 0.05),
//               TextField(
//                 controller: _idController,
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   hintText: 'ID',
//                 ),
//               ),
//               SizedBox(height: screenHeight * 0.03),
//               TextField(
//                 controller: _passwordController,
//                 decoration: InputDecoration(
//                   border: const OutlineInputBorder(),
//                   hintText: 'Password',
//                   suffixIcon: IconButton(
//                     icon: Icon(
//                       _obscurePassword
//                           ? Icons.visibility_off
//                           : Icons.visibility,
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         _obscurePassword = !_obscurePassword;
//                       });
//                     },
//                   ),
//                 ),
//                 obscureText: _obscurePassword,
//               ),
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: TextButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => ForgotPasswordScreen(),
//                       ),
//                     );
//                   },
//                   child: const Text(
//                     'Forgot Password?',
//                     style: TextStyle(color: Color.fromARGB(255, 215, 19, 5)),
//                   ),
//                 ),
//               ),
//               SizedBox(height: screenHeight * 0.03),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color.fromARGB(255, 215, 19, 5),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(5.0),
//                   ),
//                   padding: EdgeInsets.symmetric(
//                     horizontal: screenWidth * 0.2,
//                     vertical: screenHeight * 0.02,
//                   ),
//                 ),
//                 onPressed: _isLoading ? null : _signIn,
//                 child:
//                     _isLoading
//                         ? const SizedBox(
//                           width: 20,
//                           height: 20,
//                           child: CircularProgressIndicator(
//                             color: Colors.white,
//                             strokeWidth: 2,
//                           ),
//                         )
//                         : const Text(
//                           'log in',
//                           style: TextStyle(
//                             fontSize: 20,
//                             color: Colors.white,
//                             fontFamily: 'Alegreya',
//                           ),
//                         ),
//               ),
//               SizedBox(height: screenHeight * 0.05),
//               InkWell(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (ctx) => const SignupScreen()),
//                   );
//                 },
//                 child: const Text(
//                   "Don't have an account",
//                   style: TextStyle(color: Colors.grey),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:ba_app/Screens/main_screen.dart';
// import 'package:ba_app/Screens/sign_upscreen.dart';
// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// class AuthScreen extends StatefulWidget {
//   const AuthScreen({super.key});

//   @override
//   State<StatefulWidget> createState() {
//     return AuthScreenState();
//   }
// }

// class AuthScreenState extends State<AuthScreen> {
//   final TextEditingController _idController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   bool _isLoading = false;
//   bool _obscurePassword = true;

//   Future<void> _signIn() async {
//     final id = _idController.text.trim();
//     final password = _passwordController.text.trim();

//     if (id.isEmpty || password.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(id.isEmpty
//               ? "Please enter your ID."
//               : "Please enter your password."),
//         ),
//       );
//       return;
//     }

//     setState(() {
//       _isLoading = true;
//     });

//     try {
//       final supabase = Supabase.instance.client;
//       final response = await supabase
//           .from('university_users')
//           .select()
//           .eq('university_id', id)
//           .single();

//       if (response['email'] == null) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//               content: Text("Login failed. Please check your credentials.")),
//         );
//         return;
//       }

//       final email = response['email'] ?? '';
//       final authResponse = await supabase.auth.signInWithPassword(
//         email: email,
//         password: password,
//       );

//       if (authResponse.session != null && authResponse.user != null) {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const MainScreen()),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//               content: Text("Login failed. Please check your credentials.")),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Unexpected error occurred: ${e.toString()}')),
//       );
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;

//     return Scaffold(
//       appBar: AppBar(
//         title:
//             Image.asset("assets/images/BA_Logo.png", width: screenWidth * 0.4),
//         centerTitle: true,
//         backgroundColor: Colors.white,
//         automaticallyImplyLeading: true,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               SizedBox(height: screenHeight * 0.1),
//               const Text('Log in',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
//               SizedBox(height: screenHeight * 0.05),
//               TextField(
//                 controller: _idController,
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   hintText: 'ID',
//                 ),
//               ),
//               SizedBox(height: screenHeight * 0.03),
//               TextField(
//                 controller: _passwordController,
//                 decoration: InputDecoration(
//                   border: const OutlineInputBorder(),
//                   hintText: 'Password',
//                   suffixIcon: IconButton(
//                     icon: Icon(
//                       _obscurePassword
//                           ? Icons.visibility_off
//                           : Icons.visibility,
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         _obscurePassword = !_obscurePassword;
//                       });
//                     },
//                   ),
//                 ),
//                 obscureText: _obscurePassword,
//               ),
//               SizedBox(height: screenHeight * 0.05),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color.fromARGB(255, 215, 19, 5),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(5.0),
//                   ),
//                   padding: EdgeInsets.symmetric(
//                       horizontal: screenWidth * 0.2,
//                       vertical: screenHeight * 0.02),
//                 ),
//                 onPressed: _isLoading ? null : _signIn,
//                 child: Text(_isLoading ? 'logging in' : 'log in',
//                     style: const TextStyle(
//                       fontSize: 20,
//                       color: Colors.white,
//                       fontFamily: 'Alegreya',
//                     )),
//               ),
//               SizedBox(height: screenHeight * 0.05),
//               InkWell(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (ctx) => const SignupScreen()),
//                   );
//                 },
//                 child: const Text(
//                   "Don't have an account",
//                   style: TextStyle(color: Colors.grey),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

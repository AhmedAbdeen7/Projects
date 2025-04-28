import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ba_app/utilities/constants.dart';
import 'package:ba_app/utilities/widgets.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _resetTokenController = TextEditingController();
  bool _passwordVisible = false;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: LayoutBuilder(
          builder: (context, constraints) {
            final double screenWidth = MediaQuery.of(context).size.width;
            final double scaleFactor = screenWidth / 400;
            final double scaledFontSize = 20 * scaleFactor;

            return Text(
              'Reset Password',
              style: TextStyle(fontSize: scaledFontSize),
            );
          },
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Get screen dimensions
          final double screenWidth = MediaQuery.of(context).size.width;

          // Define scaling factors for larger screens
          final double scaleFactor = screenWidth / 400;
          final double scaledPadding = 16 * scaleFactor;
          final double scaledFontSize = 16 * scaleFactor;

          // Special larger scaling for the "Reset Password" button text
          final double buttonTextScaleFactor = scaleFactor * 1.3;
          final double scaledButtonTextSize = 16 * buttonTextScaleFactor;

          final double scaledButtonHeight = 50 * scaleFactor;
          final double spacerHeight = 20 * scaleFactor;

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(scaledPadding),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: _resetTokenController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8 * scaleFactor),
                        ),
                        hintText: 'Reset Token',
                        hintStyle: TextStyle(fontSize: scaledFontSize),
                      ),
                      style: TextStyle(fontSize: scaledFontSize),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 6) {
                          return 'Invalid token';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: spacerHeight),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8 * scaleFactor),
                        ),
                        hintText: 'Email',
                        hintStyle: TextStyle(fontSize: scaledFontSize),
                      ),
                      style: TextStyle(fontSize: scaledFontSize),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator:
                          (value) =>
                              !EmailValidator.validate(value!)
                                  ? 'Invalid email format'
                                  : null,
                    ),
                    SizedBox(height: spacerHeight),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: !_passwordVisible,
                      style: TextStyle(fontSize: scaledFontSize),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8 * scaleFactor),
                        ),
                        hintText: 'Password',
                        hintStyle: TextStyle(fontSize: scaledFontSize),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                            size: 24 * scaleFactor,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: spacerHeight),
                    SizedBox(
                      height: scaledButtonHeight,
                      width: double.infinity,
                      child: BlueButton(
                        teks: 'Reset Password',
                        padding: 0,
                        textStyle: TextStyle(fontSize: scaledButtonTextSize),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              _isLoading = true;
                            });

                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return Center(
                                  child: SizedBox(
                                    height: 50 * scaleFactor,
                                    width: 50 * scaleFactor,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 4 * scaleFactor,
                                    ),
                                  ),
                                );
                              },
                            );

                            try {
                              // Verify the OTP
                              await Supabase.instance.client.auth.verifyOTP(
                                email: _emailController.text,
                                token: _resetTokenController.text,
                                type: OtpType.recovery,
                              );

                              // Update the user's password
                              await Supabase.instance.client.auth.updateUser(
                                UserAttributes(
                                  password: _passwordController.text,
                                ),
                              );

                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Password reset successful!',
                                    style: TextStyle(
                                      fontSize: scaledFontSize * 0.9,
                                    ),
                                  ),
                                ),
                              );
                              Navigator.pop(context); // Go back to login
                            } catch (error) {
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Error: ${error.toString()}',
                                    style: TextStyle(
                                      fontSize: scaledFontSize * 0.9,
                                    ),
                                  ),
                                ),
                              );
                            } finally {
                              setState(() {
                                _isLoading = false;
                              });
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _resetTokenController.dispose();
    super.dispose();
  }
}

// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:go_router/go_router.dart';

// class ResetPasswordScreen extends StatefulWidget {
//   const ResetPasswordScreen({Key? key}) : super(key: key);

//   @override
//   State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
// }

// class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
//   final _passwordController = TextEditingController();
//   final _confirmPasswordController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   final _supabase = Supabase.instance.client;
//   bool _isLoading = false;
//   bool _obscurePassword = true;
//   bool _obscureConfirmPassword = true;

//   Future<void> _updatePassword() async {
//     if (_formKey.currentState!.validate()) {
//       setState(() {
//         _isLoading = true;
//       });

//       try {
//         // Update the user's password - this works when the user is already authenticated
//         // via the reset password link they clicked
//         final response = await _supabase.auth.updateUser(
//           UserAttributes(password: _passwordController.text),
//         );

//         if (response.user != null) {
//           if (mounted) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text('Password successfully updated!'),
//                 backgroundColor: Colors.green,
//               ),
//             );

//             // Navigate back to login screen
//             Navigator.of(context).pushReplacementNamed('/login');
//           }
//         }
//       } on AuthException catch (e) {
//         if (mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text('Error: ${e.message}'),
//               backgroundColor: Colors.red,
//             ),
//           );
//         }
//       } catch (e) {
//         if (mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text('An unexpected error occurred'),
//               backgroundColor: Colors.red,
//             ),
//           );
//         }
//         print('Update password error: $e');
//       } finally {
//         if (mounted) {
//           setState(() {
//             _isLoading = false;
//           });
//         }
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Reset Password'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Text(
//                 'Create a new password',
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 20),
//               TextFormField(
//                 controller: _passwordController,
//                 obscureText: _obscurePassword,
//                 decoration: InputDecoration(
//                   labelText: 'New Password',
//                   hintText: 'At least 8 characters',
//                   border: OutlineInputBorder(),
//                   suffixIcon: IconButton(
//                     icon: Icon(
//                       _obscurePassword
//                           ? Icons.visibility
//                           : Icons.visibility_off,
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         _obscurePassword = !_obscurePassword;
//                       });
//                     },
//                   ),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a password';
//                   }
//                   if (value.length < 8) {
//                     return 'Password must be at least 8 characters';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16),
//               TextFormField(
//                 controller: _confirmPasswordController,
//                 obscureText: _obscureConfirmPassword,
//                 decoration: InputDecoration(
//                   labelText: 'Confirm Password',
//                   hintText: 'Repeat your new password',
//                   border: OutlineInputBorder(),
//                   suffixIcon: IconButton(
//                     icon: Icon(
//                       _obscureConfirmPassword
//                           ? Icons.visibility
//                           : Icons.visibility_off,
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         _obscureConfirmPassword = !_obscureConfirmPassword;
//                       });
//                     },
//                   ),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please confirm your password';
//                   }
//                   if (value != _passwordController.text) {
//                     return 'Passwords do not match';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 24),
//               ElevatedButton(
//                 onPressed: _isLoading ? null : _updatePassword,
//                 child: _isLoading
//                     ? SizedBox(
//                         height: 20,
//                         width: 20,
//                         child: CircularProgressIndicator(
//                           strokeWidth: 2,
//                           color: Colors.white,
//                         ),
//                       )
//                     : Text('Reset Password'),
//                 style: ElevatedButton.styleFrom(
//                   padding: EdgeInsets.symmetric(vertical: 16),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _passwordController.dispose();
//     _confirmPasswordController.dispose();
//     super.dispose();
//   }
// }

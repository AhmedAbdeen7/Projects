import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ba_app/Screens/Login_Screens/reset_password.dart';
import 'package:ba_app/utilities/constants.dart';
import 'package:ba_app/utilities/widgets.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
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
              'Forgot Password',
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

          // Special larger scaling for the "Send Reset Token" button text
          final double buttonTextScaleFactor = scaleFactor * 1.3;
          final double scaledButtonTextSize = 16 * buttonTextScaleFactor;

          final double scaledButtonHeight = 50 * scaleFactor;
          final double spacerHeight = 20 * scaleFactor;

          return Padding(
            padding: EdgeInsets.all(scaledPadding),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8 * scaleFactor),
                      ),
                      hintText: 'Email',
                      hintStyle: TextStyle(fontSize: scaledFontSize),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: TextStyle(fontSize: scaledFontSize),
                    validator:
                        (value) =>
                            !EmailValidator.validate(value!)
                                ? 'Invalid email format'
                                : null,
                  ),
                  SizedBox(height: spacerHeight),
                  SizedBox(
                    height: scaledButtonHeight,
                    width: double.infinity,
                    child: BlueButton(
                      teks: 'Send Reset Token',
                      padding: 0,
                      textStyle: TextStyle(fontSize: scaledButtonTextSize),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          showDialog(
                            context: context,
                            builder:
                                (context) => AlertDialog(
                                  content: Container(
                                    child: Text(
                                      'Please check your email (and spam folder) for the reset token.',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: scaledFontSize,
                                      ),
                                    ),
                                  ),
                                ),
                          );
                          try {
                            await Supabase.instance.client.auth
                                .resetPasswordForEmail(_emailController.text);
                          } catch (error) {
                            print(error);
                          }
                        }
                      },
                    ),
                  ),
                  SizedBox(height: spacerHeight),
                  TextButton(
                    child: Text(
                      'Already have a token? Reset Password',
                      style: TextStyle(fontSize: scaledFontSize),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ResetPasswordScreen(),
                        ),
                      );
                    },
                  ),
                ],
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
    super.dispose();
  }
}

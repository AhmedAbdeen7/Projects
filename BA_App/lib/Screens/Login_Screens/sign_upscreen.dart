import 'package:ba_app/Screens/mainscreen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

String? _selectedMajor; // Variable to store the selected major
final List<String> _majors = [
  'Finance',
  'Marketing',
  'MICT',
  'Entrepeneurship',
  'Undeclared',
];

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return SignupScreenState();
  }
}

class SignupScreenState extends State<SignupScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _signUp() async {
    if (!_validateFields()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Check if the university ID already exists
      final idCheckResponse = await Supabase.instance.client
          .from('university_users')
          .select()
          .eq('university_id', _idController.text.trim());

      if (idCheckResponse.isNotEmpty) {
        _showError(
          "The ID is already associated with an account. Please use a different ID.",
        );
        setState(() {
          _isLoading = false;
        });
        return;
      }
      // Attempt to sign up the user

      final response = await Supabase.instance.client.auth.signUp(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (response.session != null && response.user != null) {
        // Store additional user details in a separate table
        await Supabase.instance.client.from('university_users').insert({
          'university_id': _idController.text.trim(),
          'user_id': response.user!.id,
          'username': _nameController.text.trim(),
          'major': _selectedMajor,
          'email': _emailController.text.trim(),
        });

        // Navigate to the home screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Sign-up failed. Please try again.")),
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

  bool _validateFields() {
    if (_nameController.text.trim().isEmpty) {
      _showError("Name is required.");
      return false;
    }
    if (!RegExp(r'^\d{9}$').hasMatch(_idController.text.trim())) {
      _showError("ID must consist of 9 digits.");
      return false;
    }
    if (_idController.text.trim().isEmpty) {
      _showError("ID is required.");
      return false;
    }
    if (_idController.text.trim().length != 9) {
      _showError("ID must be 9 numbers.");
      return false;
    }
    if (_emailController.text.trim().isEmpty) {
      _showError("Email is required.");
      return false;
    }
    if (!_emailController.text.trim().endsWith("@aucegypt.edu")) {
      _showError("Email must end with @aucegypt.edu.");
      return false;
    }
    if (_passwordController.text.trim().isEmpty) {
      _showError("Password is required.");
      return false;
    }
    if (_passwordController.text.trim().length < 6) {
      _showError("Password must be at least 6 characters.");
      return false;
    }
    if (_selectedMajor == null) {
      _showError("Major is required.");
      return false;
    }

    return true;
  }

  void _showError(String message) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double scaleFactor = screenWidth / 400;
    final double scaledFontSize = 14 * scaleFactor;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(fontSize: scaledFontSize)),
      ),
    );
  }

  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    // Define scaling factors for responsive design
    final double scaleFactor = screenWidth / 400;
    final double titleFontSize =
        36 * scaleFactor; // Base size for "Sign up now!"
    final double labelFontSize = 18 * scaleFactor; // Base size for field labels
    final double inputFontSize = 16 * scaleFactor; // Base size for input text
    final double buttonFontSize = 20 * scaleFactor; // Base size for button text
    final double iconSize = 24 * scaleFactor; // Base size for icons

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "assets/images/BA_Logo.png",
          height: 40 * scaleFactor,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.05),
              Text(
                'Sign up now!',
                style: TextStyle(
                  fontFamily: 'Alegreya',
                  color: const Color.fromARGB(255, 124, 15, 7),
                  fontWeight: FontWeight.bold,
                  fontSize: titleFontSize,
                ),
              ),
              SizedBox(height: screenHeight * 0.05),
              _buildTextField(
                "Name*",
                _nameController,
                labelFontSize,
                inputFontSize,
              ),
              _buildTextField(
                "ID*",
                _idController,
                labelFontSize,
                inputFontSize,
              ),
              _buildTextField(
                "E-mail*",
                _emailController,
                labelFontSize,
                inputFontSize,
              ),
              _buildTextField(
                "Password*",
                _passwordController,
                labelFontSize,
                inputFontSize,
                obscureText: _obscurePassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    size: iconSize,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              _buildMajorDropdown(labelFontSize, inputFontSize, iconSize),
              SizedBox(height: screenHeight * 0.05),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 215, 19, 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.67 * scaleFactor),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 30 * scaleFactor,
                      vertical: 15 * scaleFactor,
                    ),
                  ),
                  onPressed: _isLoading ? null : _signUp,
                  child: Text(
                    _isLoading ? 'Submitting' : 'Submit',
                    style: TextStyle(
                      fontSize: buttonFontSize,
                      color: Colors.white,
                      fontFamily: 'Alegreya',
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.05),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller,
    double labelFontSize,
    double inputFontSize, {
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double scaleFactor = screenWidth / 400;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: labelFontSize,
            color: const Color.fromARGB(149, 116, 116, 110),
          ),
        ),
        SizedBox(height: 8 * scaleFactor),
        TextField(
          controller: controller,
          obscureText: obscureText,
          style: TextStyle(fontSize: inputFontSize),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.67 * scaleFactor),
            ),
            suffixIcon: suffixIcon,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16 * scaleFactor,
              vertical: 12 * scaleFactor,
            ),
          ),
        ),
        SizedBox(height: 16 * scaleFactor),
      ],
    );
  }

  Widget _buildMajorDropdown(
    double labelFontSize,
    double inputFontSize,
    double iconSize,
  ) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double scaleFactor = screenWidth / 400;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Major*",
          style: TextStyle(
            fontSize: labelFontSize,
            color: const Color.fromARGB(149, 116, 116, 110),
          ),
        ),
        SizedBox(height: 8 * scaleFactor),
        DropdownButtonFormField<String>(
          value: _selectedMajor,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.67 * scaleFactor),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16 * scaleFactor,
              vertical: 12 * scaleFactor,
            ),
          ),
          hint: Text(
            'Select your major',
            style: TextStyle(fontSize: inputFontSize),
          ),
          items:
              _majors.map((String major) {
                return DropdownMenuItem<String>(
                  value: major,
                  child: Row(
                    children: [
                      Icon(Icons.school, color: Colors.red, size: iconSize),
                      SizedBox(width: 10 * scaleFactor),
                      Text(
                        major,
                        style: TextStyle(
                          fontSize: inputFontSize,
                          color: const Color.fromARGB(255, 124, 15, 7),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _selectedMajor = newValue;
            });
          },
          dropdownColor: Colors.white,
          icon: Icon(Icons.arrow_drop_down, size: iconSize),
          iconSize: iconSize,
          style: TextStyle(color: Colors.black, fontSize: inputFontSize),
        ),
      ],
    );
  }
}
// import 'package:ba_app/Screens/mainscreen.dart';
// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// String? _selectedMajor; // Variable to store the selected major
// final List<String> _majors = [
//   'Finance',
//   'Marketing',
//   'MICT',
//   'Entrepeneurship',
//   'Undeclared',
// ];

// class SignupScreen extends StatefulWidget {
//   const SignupScreen({super.key});

//   @override
//   State<StatefulWidget> createState() {
//     return SignupScreenState();
//   }
// }

// class SignupScreenState extends State<SignupScreen> {
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _idController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   bool _isLoading = false;

//   Future<void> _signUp() async {
//     if (!_validateFields()) return;

//     setState(() {
//       _isLoading = true;
//     });

//     try {
//       // final idAsEmail = "${_idController.text.trim()}@email.com";

//       // Check if the university ID already exists
//       final idCheckResponse = await Supabase.instance.client
//           .from('university_users')
//           .select()
//           .eq('university_id', _idController.text.trim());

//       if (idCheckResponse.isNotEmpty) {
//         _showError(
//           "The ID is already associated with an account. Please use a different ID.",
//         );
//         setState(() {
//           _isLoading = false;
//         });
//         return;
//       }
//       // Attempt to sign up the user

//       final response = await Supabase.instance.client.auth.signUp(
//         email: _emailController.text.trim(),
//         password: _passwordController.text.trim(),
//       );
//       // final userId = Supabase.instance.client.auth.currentUser?.id;

//       // print('university_id: ${_idController.text.trim()}'); // Debug log

//       if (response.session != null && response.user != null) {
//         // Store additional user details in a separate table
//         await Supabase.instance.client.from('university_users').insert({
//           'university_id': _idController.text.trim(),
//           'user_id': response.user!.id,
//           'username': _nameController.text.trim(),
//           'major': _selectedMajor,
//           'email': _emailController.text.trim(),
//         });

//         // Navigate to the home screen
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const MainScreen()),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Sign-up failed. Please try again.")),
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

//   bool _validateFields() {
//     if (_nameController.text.trim().isEmpty) {
//       _showError("Name is required.");
//       return false;
//     }
//     if (!RegExp(r'^\d{9}$').hasMatch(_idController.text.trim())) {
//       _showError("ID must consist of 9 digits.");
//       return false;
//     }
//     if (_idController.text.trim().isEmpty) {
//       _showError("ID is required.");
//       return false;
//     }
//     if (_idController.text.trim().length != 9) {
//       _showError("ID must be 9 numbers.");
//       return false;
//     }
//     if (_emailController.text.trim().isEmpty) {
//       _showError("Email is required.");
//       return false;
//     }
//     if (!_emailController.text.trim().endsWith("@aucegypt.edu")) {
//       _showError("Email must end with @aucegypt.edu.");
//       return false;
//     }
//     if (_passwordController.text.trim().isEmpty) {
//       _showError("Password is required.");
//       return false;
//     }
//     if (_passwordController.text.trim().length < 6) {
//       _showError("Password must be at least 6 characters.");
//       return false;
//     }
//     if (_selectedMajor == null) {
//       _showError("Major is required.");
//       return false;
//     }

//     return true;
//   }

//   void _showError(String message) {
//     ScaffoldMessenger.of(
//       context,
//     ).showSnackBar(SnackBar(content: Text(message)));
//   }

//   bool _obscurePassword = true;

//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = MediaQuery.of(context).size.height;
//     double screenWidth = MediaQuery.of(context).size.width;

//     return Scaffold(
//       appBar: AppBar(
//         title: Image.asset("assets/images/BA_Logo.png"),
//         centerTitle: true,
//         backgroundColor: Colors.white,
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           color: Colors.white,
//           padding: EdgeInsets.symmetric(
//             horizontal: screenWidth * 0.1,
//           ), // Padding for responsive spacing
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(
//                 height: screenHeight * 0.05,
//               ), // Adjusts top spacing based on screen size
//               Text(
//                 'Sign up now!',
//                 style: TextStyle(
//                   fontFamily: 'Alegreya',
//                   color: const Color.fromARGB(255, 124, 15, 7),
//                   fontWeight: FontWeight.bold,
//                   fontSize: screenHeight * 0.05, // Responsive font size
//                 ),
//               ),
//               SizedBox(
//                 height: screenHeight * 0.05,
//               ), // Space between title and fields
//               _buildTextField("Name*", _nameController),
//               _buildTextField("ID*", _idController),
//               _buildTextField("E-mail*", _emailController),
//               _buildTextField(
//                 "Password*",
//                 _passwordController,
//                 obscureText: _obscurePassword,
//                 suffixIcon: IconButton(
//                   icon: Icon(
//                     _obscurePassword ? Icons.visibility_off : Icons.visibility,
//                   ),
//                   onPressed: () {
//                     setState(() {
//                       _obscurePassword = !_obscurePassword;
//                     });
//                   },
//                 ),
//               ),
//               SizedBox(
//                 height: screenHeight * 0.03,
//               ), // Space before major dropdown
//               _buildMajorDropdown(),
//               SizedBox(height: screenHeight * 0.05), // Bottom space for button
//               Center(
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color.fromARGB(255, 215, 19, 5),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20.67),
//                     ),
//                   ),
//                   onPressed: _isLoading ? null : _signUp,
//                   child: Text(
//                     _isLoading ? 'Submitting' : 'Submit',
//                     style: TextStyle(
//                       fontSize: screenWidth * 0.05, // Responsive font size
//                       color: Colors.white,
//                       fontFamily: 'Alegreya',
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField(
//     String label,
//     TextEditingController controller, {
//     bool obscureText = false,
//     Widget? suffixIcon,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: const TextStyle(
//             fontSize: 18,
//             color: Color.fromARGB(149, 116, 116, 110),
//           ),
//         ),
//         const SizedBox(height: 8),
//         TextField(
//           controller: controller,
//           obscureText: obscureText,
//           decoration: InputDecoration(
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(20.67),
//             ),
//             suffixIcon: suffixIcon,
//           ),
//         ),
//         const SizedBox(height: 16),
//       ],
//     );
//   }

//   Widget _buildMajorDropdown() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           "Major*",
//           style: TextStyle(
//             fontSize: 18,
//             color: Color.fromARGB(149, 116, 116, 110),
//           ),
//         ),
//         const SizedBox(height: 8),
//         DropdownButtonFormField<String>(
//           value: _selectedMajor,
//           decoration: InputDecoration(
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(20.67),
//             ),
//           ),
//           hint: const Text('Select your major'),
//           items:
//               _majors.map((String major) {
//                 return DropdownMenuItem<String>(
//                   value: major,
//                   child: Row(
//                     children: [
//                       const Icon(
//                         Icons.school, // Example icon
//                         color: Colors.red,
//                       ),
//                       const SizedBox(width: 10),
//                       Text(
//                         major,
//                         style: const TextStyle(
//                           fontSize: 16,
//                           color: Color.fromARGB(
//                             255,
//                             124,
//                             15,
//                             7,
//                           ), // Your custom color
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               }).toList(),
//           onChanged: (String? newValue) {
//             setState(() {
//               _selectedMajor = newValue;
//             });
//           },
//           dropdownColor: Colors.white, // Background color of dropdown
//           icon: const Icon(Icons.arrow_drop_down), // Dropdown icon
//           iconSize: 24,
//           style: const TextStyle(color: Colors.black, fontSize: 16),
//         ),
//       ],
//     );
//   }
// }

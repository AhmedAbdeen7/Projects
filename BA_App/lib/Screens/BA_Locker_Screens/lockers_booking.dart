// // import 'package:ba_app/Screens/mainscreen.dart';
// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:ba_app/Screens/BA_Locker_Screens/locker_info.dart';

// class LockersBooking extends StatefulWidget {
//   const LockersBooking({super.key});

//   @override
//   State<StatefulWidget> createState() {
//     return LockersBookingState();
//   }
// }

// class LockersBookingState extends State<LockersBooking> {
//   final TextEditingController _first_nameController = TextEditingController();
//   final TextEditingController _last_nameController = TextEditingController();
//   final TextEditingController _phone_number_Controller =
//       TextEditingController();
//   final TextEditingController _idController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   bool _isLoading = false;

//   Future<bool> hasExistingBooking(String userUid, DateTime date) async {
//     final supabase = Supabase.instance.client;

//     final response =
//         await supabase
//             .from('lockers')
//             .select('id')
//             .eq('user_uid', userUid)
//             .eq('booking_date', date.toIso8601String().substring(0, 10))
//             .maybeSingle();

//     return response != null; // Returns true if a booking exists
//   }

//   Future<int?> bookLocker(Map<String, dynamic> userDetails) async {
//     final supabase = Supabase.instance.client;
//     final user = supabase.auth.currentUser;
//     if (user == null) {
//       _showError("User not authenticated.");
//       return null;
//     }

//     final String userUid = user.id;
//     final DateTime now = DateTime.now();
//     final DateTime expiresAt = now.add(
//       Duration(days: 1),
//     ); // Locker expires in 1 day

//     try {
//       if (await hasExistingBooking(userUid, now)) {
//         _showError("You have already booked a locker today.");
//         return null;
//       }

//       final response =
//           await supabase
//               .from('lockers')
//               .select('id')
//               .eq('is_booked', false)
//               .limit(1)
//               .maybeSingle();

//       if (response == null) {
//         _showError("No available lockers.");
//         return null;
//       }

//       final lockerId = response['id'] as int;

//       await supabase
//           .from('lockers')
//           .update({
//             'is_booked': true,
//             'user_uid': userUid,
//             'booking_date': now.toIso8601String().substring(0, 10),
//             'expires_at': expiresAt.toIso8601String(), // Set expiry time
//             'first_name': userDetails['first_name'],
//             'last_name': userDetails['last_name'],
//             'email': userDetails['email'],
//             'phone_number': userDetails['phone_number'],
//             'university_id': userDetails['id'],
//           })
//           .eq('id', lockerId);

//       return lockerId;
//     } catch (e) {
//       _showError("An error occurred: ${e.toString()}");
//       return null;
//     }
//   }

//   // void _showLockerNumberDialog(BuildContext context, String lockerId) {
//   //   showDialog(
//   //     context: context,
//   //     builder: (context) {
//   //       return AlertDialog(
//   //         title: Text('Locker Assigned'),
//   //         content: Text('Your locker number is $lockerId.'),
//   //         actions: [
//   //           TextButton(
//   //             onPressed: () {
//   //               Navigator.pop(context);
//   //             },
//   //             child: Text('OK'),
//   //           ),
//   //         ],
//   //       );
//   //     },
//   //   );
//   // }

//   bool _validateFields() {
//     // Validate first name
//     if (!_validateName(_first_nameController.text, "First Name")) {
//       return false;
//     }

//     // Validate last name
//     if (!_validateName(_last_nameController.text, "Last Name")) {
//       return false;
//     }

//     // Validate ID
//     if (!_validateID(_idController.text)) {
//       return false;
//     }

//     // Validate email
//     if (!_validateEmail(_emailController.text)) {
//       return false;
//     }

//     if (!_validatePhoneNumber(_phone_number_Controller.text)) {
//       return false;
//     }

//     // All fields are valid
//     return true;
//   }

//   bool _validateName(String name, String fieldName) {
//     if (name.trim().isEmpty) {
//       _showError("$fieldName is required.");
//       return false;
//     }
//     return true;
//   }

//   bool _validateID(String id) {
//     if (id.trim().isEmpty) {
//       _showError("ID is required.");
//       return false;
//     }
//     if (!RegExp(r'^\d{9}$').hasMatch(id.trim())) {
//       _showError("ID must consist of exactly 9 digits.");
//       return false;
//     }
//     return true;
//   }

//   bool _validateEmail(String email) {
//     if (email.trim().isEmpty) {
//       _showError("Email is required.");
//       return false;
//     }
//     if (!RegExp(r'^[\w-]+(\.[\w-]+)*@aucegypt\.edu$').hasMatch(email.trim())) {
//       _showError("Email must end with @aucegypt.edu.");
//       return false;
//     }
//     return true;
//   }

//   bool _validatePhoneNumber(String phoneNumber) {
//     if (phoneNumber.trim().isEmpty) {
//       _showError("Phone number is required.");
//       return false;
//     }
//     return true;
//   }

//   void _showError(String message) {
//     ScaffoldMessenger.of(
//       context,
//     ).showSnackBar(SnackBar(content: Text(message)));
//   }

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
//           padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               SizedBox(height: screenHeight * 0.05),
//               Text(
//                 'Locker Booking',
//                 style: TextStyle(
//                   fontFamily: 'Alegreya',
//                   color: const Color.fromARGB(255, 124, 15, 7),
//                   fontWeight: FontWeight.bold,
//                   fontSize: screenHeight * 0.05,
//                 ),
//               ),
//               SizedBox(height: screenHeight * 0.05),
//               _buildTextField("First Name*", _first_nameController),
//               _buildTextField("Last Name*", _last_nameController),
//               _buildTextField("E-mail*", _emailController),
//               _buildTextField("Phone Number*", _phone_number_Controller),
//               _buildTextField("ID*", _idController),
//               SizedBox(height: screenHeight * 0.03),
//               Center(
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color.fromARGB(255, 215, 19, 5),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20.67),
//                     ),
//                   ),
//                   onPressed:
//                       _isLoading
//                           ? null
//                           : () async {
//                             if (_validateFields()) {
//                               setState(() {
//                                 _isLoading = true;
//                               });

//                               final userDetails = {
//                                 'first_name': _first_nameController.text.trim(),
//                                 'last_name': _last_nameController.text.trim(),
//                                 'email': _emailController.text.trim(),
//                                 'phone_number':
//                                     _phone_number_Controller.text.trim(),
//                                 'id': _idController.text.trim(),
//                                 'user_uid':
//                                     Supabase
//                                         .instance
//                                         .client
//                                         .auth
//                                         .currentUser
//                                         ?.id, // Use Supabase UID
//                               };

//                               final lockerId = await bookLocker(userDetails);

//                               setState(() {
//                                 _isLoading = false;
//                               });

//                               if (lockerId != null) {
//                                 // _showLockerNumberDialog(
//                                 //     context, lockerId.toString());
//                                 Future.delayed(Duration(seconds: 2), () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder:
//                                           (context) => LockerInfoPage(
//                                             lockerId: lockerId,
//                                           ),
//                                     ),
//                                   );
//                                 });
//                               }
//                             }
//                           },
//                   child: Text(
//                     _isLoading ? 'Submitting' : 'Submit',
//                     style: TextStyle(
//                       fontSize: screenWidth * 0.05,
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
//             contentPadding: EdgeInsets.symmetric(
//               vertical: 10,
//             ), // Adjust this value
//           ),
//         ),
//         const SizedBox(height: 16),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ba_app/Screens/BA_Locker_Screens/locker_info.dart';
import 'package:flutter/src/rendering/box.dart';

class LockersBooking extends StatefulWidget {
  const LockersBooking({super.key});

  @override
  State<StatefulWidget> createState() {
    return LockersBookingState();
  }
}

class LockersBookingState extends State<LockersBooking> {
  final TextEditingController _first_nameController = TextEditingController();
  final TextEditingController _last_nameController = TextEditingController();
  final TextEditingController _phone_number_Controller =
      TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;

  Future<bool> hasExistingBooking(String userUid) async {
    final supabase = Supabase.instance.client;
    final response =
        await supabase
            .from('lockers')
            .select('id')
            .eq('user_uid', userUid)
            .gt(
              'expires_at',
              DateTime.now().toUtc().toIso8601String(),
            ) // Ensure UTC consistency
            .maybeSingle();

    return response != null;
  }

  Future<int?> bookLocker(Map<String, dynamic> userDetails) async {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;
    if (user == null) {
      _showError("User not authenticated.");
      return null;
    }

    final String userUid = user.id;
    final DateTime now = DateTime.now();
    final DateTime expiresAt = now.add(
      const Duration(days: 7),
    ); // Set expiration to 1 week
    try {
      if (await hasExistingBooking(userUid)) {
        _showError("You have already booked a locker in the past week.");
        return null;
      }

      final response =
          await supabase
              .from('lockers')
              .select('id')
              .eq('is_booked', false)
              .order('id', ascending: true) // Add consistent ordering
              .limit(1)
              .maybeSingle();

      if (response == null) {
        _showError("No available lockers.");
        return null;
      }

      final lockerId = response?['id'] as int;

      await supabase
          .from('lockers')
          .update({
            'is_booked': true,
            'user_uid': userUid,
            'booking_date': now.toIso8601String().substring(0, 10),
            'expires_at': expiresAt.toIso8601String(),
            'first_name': userDetails['first_name'],
            'last_name': userDetails['last_name'],
            'email': userDetails['email'],
            'phone_number': userDetails['phone_number'],
            'university_id': userDetails['id'],
          })
          .eq('id', lockerId)
          .eq('is_booked', false)
          .select('id')
          .maybeSingle();

      return lockerId;
    } catch (e) {
      _showError("An error occurred: ${e.toString()}");
      return null;
    }
  }

  bool _validateFields() {
    if (!_validateName(_first_nameController.text, "First Name")) return false;
    if (!_validateName(_last_nameController.text, "Last Name")) return false;
    if (!_validateID(_idController.text)) return false;
    if (!_validateEmail(_emailController.text)) return false;
    if (!_validatePhoneNumber(_phone_number_Controller.text)) return false;
    return true;
  }

  bool _validateName(String name, String fieldName) {
    if (name.trim().isEmpty) {
      _showError("$fieldName is required.");
      return false;
    }
    return true;
  }

  bool _validateID(String id) {
    if (id.trim().isEmpty) {
      _showError("ID is required.");
      return false;
    }
    if (!RegExp(r'^\d{9}$').hasMatch(id.trim())) {
      _showError("ID must consist of exactly 9 digits.");
      return false;
    }
    return true;
  }

  bool _validateEmail(String email) {
    if (email.trim().isEmpty) {
      _showError("Email is required.");
      return false;
    }
    if (!RegExp(r'^[\w-]+(\.[\w-]+)*@aucegypt\.edu$').hasMatch(email.trim())) {
      _showError("Email must end with @aucegypt.edu.");
      return false;
    }
    return true;
  }

  bool _validatePhoneNumber(String phoneNumber) {
    if (phoneNumber.trim().isEmpty) {
      _showError("Phone number is required.");
      return false;
    }
    return true;
  }

  void _showError(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AspectRatio(
          aspectRatio: 1,
          child: Image.asset("assets/images/BA_Logo.png"),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final baseSize =
              constraints.maxHeight < constraints.maxWidth
                  ? constraints.maxHeight
                  : constraints.maxWidth;

          return SingleChildScrollView(
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: baseSize * 0.1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: baseSize * 0.05),
                  Text(
                    'Locker Booking',
                    style: TextStyle(
                      fontFamily: 'Alegreya',
                      color: const Color.fromARGB(255, 124, 15, 7),
                      fontWeight: FontWeight.bold,
                      fontSize: baseSize * 0.05,
                    ),
                  ),
                  SizedBox(height: baseSize * 0.05),
                  _buildTextField(
                    "First Name*",
                    _first_nameController,
                    baseSize,
                  ),
                  _buildTextField("Last Name*", _last_nameController, baseSize),
                  _buildTextField("E-mail*", _emailController, baseSize),
                  _buildTextField(
                    "Phone Number*",
                    _phone_number_Controller,
                    baseSize,
                  ),
                  _buildTextField("ID*", _idController, baseSize),
                  SizedBox(height: baseSize * 0.03),
                  FractionallySizedBox(
                    widthFactor: 0.8,
                    child: Container(
                      height: baseSize * 0.12,
                      margin: EdgeInsets.symmetric(vertical: baseSize * 0.02),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(
                            255,
                            215,
                            19,
                            5,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              baseSize * 0.04,
                            ),
                          ),
                        ),
                        onPressed:
                            _isLoading
                                ? null
                                : () async {
                                  if (_validateFields()) {
                                    setState(() => _isLoading = true);
                                    final userDetails = {
                                      'first_name':
                                          _first_nameController.text.trim(),
                                      'last_name':
                                          _last_nameController.text.trim(),
                                      'email': _emailController.text.trim(),
                                      'phone_number':
                                          _phone_number_Controller.text.trim(),
                                      'id': _idController.text.trim(),
                                      'user_uid':
                                          Supabase
                                              .instance
                                              .client
                                              .auth
                                              .currentUser
                                              ?.id,
                                    };

                                    final lockerId = await bookLocker(
                                      userDetails,
                                    );
                                    setState(() => _isLoading = false);

                                    if (lockerId != null) {
                                      Future.delayed(
                                        const Duration(seconds: 2),
                                        () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder:
                                                  (context) => LockerInfoPage(
                                                    lockerId: lockerId,
                                                  ),
                                            ),
                                          );
                                        },
                                      );
                                    }
                                  }
                                },
                        child: Text(
                          _isLoading ? 'Submitting' : 'Submit',
                          style: TextStyle(
                            fontSize: baseSize * 0.04,
                            color: Colors.white,
                            fontFamily: 'Alegreya',
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller,
    double baseSize,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: baseSize * 0.035,
            color: const Color.fromARGB(149, 116, 116, 110),
          ),
        ),
        SizedBox(height: baseSize * 0.015),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(baseSize * 0.04),
            ),
            contentPadding: EdgeInsets.symmetric(
              vertical: baseSize * 0.02,
              horizontal: baseSize * 0.03,
            ),
          ),
        ),
        SizedBox(height: baseSize * 0.03),
      ],
    );
  }
}

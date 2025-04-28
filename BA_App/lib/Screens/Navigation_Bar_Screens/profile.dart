import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ba_app/Screens/Login_Screens/deleteaccount.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final supabase = Supabase.instance.client;

  late TextEditingController nameController;
  late TextEditingController majorController;
  late TextEditingController emailController;
  late TextEditingController idController;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    majorController = TextEditingController();
    emailController = TextEditingController(); // Initialize emailController
    idController = TextEditingController();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    try {
      final user = supabase.auth.currentUser;
      if (user == null) {
        print('User is not logged in');
        setState(() => isLoading = false);
        return;
      }

      final email = user.email;
      if (email == null) {
        print('User email is null');
        setState(() => isLoading = false);
        return;
      }

      final response =
          await supabase
              .from('university_users')
              .select()
              .eq('email', email)
              .single();

      setState(() {
        nameController.text = response['username'] ?? '';
        majorController.text = response['major'] ?? '';
        emailController.text = response['email'] ?? '';
        idController.text = response['university_id'] ?? '';
        isLoading = false;
      });
    } catch (error) {
      print('Error fetching profile: $error');
      setState(() => isLoading = false);
    }
  }

  Future<void> _updateProfile() async {
    if (supabase.auth.currentUser == null) return;

    try {
      final email = supabase.auth.currentUser?.email ?? '';
      final updates = {
        'username': nameController.text,
        'major': majorController.text,
        'university_id': idController.text,
      };

      await supabase
          .from('university_users')
          .update(updates)
          .eq('email', email);

      // if (emailController.text.trim() != email) {
      //   await supabase.auth.updateUser(
      //     UserAttributes(email: emailController.text.trim()),
      //   );
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(
      //       content: Text('Profile and email updated successfully!'),
      //     ),
      //   );
      // } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully!')),
      );
    } catch (error) {
      print('Error updating profile: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update profile.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isPortrait = screenSize.height > screenSize.width;
    final unit = isPortrait ? screenSize.height : screenSize.width;

    final logoHeight = unit * 0.1;
    final titleFontSize = unit * 0.05;
    final labelFontSize = unit * 0.035;
    final fieldHeight = unit * 0.08;
    final horizontalPadding = unit * 0.05;
    final verticalSpacing = unit * 0.025;
    final borderRadius = unit * 0.03;

    if (isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: Image.asset("assets/images/BA_Logo.png", height: logoHeight),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 252, 251, 251),
          elevation: 0,
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Image.asset("assets/images/BA_Logo.png", height: logoHeight),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 252, 251, 251),
        elevation: 0,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
                minWidth: constraints.maxWidth,
              ),
              child: IntrinsicHeight(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: unit * 0.05),
                      Text(
                        'My Profile',
                        style: TextStyle(
                          fontFamily: 'Alegreya',
                          color: const Color.fromARGB(255, 124, 15, 7),
                          fontWeight: FontWeight.bold,
                          fontSize: titleFontSize,
                        ),
                      ),
                      SizedBox(height: verticalSpacing * 2),
                      _buildProfileField(
                        context: context,
                        label: "Name",
                        controller: nameController,
                        unit: unit,
                        labelFontSize: labelFontSize,
                        fieldHeight: fieldHeight,
                        borderRadius: borderRadius,
                      ),
                      SizedBox(height: verticalSpacing),
                      _buildProfileField(
                        context: context,
                        label: "Major",
                        controller: majorController,
                        unit: unit,
                        labelFontSize: labelFontSize,
                        fieldHeight: fieldHeight,
                        borderRadius: borderRadius,
                      ),
                      SizedBox(height: verticalSpacing),
                      _buildProfileField(
                        context: context,
                        label: "E-mail",
                        controller: emailController,
                        unit: unit,
                        labelFontSize: labelFontSize,
                        fieldHeight: fieldHeight,
                        borderRadius: borderRadius,
                        isEditable: false, // Make email field non-editable
                      ),
                      SizedBox(height: verticalSpacing),
                      _buildProfileField(
                        context: context,
                        label: "ID",
                        controller: idController,
                        unit: unit,
                        labelFontSize: labelFontSize,
                        fieldHeight: fieldHeight,
                        borderRadius: borderRadius,
                      ),
                      SizedBox(height: verticalSpacing * 2),
                      // Modified delete button with smaller size
                      Center(
                        child: SizedBox(
                          width: unit * 0.5, // Reduced width
                          child: ElevatedButton(
                            onPressed: () => deleteUserAccount(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFE51818),
                              padding: EdgeInsets.symmetric(
                                vertical: fieldHeight * 0.35, // Reduced height
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  borderRadius,
                                ),
                              ),
                            ),
                            child: Text(
                              "Delete Account", // Slightly shorter text
                              style: TextStyle(
                                fontSize: labelFontSize * 0.9,
                                color: Colors.white,
                              ), // Slightly smaller font
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: verticalSpacing),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileField({
    required BuildContext context,
    required String label,
    required TextEditingController controller,
    required double unit,
    required double labelFontSize,
    required double fieldHeight,
    required double borderRadius,
    bool isEditable = true, // Add a flag for editability
  }) {
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
        SizedBox(height: unit * 0.01),
        EditableProfileField(
          controller: controller,
          onUpdate: _updateProfile,
          fieldHeight: fieldHeight,
          borderRadius: borderRadius,
          fontSize: labelFontSize * 1.2,
          isEditable: isEditable, // Pass the flag
        ),
      ],
    );
  }
}

class EditableProfileField extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onUpdate;
  final double fieldHeight;
  final double borderRadius;
  final double fontSize;
  final bool isEditable;

  const EditableProfileField({
    super.key,
    required this.controller,
    required this.onUpdate,
    required this.fieldHeight,
    required this.borderRadius,
    this.fontSize = 16,
    this.isEditable = true, // Default to editable
  });

  @override
  _EditableProfileFieldState createState() => _EditableProfileFieldState();
}

class _EditableProfileFieldState extends State<EditableProfileField> {
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.fieldHeight,
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(widget.borderRadius),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: widget.fieldHeight * 0.2,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: TextField(
                    controller: widget.controller,
                    enabled: widget.isEditable && isEditing,
                    decoration: const InputDecoration(border: InputBorder.none),
                    style: TextStyle(
                      fontSize: widget.fontSize,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (widget
              .isEditable) // Only show the edit button for editable fields
            SizedBox(width: widget.fieldHeight * 0.15),
          if (widget.isEditable)
            GestureDetector(
              onTap: () {
                setState(() {
                  if (isEditing) widget.onUpdate();
                  isEditing = !isEditing;
                });
              },
              child: Container(
                height: widget.fieldHeight * 0.6,
                width: widget.fieldHeight * 0.6,
                decoration: BoxDecoration(
                  color: isEditing ? Colors.green : Color(0xFFE51818),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isEditing ? Icons.check : Icons.edit,
                  color: Colors.white,
                  size: widget.fieldHeight * 0.3,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:ba_app/Screens/Login_Screens/deleteaccount.dart';

// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});

//   @override
//   _ProfileScreenState createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   final supabase = Supabase.instance.client;

//   late TextEditingController nameController;
//   late TextEditingController majorController;
//   late TextEditingController emailController;
//   late TextEditingController idController;
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     nameController = TextEditingController();
//     majorController = TextEditingController();
//     emailController = TextEditingController();
//     idController = TextEditingController();
//     _loadUserProfile();
//   }

//   // Function to load user profile from Supabase
//   Future<void> _loadUserProfile() async {
//     try {
//       final user = supabase.auth.currentUser;
//       if (user == null) {
//         print('User is not logged in');
//         setState(() {
//           isLoading = false;
//         });
//         return;
//       }

//       final email = user.email; // Get the authenticated user's email
//       if (email == null) {
//         print('User email is null');
//         setState(() {
//           isLoading = false;
//         });
//         return;
//       }

//       final response =
//           await supabase
//               .from('university_users')
//               .select()
//               .eq('email', email) // Fetch the user data based on email
//               .single();

//       print('Fetched data: $response');
//       setState(() {
//         nameController.text = response['username'] ?? '';
//         majorController.text = response['major'] ?? '';
//         emailController.text = response['email'] ?? '';
//         idController.text = response['university_id'] ?? '';
//         isLoading = false;
//       });
//     } catch (error) {
//       print('Error fetching profile: $error');
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   // Function to update the profile in Supabase
//   Future<void> _updateProfile() async {
//     if (supabase.auth.currentUser == null) {
//       print('User is not logged in');
//       return;
//     }

//     try {
//       final email = supabase.auth.currentUser?.email ?? '';
//       final updates = {
//         'username': nameController.text,
//         'major': majorController.text,
//         'email': emailController.text.trim(),
//         'university_id': idController.text,
//       };

//       // Update profile data in the database
//       await supabase
//           .from('university_users')
//           .update(updates)
//           .eq('email', email);

//       // Update email if it has changed
//       if (emailController.text.trim() != email) {
//         await supabase.auth.updateUser(
//           UserAttributes(email: emailController.text.trim()),
//         );
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Profile and email updated successfully!'),
//           ),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Profile updated successfully!')),
//         );
//       }
//     } catch (error) {
//       print('Error updating profile: $error');
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Failed to update profile.')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (isLoading) {
//       return Scaffold(
//         appBar: AppBar(
//           title: Image.asset("D:/ba_app/assets/images/BA_Logo.png"),
//           centerTitle: true,
//           backgroundColor: const Color.fromARGB(255, 252, 251, 251),
//           elevation: 0,
//         ),
//         body: const Center(child: CircularProgressIndicator()),
//       );
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: Image.asset("assets/images/BA_Logo.png"),
//         centerTitle: true,
//         backgroundColor: const Color.fromARGB(255, 252, 251, 251),
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           height: 750,
//           color: Colors.white,
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 75),
//               const Text(
//                 'My Profile',
//                 style: TextStyle(
//                   fontFamily: 'Alegreya',
//                   color: Color.fromARGB(255, 124, 15, 7),
//                   fontWeight: FontWeight.bold,
//                   fontSize: 36,
//                 ),
//               ),
//               const SizedBox(height: 40),
//               const Text(
//                 "Name",
//                 style: TextStyle(
//                   fontSize: 20,
//                   color: Color.fromARGB(149, 116, 116, 110),
//                   fontStyle: FontStyle.normal,
//                 ),
//               ),
//               EditableProfileField(
//                 controller: nameController,
//                 onUpdate: _updateProfile,
//               ),
//               const SizedBox(height: 20),
//               const Text(
//                 "Major",
//                 style: TextStyle(
//                   fontSize: 20,
//                   color: Color.fromARGB(149, 116, 116, 110),
//                   fontStyle: FontStyle.normal,
//                 ),
//               ),
//               EditableProfileField(
//                 controller: majorController,
//                 onUpdate: _updateProfile,
//               ),
//               const SizedBox(height: 20),
//               const Text(
//                 "E-mail",
//                 style: TextStyle(
//                   fontSize: 20,
//                   color: Color.fromARGB(149, 116, 116, 110),
//                   fontStyle: FontStyle.normal,
//                 ),
//               ),
//               EditableProfileField(
//                 controller: emailController,
//                 onUpdate: _updateProfile,
//               ),
//               const SizedBox(height: 20),
//               const Text(
//                 "ID",
//                 style: TextStyle(
//                   fontSize: 20,
//                   color: Color.fromARGB(149, 116, 116, 110),
//                   fontStyle: FontStyle.normal,
//                 ),
//               ),
//               EditableProfileField(
//                 controller: idController,
//                 onUpdate: _updateProfile,
//               ),
//               const SizedBox(height: 20),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () => deleteUserAccount(context),
//                 child: Text("Delete My Account"),
//                 style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
//               ),

//               // ElevatedButton(
//               //   onPressed: _updateProfile,
//               //   child: Text("Update Profile"),
//               // ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class EditableProfileField extends StatefulWidget {
//   final TextEditingController controller;
//   final VoidCallback onUpdate; // Callback for triggering update

//   const EditableProfileField({
//     super.key,
//     required this.controller,
//     required this.onUpdate, // Pass the update callback
//   });

//   @override
//   _EditableProfileFieldState createState() => _EditableProfileFieldState();
// }

// class _EditableProfileFieldState extends State<EditableProfileField> {
//   bool isEditing = false;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           child: TextField(
//             controller: widget.controller,
//             enabled: isEditing,
//             decoration: InputDecoration(
//               filled: true,
//               fillColor: Colors.grey.shade200,
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(30),
//                 borderSide: BorderSide.none,
//               ),
//             ),
//             style: const TextStyle(fontSize: 16, color: Colors.black),
//           ),
//         ),
//         const SizedBox(width: 10),
//         IconButton(
//           icon: Icon(
//             isEditing ? Icons.check : Icons.edit,
//             color: isEditing ? Colors.green : Colors.red,
//           ),
//           onPressed: () {
//             setState(() {
//               if (isEditing) {
//                 widget.onUpdate(); // Trigger update when exiting edit mode
//               }
//               isEditing = !isEditing;
//             });
//           },
//         ),
//       ],
//     );
//   }
// }

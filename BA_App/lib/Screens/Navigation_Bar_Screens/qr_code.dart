// import 'package:flutter/material.dart';
// import 'package:qr_flutter/qr_flutter.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// class QRFullScreenPage extends StatefulWidget {
//   const QRFullScreenPage({super.key});

//   @override
//   QRFullScreenState createState() => QRFullScreenState();
// }

// class QRFullScreenState extends State<QRFullScreenPage> {
//   String _studentID = '';
//   bool _isLoading = true;
//   String? _errorMessage;

//   @override
//   void initState() {
//     super.initState();
//     _fetchStudentID();
//   }

//   Future<void> _fetchStudentID() async {
//     try {
//       final user = SupabaseConfig.client.auth.currentUser;
//       if (user == null) throw Exception('User not authenticated');

//       final response = await SupabaseConfig.client
//           .from('university_users')
//           .select('university_id')
//           .eq('email', user.email!)
//           .single();

//       if (mounted) {
//         setState(() {
//           _studentID = response['university_id'] ?? '';
//           _isLoading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _errorMessage = 'Failed to load ID: ${e.toString()}';
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _buildDynamicContent(),
//     );
//   }

//   Widget _buildDynamicContent() {
//     if (_isLoading) {
//       return _buildLoadingState();
//     }
//     if (_errorMessage != null) {
//       return _buildErrorState();
//     }
//     return _buildQRContent();
//   }

//   Widget _buildQRContent() {
//     final screenSize = MediaQuery.of(context).size;
//     final qrSize = screenSize.shortestSide * 0.8;

//     return Container(
//       constraints: const BoxConstraints.expand(),
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: [Colors.blueAccent, Colors.purpleAccent],
//         ),
//       ),
//       child: Center(
//         child: QrImageView(
//           data: _studentID,
//           version: QrVersions.auto,
//           size: qrSize,
//           backgroundColor: Colors.white,
//           eyeStyle: const QrEyeStyle(
//             color: Colors.black87,
//             eyeShape: QrEyeShape.square,
//           ),
//           dataModuleStyle: const QrDataModuleStyle(
//             color: Colors.black87,
//             dataModuleShape: QrDataModuleShape.square,
//           ),
//           errorStateBuilder: (context, error) => Text('QR Error: $error'),
//         ),
//       ),
//     );
//   }

//   Widget _buildLoadingState() {
//     return const Center(
//       child: CircularProgressIndicator.adaptive(
//         valueColor: AlwaysStoppedAnimation(Colors.white),
//       ),
//     );
//   }

//   Widget _buildErrorState() {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Text(
//           _errorMessage!,
//           style: const TextStyle(color: Colors.red, fontSize: 18),
//           textAlign: TextAlign.center,
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class QRCodeGenerator extends StatefulWidget {
  const QRCodeGenerator({super.key});

  @override
  _QRCodeGeneratorState createState() => _QRCodeGeneratorState();
}

class _QRCodeGeneratorState extends State<QRCodeGenerator> {
  String studentID = "";

  @override
  void initState() {
    super.initState();
    _load_ID();
  }

  Future<void> _load_ID() async {
    final supabase = Supabase.instance.client;
    try {
      final user = supabase.auth.currentUser;
      if (user == null) {
        print('User is not logged in');
        return;
      }

      final email = user.email; // Get the authenticated user's email
      if (email == null) {
        print('User email is null');
        return;
      }

      final response = await supabase
          .from('university_users')
          .select()
          .eq('email', email) // Fetch the user data based on email
          .single();

      setState(() {
        studentID = response['university_id'] ?? '';
      });
    } catch (error) {
      print('Error fetching profile: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student QR Code'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // QR Code Widget
            QrImageView(
              data: studentID, // Student's unique ID
              version: QrVersions.auto,
              size: 200.0,
            ),
            const SizedBox(height: 20), //  Info Below the QR Code
            if (studentID.isNotEmpty)
              Text(
                'Student ID: $studentID',
                style: const TextStyle(fontSize: 18),
              )
            else
              const Text('Loading student ID...'),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

Future<void> submitComplaint(String complaint) async {
  final supabase = Supabase.instance.client;
  final user = supabase.auth.currentUser;

  if (user == null) {
    throw Exception('User is not logged in.');
  }

  final email = user.email;

  final response = await supabase.from('complaints').insert({
    'email': email,
    'complaint': complaint,
  });

  if (response != null) {
    throw Exception(response!);
  }
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _isSubmitting = false;

  // Reference dimensions (based on a standard screen size, e.g., 360x640)
  final double refWidth = 360;
  final double refHeight = 640;

  // Scale factor based on current screen size
  double get scaleFactor {
    final mediaQuery = MediaQuery.of(context);
    final width = mediaQuery.size.width;
    // You could also consider height or both width and height
    return width / refWidth;
  }

  // Helper method to scale sizes proportionally
  double scale(double size) => size * scaleFactor;

  void _submitFeedback() async {
    final complaint = _controller.text.trim();
    if (complaint.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please write a complaint before submitting.'),
        ),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      await submitComplaint(complaint);
      _controller.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Feedback submitted successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to submit feedback: $e')));
    } finally {
      setState(() {
        _isSubmitting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "assets/images/BA_Logo.png",
          height: scale(56), // Scaled from reference kToolbarHeight * 0.8
        ),
        backgroundColor: Colors.white,
        centerTitle: false,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: scale(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: scale(24)),
            Text(
              "Suggestions or Complaints",
              style: TextStyle(
                fontFamily: 'Alegreya',
                color: const Color.fromARGB(255, 146, 18, 8),
                fontSize: scale(32),
              ),
            ),
            SizedBox(height: scale(24)),
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 228, 45, 32),
                borderRadius: BorderRadius.circular(scale(40)),
              ),
              padding: EdgeInsets.symmetric(
                vertical: scale(12),
                horizontal: scale(20),
              ),
              child: Text(
                'WE VALUE YOUR FEEDBACK!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: scale(20),
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            SizedBox(height: scale(24)),
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 212, 197, 196),
                borderRadius: BorderRadius.circular(scale(20)),
              ),
              padding: EdgeInsets.symmetric(
                vertical: scale(12),
                horizontal: scale(16),
              ),
              child: Text(
                "We're always looking to improve, and your suggestions or recommendations can help us do just that. Please share your thoughts below—we appreciate your input and look forward to hearing from you!",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: scale(19),
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            SizedBox(height: scale(40)),
            Text(
              "Write here*",
              style: TextStyle(color: Colors.black, fontSize: scale(20)),
            ),
            SizedBox(height: scale(10)),
            TextField(
              controller: _controller,
              maxLines: null,
              decoration: InputDecoration(
                hintText: 'Type...',
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[300],
                contentPadding: EdgeInsets.symmetric(
                  vertical: scale(15),
                  horizontal: scale(15),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(scale(20)),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: scale(32)),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 215, 19, 5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(scale(20)),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: scale(60),
                    vertical: scale(15),
                  ),
                ),
                onPressed: _isSubmitting ? null : _submitFeedback,
                child: Text(
                  _isSubmitting ? 'Submitting' : 'Submit',
                  style: TextStyle(
                    fontSize: scale(20),
                    color: Colors.white,
                    fontFamily: 'Alegreya',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// class FeedbackScreen extends StatefulWidget {
//   const FeedbackScreen({super.key});

//   @override
//   _FeedbackScreenState createState() => _FeedbackScreenState();
// }

// Future<void> submitComplaint(String complaint) async {
//   final supabase = Supabase.instance.client;
//   final user = supabase.auth.currentUser;

//   if (user == null) {
//     throw Exception('User is not logged in.');
//   }

//   final email = user.email;

//   final response = await supabase.from('complaints').insert({
//     'email': email,
//     'complaint': complaint,
//   });

//   if (response != null) {
//     throw Exception(response!);
//   }
// }

// class _FeedbackScreenState extends State<FeedbackScreen> {
//   final TextEditingController _controller = TextEditingController();
//   bool _isSubmitting = false;

//   void _submitFeedback() async {
//     final complaint = _controller.text.trim();
//     if (complaint.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//             content: Text('Please write a complaint before submitting.')),
//       );
//       return;
//     }

//     setState(() {
//       _isSubmitting = true;
//     });

//     try {
//       await submitComplaint(complaint);
//       _controller.clear();
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Feedback submitted successfully!')),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to submit feedback: $e')),
//       );
//     } finally {
//       setState(() {
//         _isSubmitting = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final horizontalPadding = MediaQuery.of(context).size.width * 0.05;

//     return Scaffold(
//       appBar: AppBar(
//         title: Image.asset("assets/images/BA_Logo.png",
//             height: kToolbarHeight * 0.8),
//         backgroundColor: Colors.white,
//         centerTitle: false,
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.symmetric(
//             horizontal: MediaQuery.of(context).size.width * 0.05),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: MediaQuery.of(context).size.height * 0.03),
//             Text(
//               "Suggestions or Complaints",
//               style: const TextStyle(
//                 fontFamily: 'Alegreya',
//                 color: Color.fromARGB(255, 146, 18, 8),
//                 fontSize: 32,
//               ),
//             ),
//             SizedBox(height: MediaQuery.of(context).size.height * 0.03),
//             Container(
//               decoration: BoxDecoration(
//                 color: const Color.fromARGB(255, 228, 45, 32),
//                 borderRadius: BorderRadius.circular(40),
//               ),
//               padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
//               child: const Text(
//                 'WE VALUE YOUR FEEDBACK!',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 20,
//                   fontFamily: 'Poppins',
//                 ),
//               ),
//             ),
//             SizedBox(height: MediaQuery.of(context).size.height * 0.03),
//             Container(
//               decoration: BoxDecoration(
//                 color: const Color.fromARGB(255, 212, 197, 196),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//               child: const Text(
//                 "We're always looking to improve, and your suggestions or recommendations can help us do just that. Please share your thoughts below—we appreciate your input and look forward to hearing from you!",
//                 style: TextStyle(
//                     color: Colors.black, fontSize: 19, fontFamily: 'Poppins'),
//               ),
//             ),
//             SizedBox(height: MediaQuery.of(context).size.height * 0.05),
//             Align(
//               alignment: Alignment.centerLeft,
//               child: const Text("Write here*",
//                   style: TextStyle(color: Colors.black, fontSize: 20)),
//             ),
//             SizedBox(height: 10),
//             TextField(
//               controller: _controller,
//               maxLines: null,
//               decoration: InputDecoration(
//                   hintText: 'Type...',
//                   hintStyle: const TextStyle(color: Colors.grey),
//                   filled: true,
//                   fillColor: Colors.grey[300],
//                   contentPadding:
//                       const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20),
//                       borderSide: BorderSide.none)),
//             ),
//             SizedBox(height: MediaQuery.of(context).size.height * 0.04),
//             Center(
//                 child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color.fromARGB(255, 215, 19, 5),
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(20)),
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 60, vertical: 15)),
//                     onPressed: _isSubmitting ? null : _submitFeedback,
//                     child: Text(_isSubmitting ? 'Submitting' : 'Submit',
//                         style: const TextStyle(
//                             fontSize: 20,
//                             color: Colors.white,
//                             fontFamily: 'Alegreya')))),
//           ],
//         ),
//       ),
//     );
//   }
// }

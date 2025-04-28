import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ba_app/Screens/Other_Screens/pdf_page.dart';

class SyllabusPage extends StatefulWidget {
  const SyllabusPage({Key? key, required this.courseID}) : super(key: key);
  final String courseID;

  @override
  SyllabusPageState createState() => SyllabusPageState();
}

class SyllabusPageState extends State<SyllabusPage> {
  final SupabaseClient supabase = Supabase.instance.client;

  // Reference dimensions (based on a standard screen size)
  final double refWidth = 360;
  final double refHeight = 640;

  // Scale factor based on current screen size
  double get scaleFactor {
    final mediaQuery = MediaQuery.of(context);
    return mediaQuery.size.width / refWidth;
  }

  // Helper method to scale sizes proportionally
  double scale(double size) => size * scaleFactor;

  Future<List<Map<String, dynamic>>> fetchSyllabi(String courseID) async {
    final response = await supabase
        .from('syllabi')
        .select()
        .eq('course_id', courseID);
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        title: Image.asset(
          'assets/images/BA_Logo.png',
          height: scale(56), // Scaled app bar height
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),
      body: FutureBuilder(
        future: fetchSyllabi(widget.courseID),
        builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  const Color.fromARGB(255, 183, 25, 25),
                ),
              ),
            );
          }
          final syllabi = snapshot.data!;

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: scale(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: scale(24)),

                // Search Field (commented out in original)
                // Center(
                //   child: SizedBox(
                //     width: scale(252), // 70% of reference width
                //     height: scale(45),
                //     child: TextField(
                //       decoration: InputDecoration(
                //         hintText: 'Search',
                //         contentPadding: EdgeInsets.symmetric(
                //           horizontal: scale(16),
                //           vertical: scale(10),
                //         ),
                //         prefixIcon: Icon(Icons.search, size: scale(24)),
                //         border: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(scale(10)),
                //           borderSide: BorderSide(width: 1, color: Colors.grey),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                // SizedBox(height: scale(24)),
                Text(
                  "Syllabi",
                  style: TextStyle(
                    color: const Color.fromARGB(255, 183, 25, 25),
                    fontWeight: FontWeight.bold,
                    fontSize: scale(35),
                  ),
                ),
                SizedBox(height: scale(24)),

                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: syllabi.length,
                  separatorBuilder:
                      (context, index) => SizedBox(height: scale(16)),
                  itemBuilder: (context, index) {
                    final syllabus = syllabi[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => PDFViewerPage(
                                  pdfUrl: syllabus['pdf_url'].toString(),
                                ),
                          ),
                        );
                      },
                      splashColor: const Color.fromARGB(255, 156, 5, 5),
                      borderRadius: BorderRadius.circular(scale(16)),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(scale(16)),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(scale(16)),
                          color: const Color(0xFFEFEFEF),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              offset: Offset(scale(5.0), scale(4.0)),
                              blurRadius: scale(7),
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: Text(
                          syllabus['doctor_name'],
                          style: TextStyle(
                            color: const Color.fromARGB(255, 183, 25, 25),
                            fontWeight: FontWeight.bold,
                            fontSize: scale(19),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: scale(40),
                ), // Extra padding for better scrolling
              ],
            ),
          );
        },
      ),
    );
  }
}

// // import 'package:ba_app/Screens/models.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// import 'package:flutter/material.dart';
// import 'package:ba_app/Screens/Other_Screens/pdf_page.dart';

// class SyllabusPage extends StatefulWidget {
//   const SyllabusPage({Key? key, required this.courseID}) : super(key: key);
//   final String courseID; // Declare departmentId as a field
//   @override
//   SyllabusPageState createState() => SyllabusPageState();
// }

// class SyllabusPageState extends State<SyllabusPage> {
//   final SupabaseClient supabase = Supabase.instance.client;

//   Future<List<Map<String, dynamic>>> fetchSyllabi(String courseID) async {
//     final response = await supabase
//         .from('syllabi')
//         .select()
//         .eq('course_id', courseID); // Filter by department_id

//     return response;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;

//     return Scaffold(
//       backgroundColor: const Color(0xFFF2F2F2),
//       appBar: AppBar(
//         title: Row(
//           children: [
//             Image.asset(
//               'assets/images/BA_Logo.png', // Path to your image asset
//               // Adjust the height as needed
//             ),
//           ],
//         ),
//         backgroundColor: Colors.white, // Optional: change background color
//       ),
//       body: SingleChildScrollView(
//         child: FutureBuilder(
//           future: fetchSyllabi(widget.courseID),
//           builder: (
//             context,
//             AsyncSnapshot<List<Map<String, dynamic>>> snapshot,
//           ) {
//             if (!snapshot.hasData) {
//               return const Center(child: CircularProgressIndicator());
//             }
//             final syllabi = snapshot.data!;
//             return SizedBox(
//               height: screenHeight, // Make the page take full screen height
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const SizedBox(height: 16),
//                   // Center(
//                   //   child: SizedBox(
//                   //     width: MediaQuery.of(context).size.width * 0.7,
//                   //     height: screenHeight * 0.07, // 7% of screen height
//                   //     child: TextField(
//                   //       decoration: InputDecoration(
//                   //         hintText: 'Search',
//                   //         contentPadding: const EdgeInsets.symmetric(
//                   //             horizontal: 16, vertical: 10),
//                   //         prefixIcon: const Icon(Icons.search),
//                   //         border: OutlineInputBorder(
//                   //           borderRadius: BorderRadius.circular(10.0),
//                   //           borderSide:
//                   //               const BorderSide(width: 1, color: Colors.grey),
//                   //         ),
//                   //       ),
//                   //     ),
//                   //   ),
//                   // ),
//                   const SizedBox(height: 16),
//                   const Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 16),
//                     child: Text(
//                       "Syllabi",
//                       style: TextStyle(
//                         color: Color.fromARGB(255, 183, 25, 25),
//                         fontWeight: FontWeight.bold,
//                         fontSize: 35,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   Expanded(
//                     // Make ListView take remaining space
//                     child: ListView.separated(
//                       physics: const NeverScrollableScrollPhysics(),
//                       shrinkWrap: true,
//                       padding: const EdgeInsets.symmetric(horizontal: 16),
//                       itemCount: syllabi.length,
//                       separatorBuilder:
//                           (context, index) => const SizedBox(height: 16),
//                       itemBuilder: (context, index) {
//                         final syllabus = syllabi[index];
//                         return InkWell(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder:
//                                     (context) => PDFViewerPage(
//                                       pdfUrl: syllabus['pdf_url'].toString(),
//                                     ),
//                               ),
//                             );
//                           },
//                           splashColor: const Color.fromARGB(255, 156, 5, 5),
//                           borderRadius: BorderRadius.circular(16),
//                           child: Container(
//                             width: double.infinity,
//                             padding: const EdgeInsets.all(16),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(16),
//                               color: const Color(0xFFEFEFEF),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.grey.withOpacity(0.5),
//                                   offset: const Offset(5.0, 4.0),
//                                   blurRadius: 7,
//                                   spreadRadius: 0,
//                                 ),
//                               ],
//                             ),
//                             child: Text(
//                               syllabus['doctor_name'],
//                               style: const TextStyle(
//                                 color: Color.fromARGB(255, 183, 25, 25),
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 19,
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

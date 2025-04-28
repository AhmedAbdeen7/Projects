import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ba_app/Screens/Syllabus_Screens/syllabuses.dart';

class CoursePage extends StatefulWidget {
  const CoursePage({Key? key, required this.departmentId}) : super(key: key);
  final String departmentId;

  @override
  CoursePageState createState() => CoursePageState();
}

class CoursePageState extends State<CoursePage> {
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

  Future<List<Map<String, dynamic>>> fetchCourses(String departmentId) async {
    final response = await supabase
        .from('courses_syllabi')
        .select()
        .eq('department_id', departmentId);
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        title: Image.asset('assets/images/BA_Logo.png', height: scale(56)),
        backgroundColor: Colors.white, // Correctly placed here
        elevation: 0,
        centerTitle: false,
      ),
      body: FutureBuilder(
        future: fetchCourses(widget.departmentId),
        builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final courses = snapshot.data!;

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: scale(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: scale(24)),

                Text(
                  "Courses",
                  style: TextStyle(
                    color: const Color.fromARGB(255, 183, 25, 25),
                    fontWeight: FontWeight.bold,
                    fontSize: scale(30),
                  ),
                ),
                SizedBox(height: scale(24)),

                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: courses.length,
                  separatorBuilder:
                      (context, index) => SizedBox(height: scale(16)),
                  itemBuilder: (context, index) {
                    final course = courses[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => SyllabusPage(
                                  courseID: course['id'].toString(),
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
                          course['name'],
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
// // import 'package:ba_app/Models/models.dart';
// // import 'package:ba_app/Screens/supabase_service.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// import 'package:flutter/material.dart';
// import 'package:ba_app/Screens/Syllabus_Screens/syllabuses.dart';

// class CoursePage extends StatefulWidget {
//   const CoursePage({Key? key, required this.departmentId}) : super(key: key);
//   final String departmentId; // Declare departmentId as a field

//   @override
//   CoursePageState createState() => CoursePageState();
// }

// class CoursePageState extends State<CoursePage> {
//   final SupabaseClient supabase = Supabase.instance.client;
//   // final SupabaseService supabaseService = SupabaseService();

//   Future<List<Map<String, dynamic>>> fetchCourses(String departmentId) async {
//     final response = await supabase
//         .from('courses_syllabi')
//         .select()
//         .eq('department_id', departmentId);
//     // Filter by department_id

//     return response;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;
//     return Scaffold(
//       backgroundColor: const Color(0xFFF2F2F2),
//       appBar: AppBar(
//         title: Row(
//           children: [
//             Image.asset(
//               'assets/images/BA_Logo.png', // Path to your image asset
//               // height: 40, // Adjust the height as needed
//             ),
//           ],
//         ),
//         backgroundColor: Colors.white, // Optional: change background color
//       ),
//       body: SingleChildScrollView(
//         child: FutureBuilder(
//           future: fetchCourses(widget.departmentId),
//           builder: (
//             context,
//             AsyncSnapshot<List<Map<String, dynamic>>> snapshot,
//           ) {
//             if (!snapshot.hasData) {
//               return const Center(child: CircularProgressIndicator());
//             }
//             final Courses = snapshot.data!;
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
//                       "Courses",
//                       style: TextStyle(
//                         color: Color.fromARGB(255, 183, 25, 25),
//                         fontWeight: FontWeight.bold,
//                         fontSize: 30,
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
//                       itemCount: Courses.length,
//                       separatorBuilder:
//                           (context, index) => const SizedBox(height: 16),
//                       itemBuilder: (context, index) {
//                         final Course = Courses[index];
//                         return InkWell(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder:
//                                     (context) => SyllabusPage(
//                                       courseID: Course['id'].toString(),
//                                     ),
//                               ),
//                             );
//                           },
//                           splashColor: const Color.fromARGB(255, 156, 5, 5),
//                           borderRadius: BorderRadius.circular(16),
//                           child: Container(
//                             width: screenWidth * 0.7,
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
//                               Course['name'],
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

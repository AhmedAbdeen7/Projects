import 'package:flutter/material.dart';
import 'package:ba_app/Models/models.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ba_app/Screens/Syllabus_Screens/syllabuses_courses.dart';

class DepartmentPage extends StatefulWidget {
  @override
  _DepartmentPageState createState() => _DepartmentPageState();
}

class _DepartmentPageState extends State<DepartmentPage> {
  List<Department> departments = [];
  List<Department> filteredDepartments = [];
  final TextEditingController _searchController = TextEditingController();
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

  Future<List<Map<String, dynamic>>> fetchDepartments() async {
    final response = await supabase.from('departments').select();
    return response;
  }

  @override
  void initState() {
    super.initState();
    filteredDepartments = departments;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredDepartments =
          departments
              .where((dept) => (dept.name ?? '').toLowerCase().contains(query))
              .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('assets/images/BA_Logo.png', height: scale(56)),
          ],
        ),
        backgroundColor: Colors.white, // Correctly placed here
        elevation: 0,
        centerTitle: false,
      ),
      body: FutureBuilder(
        future: fetchDepartments(),
        builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final departments = snapshot.data!;

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: scale(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: scale(24)),

                Text(
                  "Departments",
                  style: TextStyle(
                    color: const Color.fromARGB(255, 183, 25, 25),
                    fontWeight: FontWeight.bold,
                    fontSize: scale(30),
                  ),
                ),
                SizedBox(height: scale(40)),

                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: departments.length,
                  separatorBuilder:
                      (context, index) => SizedBox(height: scale(16)),
                  itemBuilder: (context, index) {
                    final department = departments[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => CoursePage(
                                  departmentId: department['id'].toString(),
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
                          department['name'],
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
                SizedBox(height: scale(40)),
              ],
            ),
          );
        },
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// // import 'package:ba_app/Screens/supabase_service.dart';
// import 'package:ba_app/Models/models.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:ba_app/Screens/Syllabus_Screens/syllabuses_courses.dart';

// class DepartmentPage extends StatefulWidget {
//   @override
//   _DepartmentPageState createState() => _DepartmentPageState();
// }

// class _DepartmentPageState extends State<DepartmentPage> {
//   // final SupabaseService supabaseService = SupabaseService();
//   List<Department> departments = [];
//   List<Department> filteredDepartments = [];
//   final TextEditingController _searchController = TextEditingController();
//   final SupabaseClient supabase = Supabase.instance.client;

//   Future<List<Map<String, dynamic>>> fetchDepartments() async {
//     final response = await supabase.from('departments').select();
//     return response;
//   }

//   @override
//   void initState() {
//     super.initState();
//     // Initialize filtered list with all departments
//     filteredDepartments = departments;
//     _searchController.addListener(_onSearchChanged);
//   }

//   @override
//   void dispose() {
//     _searchController.removeListener(_onSearchChanged);
//     _searchController.dispose();
//     super.dispose();
//   }

//   // Function to filter departments based on search query
//   void _onSearchChanged() {
//     final query = _searchController.text.toLowerCase(); // Handle null text
//     setState(() {
//       filteredDepartments =
//           departments
//               .where(
//                 (dept) => (dept.name ?? '').toLowerCase().contains(query),
//               ) // Handle null name
//               .toList();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     final Size screenSize = MediaQuery.of(context).size;
//     final double screenWidth = screenSize.width;

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
//           future: fetchDepartments(),
//           builder: (
//             context,
//             AsyncSnapshot<List<Map<String, dynamic>>> snapshot,
//           ) {
//             if (!snapshot.hasData) {
//               return const Center(child: CircularProgressIndicator());
//             }
//             final departments = snapshot.data!;
//             return SizedBox(
//               height: screenHeight, // Make the page take full screen height
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(height: screenHeight * 0.02),
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
//                   SizedBox(height: screenHeight * 0.02),
//                   const Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 16),
//                     child: Text(
//                       "Departments",
//                       style: TextStyle(
//                         color: Color.fromARGB(255, 183, 25, 25),
//                         fontWeight: FontWeight.bold,
//                         fontSize: 30,
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: screenHeight * 0.05),
//                   Expanded(
//                     // Make ListView take remaining space
//                     child: ListView.separated(
//                       physics: const NeverScrollableScrollPhysics(),
//                       shrinkWrap: true,
//                       padding: const EdgeInsets.symmetric(horizontal: 16),
//                       itemCount: departments.length,
//                       separatorBuilder:
//                           (context, index) => const SizedBox(height: 16),
//                       itemBuilder: (context, index) {
//                         final department = departments[index];
//                         return InkWell(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder:
//                                     (context) => CoursePage(
//                                       departmentId: department['id'].toString(),
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
//                               department['name'],
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

// Placeholder for CoursePage (to be implemented)
// class CoursePage extends StatelessWidget {
//   final String department;

//   const CoursePage({required this.department});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(department),
//       ),
//       body: Center(
//         child: Text('Courses for $department'),
//       ),
//     );
//   }
// }

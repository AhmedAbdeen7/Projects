import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GPACalculator extends StatefulWidget {
  const GPACalculator({Key? key}) : super(key: key);

  @override
  _GPACalculatorState createState() => _GPACalculatorState();
}

class _GPACalculatorState extends State<GPACalculator> {
  List<CourseEntry> courseEntries = [];
  List<CourseEntry> selectedCourses = [];
  double overallGPA = 0.00;
  bool isLoading = true;

  final Map<String, double> gradePoints = {
    'A': 4.0,
    'A-': 3.7,
    'B+': 3.3,
    'B': 3.0,
    'B-': 2.7,
    'C+': 2.3,
    'C': 2.0,
    'D': 1.0,
    'F': 0.0,
    'Select': 0.0,
  };

  @override
  void initState() {
    super.initState();
    fetchCoursesFromDatabase();
  }

  Future<void> fetchCoursesFromDatabase() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await Supabase.instance.client
          .from('courses')
          .select('id, name');

      if (response == null) {
        throw Exception('Failed to fetch courses: ${response!}');
      }

      final courses = (response as List);
      List<CourseEntry> entries = [];

      for (var course in courses) {
        entries.add(
          CourseEntry(name: course['name'], grade: 'Select', credits: 3),
        );
      }

      // If no courses are found or there's an error, add default courses from the image
      if (entries.isEmpty) {
        entries = [
          CourseEntry(
            name: 'Financial Accounting',
            grade: 'Select',
            credits: 3,
          ),
          CourseEntry(
            name: 'Intermediate Accounting',
            grade: 'Select',
            credits: 3,
          ),
          CourseEntry(
            name: 'Managerial Accounting',
            grade: 'Select',
            credits: 3,
          ),
        ];
      }

      setState(() {
        courseEntries = entries;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching courses: $e');
      // Fallback to courses shown in the image if there's an error
      setState(() {
        courseEntries = [
          CourseEntry(name: 'Advanced Calculus', grade: 'A', credits: 1),
          CourseEntry(name: 'Business Finance', grade: 'B', credits: 2),
          CourseEntry(
            name: 'Financial Accounting',
            grade: 'Select',
            credits: 3,
          ),
          CourseEntry(
            name: 'Managerial Accounting',
            grade: 'Select',
            credits: 3,
          ),
          CourseEntry(
            name: 'Introduction to Business',
            grade: 'Select',
            credits: 3,
          ),
          CourseEntry(name: 'Microeconomics', grade: 'A', credits: 1),
          CourseEntry(name: 'Macroeconomics', grade: 'A-', credits: 3),
          CourseEntry(
            name: 'Management of Information Systems',
            grade: 'A',
            credits: 1,
          ),
        ];
        isLoading = false;
      });
    }
  }

  void calculateGPA() {
    double totalPoints = 0;
    int totalCredits = 0;

    for (var entry in courseEntries) {
      if (entry.grade != 'Select') {
        totalPoints += gradePoints[entry.grade]! * entry.credits;
        totalCredits += entry.credits;
      }
    }

    setState(() {
      overallGPA = totalCredits > 0 ? totalPoints / totalCredits : 0.0;
    });
  }

  void resetForm() {
    setState(() {
      for (var entry in courseEntries) {
        entry.grade = 'Select';
        entry.credits = 3;
      }
      overallGPA = 0.00;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions for responsive design
    final double screenWidth = MediaQuery.of(context).size.width;
    final double scaleFactor = screenWidth / 400; // Base width is 400px
    final double scaledPadding = 16 * scaleFactor;
    final double scaledFontSize = 15 * scaleFactor;
    final double titleFontSize = 18 * scaleFactor;
    final double headerFontSize = 14 * scaleFactor;
    final double itemFontSize = 13 * scaleFactor;

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "assets/images/BA_Logo.png",
          height: 40 * scaleFactor,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(scaledPadding),
          child: Card(
            elevation: 0,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8 * scaleFactor),
            ),
            child: Padding(
              padding: EdgeInsets.all(scaledPadding),
              child:
                  isLoading
                      ? Center(
                        child: CircularProgressIndicator(
                          color: Colors.red,
                          strokeWidth: 3 * scaleFactor,
                        ),
                      )
                      : Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'GPA CALCULATOR',
                            style: TextStyle(
                              fontSize: titleFontSize,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20 * scaleFactor),
                          // Table header
                          Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text(
                                  'Course Name',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: headerFontSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  'Grade',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: headerFontSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'Credits',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: headerFontSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(width: 24 * scaleFactor),
                            ],
                          ),
                          SizedBox(height: 10 * scaleFactor),
                          // Course rows
                          Expanded(
                            child: ListView.builder(
                              itemCount: courseEntries.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                    bottom: 8.0 * scaleFactor,
                                  ),
                                  child: _buildCourseRow(
                                    courseEntries[index],
                                    scaleFactor,
                                    itemFontSize,
                                  ),
                                );
                              },
                            ),
                          ),
                          // Buttons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: 120 * scaleFactor,
                                child: OutlinedButton(
                                  onPressed: resetForm,
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: Color(0xFFFF3B30),
                                    side: BorderSide(
                                      color: Color(0xFFFF3B30),
                                      width: 1 * scaleFactor,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        4 * scaleFactor,
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    'Reset',
                                    style: TextStyle(fontSize: scaledFontSize),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 120 * scaleFactor,
                                child: ElevatedButton(
                                  onPressed: calculateGPA,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFFFF3B30),
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        4 * scaleFactor,
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    'Calculate',
                                    style: TextStyle(fontSize: scaledFontSize),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20 * scaleFactor),
                          // Overall GPA
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 12 * scaleFactor,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFFFF3B30),
                              borderRadius: BorderRadius.circular(
                                4 * scaleFactor,
                              ),
                            ),
                            child: Text(
                              'Overall GPA ${overallGPA.toStringAsFixed(2)}',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: scaledFontSize,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCourseRow(
    CourseEntry course,
    double scaleFactor,
    double fontSize,
  ) {
    return Row(
      children: [
        // Course name (light blue background)
        Expanded(
          flex: 3,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10 * scaleFactor,
              vertical: 8 * scaleFactor,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFE3F2FD), // Light blue color
              borderRadius: BorderRadius.circular(4 * scaleFactor),
            ),
            child: Text(course.name, style: TextStyle(fontSize: fontSize)),
          ),
        ),
        SizedBox(width: 8 * scaleFactor),
        // Grade dropdown
        Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFE3F2FD), // Light blue color
              borderRadius: BorderRadius.circular(4 * scaleFactor),
            ),
            child: DropdownButton<String>(
              isExpanded: true,
              value: course.grade,
              icon: Icon(Icons.arrow_drop_down, size: 24 * scaleFactor),
              underline: Container(),
              onChanged: (String? newValue) {
                setState(() {
                  course.grade = newValue!;
                });
              },
              items:
                  <String>[
                    'Select',
                    'A',
                    'A-',
                    'B+',
                    'B',
                    'B-',
                    'C+',
                    'C',
                    'D',
                    'F',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: TextStyle(fontSize: fontSize)),
                    );
                  }).toList(),
            ),
          ),
        ),
        SizedBox(width: 8 * scaleFactor),
        // Credits dropdown
        Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFE3F2FD), // Light blue color
              borderRadius: BorderRadius.circular(4 * scaleFactor),
            ),
            child: DropdownButton<int>(
              isExpanded: true,
              value: course.credits,
              icon: Icon(Icons.arrow_drop_down, size: 24 * scaleFactor),
              underline: Container(),
              onChanged: (int? newValue) {
                setState(() {
                  course.credits = newValue!;
                });
              },
              items:
                  <int>[1, 2, 3].map<DropdownMenuItem<int>>((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(
                        value.toString(),
                        style: TextStyle(fontSize: fontSize),
                      ),
                    );
                  }).toList(),
            ),
          ),
        ),
        SizedBox(width: 8 * scaleFactor),
        // Reset icon
        Container(
          width: 24 * scaleFactor,
          height: 24 * scaleFactor,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.grey.shade300,
              width: 1 * scaleFactor,
            ),
          ),
          child: IconButton(
            iconSize: 14 * scaleFactor,
            padding: EdgeInsets.zero,
            icon: Icon(
              Icons.refresh,
              color: Colors.grey,
              size: 14 * scaleFactor,
            ),
            onPressed: () {
              setState(() {
                course.grade = 'Select';
                course.credits = 3;
              });
            },
          ),
        ),
      ],
    );
  }
}

class CourseEntry {
  String name;
  String grade;
  int credits;

  CourseEntry({required this.name, required this.grade, required this.credits});
}

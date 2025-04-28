// import 'package:ba_app/Screens/supabase_service.dart';
// import 'package:flutter/material.dart';

class Department {
  final int id;
  final String? name;

  Department({required this.id, required this.name});

  factory Department.fromMap(Map<String, dynamic> map) {
    return Department(
      id: map['id'],
      name: map['name'] ?? 'Unknown',
    );
  }
}

class Course {
  final int id;
  final String name;
  final int departmentId;

  Course({required this.id, required this.name, required this.departmentId});

  factory Course.fromMap(Map<String, dynamic> map) {
    return Course(
      id: map['id'],
      name: map['name'],
      departmentId: map['department_id'],
    );
  }
}

class Syllabus {
  final int id;
  final int courseId;
  final String doctorName;
  final String pdfUrl;

  Syllabus(
      {required this.id,
      required this.courseId,
      required this.doctorName,
      required this.pdfUrl});

  factory Syllabus.fromMap(Map<String, dynamic> map) {
    return Syllabus(
      id: map['id'],
      courseId: map['course_id'],
      doctorName: map['doctor_name'],
      pdfUrl: map['pdf_url'],
    );
  }
}

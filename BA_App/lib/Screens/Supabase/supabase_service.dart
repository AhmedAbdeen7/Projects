import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final SupabaseClient supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> fetchDepartments() async {
    final response = await supabase.from('departments').select();
    return response;
  }

  Future<List<Map<String, dynamic>>> fetchCourses(int departmentId) async {
    final response = await supabase
        .from('courses')
        .select()
        .eq('department_id', departmentId);
    return response;
  }

  Future<List<Map<String, dynamic>>> fetchSyllabuses(int courseId) async {
    final response =
        await supabase.from('syllabuses').select().eq('course_id', courseId);
    return response;
  }
}

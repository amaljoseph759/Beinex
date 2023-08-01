import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../Model/student_model.dart';

class StudentListController extends GetxController {
  var students = <Student>[].obs;
  final _storage = GetStorage(); // Initialize get_storage

  @override
  void onInit() {
    super.onInit();
    fetchStudents();
  }

  void fetchStudents() {
    final savedStudents = _storage.read<List>('students');
    if (savedStudents != null) {
      students.value = savedStudents
          .map((studentData) => Student(
                id: studentData['id'],
                name: studentData['name'],
                age: studentData['age'],
                grade: studentData['grade'],
              ))
          .toList();
    }
  }

  void saveStudents() {
    final List<Map<String, dynamic>> dataToSave = students
        .map((student) => {
              'id': student.id,
              'name': student.name,
              'age': student.age,
              'grade': student.grade,
            })
        .toList();
    _storage.write('students', dataToSave);
  }

  void updateStudent(Student updatedStudent) {
    final studentIndex = students.indexWhere((s) => s.id == updatedStudent.id);
    if (studentIndex != -1) {
      students[studentIndex] = updatedStudent;
      saveStudents();
    }
  }

  void deleteStudent(Student student) {
    students.removeWhere((s) => s.id == student.id);
    saveStudents();
  }
}

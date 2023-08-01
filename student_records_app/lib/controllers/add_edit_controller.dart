import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_records_app/controllers/studentlist_controller.dart';

import '../Model/student_model.dart';

class AddEditController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController gradeController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String id = '';
  void addStudent(Student student) {
    // final newStudent = Student(
    //   id: DateTime.now().millisecondsSinceEpoch,
    //   name: nameController.text.trim(),
    //   age: int.parse(ageController.text.trim()),
    //   grade: gradeController.text.trim(),
    // );

    Get.find<StudentListController>().students.add(student);
    Get.find<StudentListController>().saveStudents();
    Get.back();
  }

  void updateStudent(Student student) {
    final updatedStudent = Student(
      id: student.id,
      name: nameController.text.trim(),
      age: int.parse(ageController.text.trim()),
      grade: gradeController.text.trim(),
    );

    final studentIndex = Get.find<StudentListController>()
        .students
        .indexWhere((s) => s.id == student.id);
    if (studentIndex != -1) {
      Get.find<StudentListController>().students[studentIndex] = updatedStudent;
      Get.find<StudentListController>().saveStudents();
    }
    Get.back();
  }
}

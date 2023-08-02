import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_records_app/screens/addscreen.dart';

import '../controllers/add_edit_controller.dart';
import '../controllers/studentlist_controller.dart';
import '../controllers/theme_controller.dart';

class StudentTableView extends StatelessWidget {
  final StudentListController studentListController =
      Get.put(StudentListController());
  final AddEditController addEditController = Get.put(AddEditController());
  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Student Records'),
        actions: [
          Obx(
            () => IconButton(
              icon: Icon(themeController.isDarkMode.value
                  ? Icons.light_mode
                  : Icons.dark_mode),
              onPressed: () {
                themeController.toggleTheme();
                Get.changeThemeMode(themeController.isDarkMode.value
                    ? ThemeMode.dark
                    : ThemeMode.light);
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(
          () {
            if (studentListController.students.isEmpty) {
              return Center(
                child: Text('No students found.'),
              );
            } else {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: DataTable(
                    horizontalMargin: 0, // Set horizontal margin to 0
                    columnSpacing: MediaQuery.of(context).size.width /
                        10, // Set column spacing to 0
                    columns: const [
                      DataColumn(label: Text('Name')),
                      DataColumn(label: Text('Age')),
                      DataColumn(label: Text('Grade')),
                      DataColumn(label: Text('')),
                      DataColumn(label: Text('')),
                    ],
                    rows: studentListController.students.map((student) {
                      return DataRow(cells: [
                        DataCell(Container(
                          width: MediaQuery.of(context).size.width / 7,
                          child: Text(
                            student.name,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )),
                        DataCell(Text(student.age.toString())),
                        DataCell(Text(student.grade)),
                        DataCell(IconButton(
                          icon: const Icon(Icons.mode_edit_outlined,
                              color: Colors.blue),
                          onPressed: () {
                            addEditController.nameController.text =
                                student.name;
                            addEditController.ageController.text =
                                student.age.toString();
                            addEditController.gradeController.text =
                                student.grade;
                            addEditController.id = student.id.toString();
                            Get.to(() => AddEditScreen(isEdit: true));
                          },
                        )),
                        DataCell(IconButton(
                            icon: const Icon(
                              Icons.delete_outline_outlined,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              Get.defaultDialog(
                                  title: 'Confirm Deletion',
                                  middleText:
                                      'Are you sure you want to delete this student?',
                                  confirm: ElevatedButton(
                                    onPressed: () {
                                      studentListController
                                          .deleteStudent(student);
                                      Get.back();
                                    },
                                    child: const Text('Delete'),
                                  ));
                            }))
                      ]);
                    }).toList(),
                  ),
                ),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddEditScreen(isEdit: false));
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

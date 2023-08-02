import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_records_app/Model/student_model.dart';
import 'package:student_records_app/controllers/add_edit_controller.dart';

class AddEditScreen extends StatefulWidget {
  AddEditScreen({super.key});

  @override
  State<AddEditScreen> createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController gradeController = TextEditingController();
  String studentid = "";
  bool isedit = Get.arguments ?? false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (isedit) {
      nameController = addEditController.nameController;
      ageController = addEditController.ageController;
      gradeController = addEditController.gradeController;
      studentid = addEditController.id;
    }
  }

  final AddEditController addEditController = Get.put(AddEditController());

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add Student'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: MediaQuery.of(context).size.width / 5,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a name.';
                    }
                    print(nameController);
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: ageController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Age'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter an age.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: gradeController,
                  decoration: const InputDecoration(labelText: 'Grade'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a grade.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      nameController.text = nameController.text.trim();
                      ageController.text = ageController.text.trim();
                      gradeController.text = gradeController.text.trim();
                      final studentdata = Student(
                          age: int.parse(ageController.text),
                          grade: gradeController.text,
                          name: nameController.text,
                          id: studentid.isEmpty
                              ? DateTime.now().millisecondsSinceEpoch
                              : int.parse(studentid));
                      if (isedit) {
                        addEditController.updateStudent(studentdata);
                      } else {
                        addEditController.addStudent(studentdata);
                      }
                    }
                  },
                  child: Text(isedit ? "Update student" : 'Add Student'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

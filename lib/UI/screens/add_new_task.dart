import 'package:flutter/material.dart';
import 'package:task_managment/UI/screens/buttom_navigation.dart';
import 'package:task_managment/UI/state_manager/add_new_task.dart';
import 'package:task_managment/UI/widget/User_profile_banner.dart';
import '../widget/screen_background.dart';
import 'package:get/get.dart';

class add_new_task extends StatefulWidget {
  const add_new_task({Key? key}) : super(key: key);

  @override
  State<add_new_task> createState() => _add_new_taskState();
}

class _add_new_taskState extends State<add_new_task> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  final GlobalKey<FormState> _add_task = GlobalKey<FormState>();
  bool isprogreess = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen_background(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              User_profile_banner(),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Form(
                  key: _add_task,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        'Add New Task',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      TextFormField(
                        controller: _titleController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(hintText: 'Title'),
                        validator: (String? value) {
                          if (value?.isEmpty ?? true) {
                            return 'Enter task Title';
                          }
                        },
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      TextFormField(
                        controller: _descriptionController,
                        maxLines: 4,
                        keyboardType: TextInputType.emailAddress,
                        decoration:
                            const InputDecoration(hintText: 'Description'),
                        validator: (String? value) {
                          if (value?.isEmpty ?? true) {
                            return 'Enter task Description';
                          }
                        },
                      ),
                      GetBuilder<AddTaskController>(
                          builder: (AddTaskController) {
                        return SizedBox(
                          width: double.infinity,
                          child: Visibility(
                            visible: AddTaskController.isprogreess == false,
                            replacement:
                                Center(child: CircularProgressIndicator()),
                            child: ElevatedButton(
                                onPressed: () {
                                  if (!_add_task.currentState!.validate()) {
                                    return;
                                  }
                                  AddTaskController.addNewTask(
                                          _titleController.text.trim(),
                                          _descriptionController.text.trim())
                                      .then((result) {
                                    if (result == true) {
                                      Get.to(Buttom_nav());
                                      Get.snackbar(
                                          'Success', 'Task added successful');
                                    } else {
                                      Get.snackbar('Field',
                                          'Something wrong...!, please try again');
                                    }
                                  });
                                },
                                child:
                                    const Icon(Icons.arrow_forward_ios_sharp)),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

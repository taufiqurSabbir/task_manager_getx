import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_managment/UI/screens/splash_screen.dart';
import 'package:task_managment/UI/state_manager/StatusChange.dart';
import 'package:task_managment/UI/state_manager/add_new_task.dart';
import 'package:task_managment/UI/state_manager/login_controller.dart';
import 'package:task_managment/UI/state_manager/TaskByStatus.dart';
import 'package:task_managment/UI/state_manager/otp_varification.dart';
import 'package:task_managment/UI/state_manager/sign_upController.dart';
import 'package:task_managment/UI/state_manager/task_count.dart';
import 'package:task_managment/UI/state_manager/updateprofile.dart';

import 'UI/state_manager/email_varification.dart';
import 'UI/state_manager/passwordChange.dart';

class TaskManager extends StatefulWidget {
  static GlobalKey<ScaffoldState> globalKey =GlobalKey();
  const TaskManager({Key? key}) : super(key: key);

  @override
  State<TaskManager> createState() => _TaskManagerState();
}

class _TaskManagerState extends State<TaskManager> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      key: TaskManager.globalKey,
      debugShowCheckedModeBanner: false,
      title: 'Task Manager',
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.blueAccent,
          primarySwatch: Colors.blue,
          inputDecorationTheme: const InputDecorationTheme(
            contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 16),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderSide: BorderSide.none),
          ),



          textTheme: TextTheme(
            titleLarge: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 25,
              color: Colors.black,
              letterSpacing: 0.5
            )
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
              padding: EdgeInsets.symmetric(vertical: 8),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)
                )
              )
          )
      ),



      darkTheme: ThemeData(brightness: Brightness.dark,
          primaryColor: Colors.black,
          primarySwatch: Colors.blue,
          inputDecorationTheme: const InputDecorationTheme(
            contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 16),
            filled: true,
            fillColor: Colors.white,
            hintStyle:  TextStyle(color: Colors.grey),
            border: OutlineInputBorder(borderSide: BorderSide.none),
          ),
          textTheme: TextTheme(
              titleLarge: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 25,
                  color: Colors.black,
                  letterSpacing: 0.5
              )
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(vertical: 8),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)
                  )
              )
          )
      ),
      themeMode: ThemeMode.light,
      home: const Splash_screen(),
      initialBinding: ControllerBinding(),
    );
  }
}

class ControllerBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(loginController());
    Get.put(SignUpController());
    Get.put(AddTaskController());
    Get.put(TaskByStatus());
    Get.put(taskcountController());
    Get.put(StatusController());
    Get.put(UpdateProfileController());
    Get.put(EmailVarification());
    Get.put(otp_varification());
    Get.put(passwordChange());
  }

}

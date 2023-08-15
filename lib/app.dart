import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_managment/UI/screens/splash_screen.dart';
import 'package:task_managment/UI/state_manager/login_controller.dart';
import 'package:task_managment/UI/state_manager/sign_upController.dart';

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
  }

}

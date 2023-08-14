import 'package:flutter/material.dart';
import 'package:task_managment/UI/screens/cancle_screen.dart';
import 'package:task_managment/UI/screens/completed_screen.dart';
import 'package:task_managment/UI/screens/new_task_screen.dart';
import 'package:task_managment/UI/screens/progress_screen.dart';

class Buttom_nav extends StatefulWidget {
  const Buttom_nav({Key? key}) : super(key: key);

  @override
  State<Buttom_nav> createState() => _Buttom_navState();


}

class _Buttom_navState extends State<Buttom_nav> {
  int page_index=0;
  final List<Widget> _screens = [
    new_task(),
    progress(),
    completed(),
    cancle(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[page_index],

      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        unselectedLabelStyle: TextStyle(
          color: Colors.grey
        ),
        currentIndex: page_index,
        onTap: (int index){
          page_index=index;
          print(page_index);
         if(mounted){
           setState(() {
           });
         }
        },
        selectedItemColor: Colors.blueAccent,
        items:   [
        BottomNavigationBarItem(icon: Icon(Icons.add_box_outlined),label: 'New Task',),
        BottomNavigationBarItem(icon: Icon(Icons.insert_chart_outlined_sharp),label: 'Progress ',),
        BottomNavigationBarItem(icon: Icon(Icons.task_alt),label: 'Completed'),
        BottomNavigationBarItem(icon: Icon(Icons.cancel_outlined),label: 'Canclled'),
      ],),
    );
  }
}


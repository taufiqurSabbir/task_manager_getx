import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_managment/UI/screens/buttom_navigation.dart';
import 'package:task_managment/UI/state_manager/StatusChange.dart';
import 'package:task_managment/data/model/network_response.dart';
import 'package:task_managment/data/services/network_caller.dart';

import '../../data/utils/urls.dart';
import 'package:get/get.dart';

import '../state_manager/deletetask.dart';

class Task_list extends StatefulWidget {
  Task_list({
    required this.title,
    required this.description,
    required this.date,
    required this.id,
    required this.colour,
    required this.status_name,
    required this.onUpdate,
  });

  final String title, description, date, id, status_name;
  final colour;
  final VoidCallback onUpdate;

  final StatusController statusController = Get.put(StatusController());


  @override
  State<Task_list> createState() => _Task_listState();
}

class _Task_listState extends State<Task_list> {

  var items = [
    'New',
    'Progress',
    'Completed',
    'Cancelled',
  ];
  final Delete_task delete_task = Get.put(Delete_task());
  @override
  Widget build(BuildContext context) {





    String dropdownvalue = widget.status_name;
    return Container(
      color: Colors.white,
      child:

           ListTile(
              onLongPress: () {
                setState(() {
                });
              },
              title: Text(widget.title),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.description),
                  Text(widget.date),
                  Row(
                    children: [
                      Chip(
                        label: SizedBox(
                          width: 80,
                          child: Center(
                            child: Text(
                              '${widget.status_name}',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        backgroundColor: widget.colour,
                      ),
                      Spacer(),
                      GetBuilder<StatusController>(
                        builder: (statusController) {
                          return DropdownButton<String>(
                            value: dropdownvalue,
                            items: items.map((String item) {
                              return DropdownMenuItem<String>(
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              statusController.Statuschage(newValue!,widget.id).then((result){
                                if(result == true){
                                  Get.offAll(Buttom_nav());
                                }
                              });
                            },
                            icon: Icon(Icons.edit, color: Colors.blueAccent),
                          );
                        }
                      ),
                      IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Are you sure?'),
                                  content: const SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Text('Do you want to delete the task?')
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('Cancle')),
                                    TextButton(
                                        onPressed: () {
                                          delete_task.delete_task(widget.id);
                                          setState(() {});
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Buttom_nav()),
                                              (route) => false);
                                        },
                                        child: Text('Delete'))
                                  ],
                                );
                              });
                        },
                        icon: Icon(Icons.delete_forever_outlined),
                        color: Colors.red,
                      ),
                    ],
                  )
                ],
              ),
            ),
    );
  }
}

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_managment/UI/screens/buttom_navigation.dart';
import 'package:task_managment/data/model/network_response.dart';
import 'package:task_managment/data/services/network_caller.dart';

import '../../data/utils/urls.dart';

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

  @override
  State<Task_list> createState() => _Task_listState();
}

class _Task_listState extends State<Task_list> {
  bool isloding = false;
  var items = [
    'New',
    'Progress',
    'Completed',
    'Cancelled',
  ];


  @override
  Widget build(BuildContext context) {
    Future<void> Statuschage($status) async {
      log(widget.id.toString());
      String status_url =
          '${Urls.baseurl}/updateTaskStatus/${widget.id}/${$status}';
      isloding = true;
      setState(() {});
      final NetworkResponse response =
          await NetworkCaller().getrequest(status_url);
      isloding = false;
      setState(() {});
      if (response.isSuccess) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Task Status Updated')));
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => Buttom_nav(),
                  settings: RouteSettings(arguments: 0)),
              (route) => false);
        }
        log(response.body.toString());
      } else {
        log(response.body.toString());
      }
    }

    Future<void> delete_task($id) async {
      String delate_url = '${Urls.baseurl}/deleteTask/${widget.id}';
      isloding = true;
      setState(() {
      });
      NetworkResponse response = await NetworkCaller().getrequest(delate_url);
      isloding = false;
      log(response.body.toString());
    }

    String dropdownvalue = widget.status_name;
    return Container(
      color: Colors.white,
      child: isloding
          ? Center(child: CircularProgressIndicator())
          : ListTile(
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
                      DropdownButton<String>(
                        value: dropdownvalue,
                        items: items.map((String item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {

                          Statuschage(newValue);
                        },
                        icon: Icon(Icons.edit, color: Colors.blueAccent),
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
                                          delete_task(widget.id);
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

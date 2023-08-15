
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:task_managment/UI/screens/add_new_task.dart';
import 'package:task_managment/UI/state_manager/TaskByStatus.dart';
import 'package:task_managment/data/model/network_response.dart';
import 'package:task_managment/data/services/network_caller.dart';
import '../../data/utils/urls.dart';
import '../widget/User_profile_banner.dart';
import '../widget/task_list.dart';
import '../widget/task_summary.dart';
import 'package:get/get.dart';

class new_task extends StatefulWidget {
  const new_task({Key? key}) : super(key: key);

  @override
  State<new_task> createState() => _new_taskState();
}

class _new_taskState extends State<new_task> {

  final TaskByStatus taskcontroler = Get.put(TaskByStatus());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      task_status();
      taskcontroler.TaskController(Urls.new_list);
    });
    taskcontroler.TaskController(Urls.new_list);
    task_status();
    super.initState();
  }



  void task_status() {
    setState(() {
      new_task_count();
      progress_task_count();
      cancled_task_count();
      completed_task_count();
    });
  }

  int? new_count;
  int? progress;
  int? cancle;
  int? completed;

  Future<int?> new_task_count() async {

    setState(() {});
    NetworkResponse response = await NetworkCaller().getrequest(Urls.new_list);

    setState(() {});
    List<dynamic> items = [];
    if (response.isSuccess) {
      items = response.body!['data'];
      new_count = items.length;
      return new_count;
    } else {
      return items.length;
    }
  }

  Future<int?> progress_task_count() async {
    NetworkResponse response = await NetworkCaller().getrequest(Urls.Progress);
    List<dynamic> items = [];
    if (response.isSuccess) {
      items = response.body!['data'];
      progress = items.length;
      return progress;
    } else {
      return progress;
    }
  }

  Future<int?> cancled_task_count() async {
    NetworkResponse response = await NetworkCaller().getrequest(Urls.cancled);
    List<dynamic> items = [];
    if (response.isSuccess) {
      items = response.body!['data'];
      cancle = items.length;
      return cancle;
    } else {
      return cancle;
    }
  }

  Future<int?> completed_task_count() async {
    NetworkResponse response = await NetworkCaller().getrequest(Urls.completed);
    List<dynamic> items = [];
    if (response.isSuccess) {
      items = response.body!['data'];
      completed = items.length;
      return completed;
    } else {
      return completed;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.grey.shade200,
          child: Column(
            children: [
              const User_profile_banner(),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                        child: Task_Summary(
                      number: new_count.toString(),
                      title: 'New',
                      onUpdate: () {
                        task_status();
                      },
                    )),
                    Expanded(
                        child: Task_Summary(
                            number: progress.toString(),
                            title: 'Progress',
                            onUpdate: () {
                              task_status();
                            })),
                    Expanded(
                        child: Task_Summary(
                            number: cancle.toString(),
                            title: 'Cancel',
                            onUpdate: () {
                              task_status();
                            })),
                    Expanded(
                        child: Task_Summary(
                            number: completed.toString(),
                            title: 'Completed',
                            onUpdate: () {
                              task_status();
                            })),
                  ],
                ),
              ),
              GetBuilder<TaskByStatus>(
                  builder: (taskcontroler) {
                    return Expanded(
                        child: taskcontroler.isloading
                            ? Center(child: CircularProgressIndicator())
                            :  RefreshIndicator(
                          onRefresh: () async {
                            setState(() {
                              taskcontroler.TaskController(Urls.new_list);
                            });
                          },
                          child: taskcontroler.tasksData.length != 0
                              ? ListView.separated(
                            itemCount: taskcontroler.tasksData.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Task_list(
                                  title: taskcontroler.tasksData[index]['title'],
                                  description: taskcontroler.tasksData[index]
                                  ['description'],
                                  date: taskcontroler.tasksData[index]['createdDate'],
                                  id: taskcontroler.tasksData[index]['_id'],
                                  colour: Colors.blueAccent,
                                  status_name: 'New',
                                  onUpdate: () {
                                    taskcontroler.TaskController(Urls.Progress);
                                  },
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const Divider(
                                height: 4,
                              );
                            },
                          )
                              : Center(
                              child: Image.asset(
                                'asset/images/nod.png',
                                width: 280,
                              )),
                        )

                    );
                  }
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => add_new_task()));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void new_task_set_state(BuildContext context) {}
}

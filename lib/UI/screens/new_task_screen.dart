import 'package:flutter/material.dart';
import 'package:task_managment/UI/screens/add_new_task.dart';
import 'package:task_managment/UI/state_manager/TaskByStatus.dart';
import 'package:task_managment/data/model/network_response.dart';
import 'package:task_managment/data/services/network_caller.dart';
import '../../data/utils/urls.dart';
import '../state_manager/task_count.dart';
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
  final taskcountController taskcount = Get.put(taskcountController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      taskcontroler.TaskController(Urls.new_list);
    });
    taskcount.task_count();
    taskcontroler.TaskController(Urls.new_list);
    super.initState();
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
                child: GetBuilder<taskcountController>(
                  builder: (taskcount) {
                    return Row(
                      children: [
                        Expanded(
                            child: Task_Summary(
                          number: taskcount.new_count.toString(),
                          title: 'New',
                          onUpdate: () {
                            taskcount.task_count();
                          },
                        )),
                        Expanded(
                            child: Task_Summary(
                                number: taskcount.progress.toString(),
                                title: 'Progress',
                                onUpdate: () {
                                  taskcount.task_count();
                                })),

                        Expanded(
                            child: Task_Summary(
                                number: taskcount.completed.toString(),
                                title: 'Completed',
                                onUpdate: () {
                                  taskcount.task_count();
                                })),

                        Expanded(
                            child: Task_Summary(
                                number: taskcount.cancle.toString(),
                                title: 'Cancel',
                                onUpdate: () {
                                  taskcount.task_count();
                                })),
                      ],
                    );
                  }
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

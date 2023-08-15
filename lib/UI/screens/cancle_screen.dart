
import 'package:flutter/material.dart';
import '../../data/utils/urls.dart';
import '../state_manager/TaskByStatus.dart';
import '../widget/User_profile_banner.dart';
import '../widget/task_list.dart';
import 'package:get/get.dart';

class cancle extends StatefulWidget {
  const cancle({Key? key}) : super(key: key);



  @override
  State<cancle> createState() => _cancleState();
}

class _cancleState extends State<cancle> {
  final TaskByStatus taskcontroler = Get.put(TaskByStatus());

  @override
  void initState() {
    setState(() {
      taskcontroler.TaskController(Urls.cancled);
    });
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
              Container(
                color: Colors.blueAccent,
                child: const User_profile_banner(),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
              ),
              GetBuilder<TaskByStatus>(
                  builder: (taskcontroler) {
                    return Expanded(
                        child: taskcontroler.isloading
                            ? Center(child: CircularProgressIndicator())
                            :  RefreshIndicator(
                          onRefresh: () async {
                            setState(() {
                              taskcontroler.TaskController(Urls.cancled);
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
                                  status_name: 'Cancelled',
                                  onUpdate: () {
                                    taskcontroler.TaskController(Urls.cancled);
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
    );
  }
}

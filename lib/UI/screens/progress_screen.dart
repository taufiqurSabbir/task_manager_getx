import 'package:flutter/material.dart';
import '../../data/utils/urls.dart';
import '../state_manager/TaskByStatus.dart';
import '../widget/User_profile_banner.dart';
import '../widget/task_list.dart';
import 'package:get/get.dart';

class progress extends StatefulWidget {
  const progress({Key? key}) : super(key: key);

  @override
  State<progress> createState() => _progressState();
}

class _progressState extends State<progress> {

final TaskByStatus taskcontroler = Get.put<TaskByStatus>(TaskByStatus());
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      taskcontroler.TaskController(Urls.Progress);
    });
    // TODO: implement initState
    taskcontroler.TaskController(Urls.Progress);
    super.initState();
  }





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
                              taskcontroler.TaskController(Urls.Progress);
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
                                  status_name: 'Progress',
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
    );
  }
}

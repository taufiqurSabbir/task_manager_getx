import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../data/model/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';
import '../../data/utils/urls.dart';
import '../widget/User_profile_banner.dart';
import '../widget/task_list.dart';

class progress extends StatefulWidget {
  const progress({Key? key}) : super(key: key);

  @override
  State<progress> createState() => _progressState();
}

class _progressState extends State<progress> {
  List<dynamic> progress_task = [];

  @override
  void initState() {
    // TODO: implement initState
    process_task();
    super.initState();
  }

  bool isloading = false;

  Future<void> process_task() async {
    isloading = true;
    NetworkResponse response = await NetworkCaller().getrequest(Urls.Progress);
    isloading = false;

    if (response.isSuccess) {
      setState(() {
        progress_task = response.body!['data'];
        log(progress_task.toString());
      });
    } else {
      log(response.body.toString());
    }
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
              Expanded(
                child: isloading
                    ? Center(child: CircularProgressIndicator())
                    : progress_task.length !=0 ? ListView.separated(
                        itemCount: progress_task.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Task_list(
                              title: progress_task[index]['title'],
                              description: progress_task[index]['description'],
                              date: progress_task[index]['createdDate'],
                              id: progress_task[index]['_id'],
                              colour: Colors.purple,
                              status_name: 'Progress',
                              onUpdate: () {
                                process_task();
                              },
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider(
                            height: 4,
                          );
                        },
                      ) : Image.asset('asset/images/nod.png',width: 300,)
              )
            ],
          ),
        ),
      ),
    );
  }
}

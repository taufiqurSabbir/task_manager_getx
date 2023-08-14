import 'dart:developer';

import 'package:flutter/material.dart';

import '../../data/model/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';
import '../widget/User_profile_banner.dart';
import '../widget/task_list.dart';

class cancle extends StatefulWidget {
  const cancle({Key? key}) : super(key: key);

  @override
  State<cancle> createState() => _cancleState();
}

class _cancleState extends State<cancle> {
  List<dynamic> cancle_task_data = [];

  @override
  void initState() {
    setState(() {
      cancle_task();
    });
    super.initState();
  }

  bool isloading = false;

  Future<void> cancle_task() async {
    isloading = true;
    if (mounted) {
      setState(() {});
    }
    NetworkResponse response = await NetworkCaller().getrequest(Urls.cancled);
    isloading = false;
    if (mounted) {
      setState(() {});
    }

    if (response.isSuccess) {
      setState(() {
        cancle_task_data = response.body!['data'];
        log(cancle_task_data.toString());
      });
    } else {
      log(response.body.toString());
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
              Container(
                color: Colors.blueAccent,
                child: const User_profile_banner(),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
              ),
              Expanded(
                child: isloading
                    ? const Center(child: CircularProgressIndicator())
                    : cancle_task_data.length !=0 ? ListView.separated(
                        itemCount: cancle_task_data.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Task_list(
                              title: cancle_task_data[index]['title'],
                              description: cancle_task_data[index]
                                  ['description'],
                              date: cancle_task_data[index]['createdDate'],
                              id: cancle_task_data[index]['_id'],
                              colour: Colors.red,
                              status_name: 'Cancelled',
                              onUpdate: () {
                                cancle_task();
                              },
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider(
                            height: 4,
                          );
                        },
                      ) : Image.asset('asset/images/nod.png',width: 280,)
              )
            ],
          ),
        ),
      ),
    );
  }
}

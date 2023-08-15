import 'dart:developer';

import 'package:get/get.dart';
import 'package:task_managment/UI/state_manager/task_count.dart';

import '../../data/model/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';
import 'TaskByStatus.dart';

class StatusController extends GetxController{

  bool isloding = false;
  final taskcountController taskcount = Get.put(taskcountController());
  final TaskByStatus taskcontroler = Get.put(TaskByStatus());

  Future<bool> Statuschage(String status,String id) async {
    log(id.toString());
    String status_url =
        '${Urls.baseurl}/updateTaskStatus/${id}/${status}';
    taskcount.task_count();
    isloding = true;
   update();
    final NetworkResponse response =
    await NetworkCaller().getrequest(status_url);

    isloding = false;
    update();
    if (response.isSuccess) {
      update();
      log(response.body.toString());
      return true;
    } else {
      log(response.body.toString());
      return false;
    }
  }
}
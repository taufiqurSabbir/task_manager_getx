import 'dart:developer';

import 'package:get/get.dart';
import 'package:task_managment/UI/state_manager/task_count.dart';


import '../../data/model/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';

class Delete_task extends GetxController{
  final taskcountController taskcountcontrol = Get.put(taskcountController());
 bool  isloding = false;
  Future<void> delete_task(String id) async {
    String delate_url = '${Urls.baseurl}/deleteTask/$id';
    isloding = true;
   update();
    NetworkResponse response = await NetworkCaller().getrequest(delate_url);
    isloding = false;
    taskcountcontrol.task_count();
    update();

    log(response.body.toString());
  }
}
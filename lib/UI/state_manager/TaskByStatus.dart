import 'dart:developer';

import 'package:get/get.dart';

import '../../data/model/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';

class TaskByStatus extends GetxController {
  List<dynamic> tasksData = [];
  bool isloading = false;

  Future<void> TaskController(String link) async {
    isloading = true;
    update();
    NetworkResponse response = await NetworkCaller().getrequest(link);
    isloading = false;
    update();

    if (response.isSuccess) {
      isloading = false;
      update();
      tasksData = response.body!['data'];
      update();
    } else {
      log(response.body.toString());
    }
  }
}

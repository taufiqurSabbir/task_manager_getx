import 'dart:developer';

import 'package:get/get.dart';

import '../../data/model/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';

class NewTaskController extends GetxController{
  List<dynamic> tasksData = [];
  bool isloading = false;

  Future<void> Newtask() async {
    isloading = true;
   update();
    NetworkResponse response = await NetworkCaller().getrequest(Urls.new_list);
    isloading = false;
    update();

    if (response.isSuccess) {
        tasksData = response.body!['data'];
      update();
    } else {
      log(response.body.toString());
    }
  }

}
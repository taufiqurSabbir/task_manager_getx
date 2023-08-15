import 'dart:math';

import 'package:get/get.dart';

import '../../data/model/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';

class taskcountController extends GetxController{

  int? new_count;
  int? progress;
  int? cancle;
  int? completed;

  Future<int?>task_count() async {
    NetworkResponse newtask = await NetworkCaller().getrequest(Urls.new_list);
    NetworkResponse progress_task = await NetworkCaller().getrequest(Urls.Progress);
    NetworkResponse cancle_task = await NetworkCaller().getrequest(Urls.cancled);
    NetworkResponse completed_task = await NetworkCaller().getrequest(Urls.completed);
    update();

    List<dynamic> items = [];


    if (newtask.isSuccess) {
      items = newtask.body!['data'];
      new_count = items.length;
      print(new_count);
      items.clear();
      update();
    }

    if (progress_task.isSuccess) {
      items = progress_task.body!['data'];
      progress = items.length;
      items.clear();
      update();
    }

    if (cancle_task.isSuccess) {
      items = cancle_task.body!['data'];
      cancle = items.length;
      items.clear();
      update();
    }

    if (completed_task.isSuccess) {
      items = completed_task.body!['data'];
      completed = items.length;
      items.clear();
      update();
    }
    update();
    print(new_count);
  }

}
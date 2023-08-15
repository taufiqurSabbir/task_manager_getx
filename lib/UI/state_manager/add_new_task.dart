import 'dart:developer';
import 'package:get/get.dart';
import '../../data/model/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';

class AddTaskController extends GetxController {
  bool _isprogreess = false;
  bool get isprogreess => _isprogreess;

  Future<bool> addNewTask(String title, String description) async {
    _isprogreess = true;
    update();

    Map<String, dynamic> requestbody = {
      "title": title,
      "description": description,
      "status": "New"
    };

    NetworkResponse response =
        await NetworkCaller().postrequest(Urls.addNewTask, requestbody);

    _isprogreess = false;
    update();

    if (response.isSuccess) {
      log(response.body.toString());
      update();
      return true;
    } else {
      return false;
    }
  }
}

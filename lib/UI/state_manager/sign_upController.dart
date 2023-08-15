import 'dart:developer';

import 'package:get/get.dart';

import '../../data/model/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';

class SignUpController extends GetxController{
  bool _signupinprogress = false;

  bool get signupinprogress => _signupinprogress;

  Future<bool> userSignUp(String email,String firstname,String lastname,String mobile,String password,String photo) async {
    _signupinprogress=true;
    update();
    final NetworkResponse response =
    await NetworkCaller().postrequest(Urls.registation, <String, dynamic>{
      "email": email,
      "firstName": firstname,
      "lastName": lastname,
      "mobile": mobile,
      "password":password,
      "photo": photo,
    });
    _signupinprogress=false;
    update();

    if (response.isSuccess) {
      // log(response.isSuccess.toString());
      return true;

    } else {
      log(response.isSuccess.toString());
      return false;
    }
  }
}
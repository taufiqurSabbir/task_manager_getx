import 'dart:developer';

import 'package:get/get.dart';

import '../../data/model/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';

class passwordChange extends GetxController {
  Future<bool> setpassword(String email, String otp, String password) async {
    NetworkResponse response = await NetworkCaller()
        .postrequest(Urls.password_change, <String, dynamic>{
      "email": email,
      "OTP": otp,
      "password": password,
    });

    if (response.isSuccess) {
      return true;
    } else {
      log(response.body.toString());
      return false;
    }
  }
}

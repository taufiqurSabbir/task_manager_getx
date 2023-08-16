import 'dart:developer';

import 'package:get/get.dart';

import '../../data/model/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';

class otp_varification extends GetxController {
  Future<String?> otpverify(String email, String otp) async {
    String otpVarifyUrl = Urls.otp_varify + email + '/' + otp;
    NetworkResponse response = await NetworkCaller().getrequest(otpVarifyUrl);
    if (response.isSuccess) {
      log(response.body.toString());

      if (response.body?['status'] == 'success') {
        return 'true';
      } else {
        return response.body?['data'];
      }
    }
  }
}

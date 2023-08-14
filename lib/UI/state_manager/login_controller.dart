import 'package:get/get.dart';

import '../../data/model/auth_utility.dart';
import '../../data/model/login_model.dart';
import '../../data/model/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';

class loginController extends GetxController {
  bool _isloginprogress = false;
  bool get isloginprogress => _isloginprogress;

  Future<bool> login(String email, String password) async {
    _isloginprogress = true;
    update();
    Map<String, dynamic> request_body = {
      "email": email,
      "password": password,
    };
    _isloginprogress = true;
    update();
    final NetworkResponse response =
        await NetworkCaller().postrequest(Urls.login, request_body);
    _isloginprogress = false;
    update();
    if (response.isSuccess) {
      await AuthUtlity.saveUserInfo(login_model.fromJson(response.body!));
      return true;
    } else {
      return false;
    }
  }
}

import 'dart:developer';

import 'package:get/get.dart';

import '../../data/model/auth_utility.dart';
import '../../data/model/login_model.dart';
import '../../data/model/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';
UserData userData = AuthUtlity.userInfo.data!;

class UpdateProfileController extends GetxController{


  Future<bool> updateprofile(String email,String firstname,String lastname,String mobile,String photo) async {
    NetworkResponse response = await NetworkCaller()
        .postrequest(Urls.profile_update, <String, dynamic>{
      "email": email,
      "firstName": firstname,
      "lastName": lastname,
      "mobile": mobile,
      "photo": photo,
    });
    update();

    if (response.isSuccess) {
      userData.firstName = firstname;
      userData.lastName = lastname;
      userData.mobile = mobile;
      userData.photo = photo;
      AuthUtlity.updateUserInfo(userData);
     update();
     return true;

    } else {
      log(response.statusCode.toString());
      return false;
    }
  }
}
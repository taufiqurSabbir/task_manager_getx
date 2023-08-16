import 'dart:developer';

import 'package:get/get.dart';

import '../../data/model/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';

class EmailVarification extends GetxController{

  Future<bool>email_send(String email)async {
    NetworkResponse response = await NetworkCaller().getrequest(Urls.forgetpass+email);

    if(response.body?['status']=='success'){

      log(response.body.toString());
      return true;
    }else{
      return false;

      }
    }
  }

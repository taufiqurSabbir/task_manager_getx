import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import 'package:http/http.dart';
import 'package:task_managment/UI/screens/auth/loginScreen.dart';
import 'package:task_managment/app.dart';
import 'package:task_managment/data/model/auth_utility.dart';
import 'package:task_managment/data/model/network_response.dart';

class NetworkCaller {
  Future<NetworkResponse> getrequest(String url) async {
    Response response = await get(Uri.parse(url),
      headers: {
        'token': AuthUtlity.userInfo.token.toString()
      },
    );
    try {
      if (response.statusCode == 200) {


        return NetworkResponse(
            true, response.statusCode, jsonDecode(response.body));
      }else if(response.statusCode == 401){
        gotologin();
      } else {

        gotologin();
        return NetworkResponse(false, response.statusCode, null);
      }
    } catch (e) {
      developer.log(e.toString());
    }

    return NetworkResponse(false, -1, null);
  }

  Future<NetworkResponse> postrequest(
      String url, Map<String, dynamic> body) async {
    try {
      Response response = await post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'token': AuthUtlity.userInfo.token.toString()
        },
        body: jsonEncode(body),
      );

      developer.log(response.body);
      if (response.statusCode == 200) {
        return NetworkResponse(
            true, response.statusCode, jsonDecode(response.body));
      } else if (response.statusCode == 401) {
        gotologin();
      } else {
        gotologin();
        return NetworkResponse(false, response.statusCode, null);
      }
    } catch (e) {
      developer.log(e.toString());
    }
    return NetworkResponse(false, -1, null);
  }

  void gotologin() {
    AuthUtlity.clearInfo();
    Navigator.pushAndRemoveUntil(TaskManager.globalKey.currentContext!,
        MaterialPageRoute(builder: (context) => Login()), (route) => false);
  }
}

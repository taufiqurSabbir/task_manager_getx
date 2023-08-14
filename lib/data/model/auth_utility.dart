import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_managment/data/model/login_model.dart';

class AuthUtlity {
  AuthUtlity._();

  static login_model userInfo = login_model();

  static Future<void> saveUserInfo(login_model model) async {
    SharedPreferences _sharep = await SharedPreferences.getInstance();
    await _sharep.setString('user-data', jsonEncode(model.toJson()));
    userInfo = model;
  }

  static Future<void> updateUserInfo(UserData data) async {
    SharedPreferences _sharep = await SharedPreferences.getInstance();
    userInfo.data = data;
    await _sharep.setString('user-data', jsonEncode(userInfo.toJson()));
  }

  static Future<login_model> getUserInfo() async {
    SharedPreferences _sharep = await SharedPreferences.getInstance();
    String value = await _sharep.getString('user-data')!;
    return login_model.fromJson(jsonDecode(value));
  }

  static Future<void> clearInfo() async {
    SharedPreferences _sharep = await SharedPreferences.getInstance();
    _sharep.clear();
  }

  static Future<bool> checkuserlogin() async {
    SharedPreferences _sharep = await SharedPreferences.getInstance();
    bool islogin = _sharep.containsKey('user-data');

    if (islogin) {
      userInfo = await getUserInfo();
    }
    return islogin;
  }
}

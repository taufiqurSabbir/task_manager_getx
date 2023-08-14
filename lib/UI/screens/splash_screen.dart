import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_managment/UI/screens/buttom_navigation.dart';
import 'package:task_managment/UI/utils/asset_utils.dart';
import 'package:task_managment/UI/widget/screen_background.dart';
import 'package:task_managment/data/model/auth_utility.dart';
import 'auth/loginScreen.dart';
import 'package:get/get.dart';


class Splash_screen extends StatefulWidget {
  const Splash_screen({Key? key}) : super(key: key);

  @override
  State<Splash_screen> createState() => _Splash_screenState();
}

class _Splash_screenState extends State<Splash_screen> {

  @override
  void initState() {
    super.initState();
    NavigationtoLogin();
  }



  Future<void> NavigationtoLogin() async {


    Future.delayed(const Duration(seconds: 3)).then((_) async {
      final islogin= await AuthUtlity.checkuserlogin();

      //get navigation
      if(mounted){
        Get.offAll(()=>islogin ?  Buttom_nav() : const Login());
      }




      // if(mounted){
      //   Navigator.pushAndRemoveUntil(
      //       context,
      //       MaterialPageRoute(
      //           builder: (context) => islogin ?  Buttom_nav() : const Login()),
      //       (route) => false);
      // }


    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen_background(
        child: Center(
          child: SvgPicture.asset(
            AssetUtils.logoSvg,
            width: 300,
            fit: BoxFit.scaleDown,
          ),
        ),
      )
    );
  }
}

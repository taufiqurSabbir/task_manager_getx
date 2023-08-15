import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:task_managment/UI/screens/auth/update_profile.dart';
import 'package:task_managment/data/model/login_model.dart';

import '../../data/model/auth_utility.dart';
import '../screens/auth/loginScreen.dart';
import 'package:get/get.dart';

class User_profile_banner extends StatefulWidget {
  // final login_model data;

  const User_profile_banner({
    super.key,
    // required this.data,
  });

  @override
  State<User_profile_banner> createState() => _User_profile_bannerState();
}

class _User_profile_bannerState extends State<User_profile_banner> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueAccent,
      child: InkWell(
        onTap: () {
          Get.to(update_profile());
        },
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
              AuthUtlity.userInfo.data?.photo ??
                  'https://media.istockphoto.com/id/1270067126/photo/smiling-indian-man-looking-at-camera.jpg?s=612x612&w=0&k=20&c=ovIQ5GPurLd3mOUj82jB9v-bjGZ8updgy1ACaHMeEC0=',
            ),
            radius: 27,
            onBackgroundImageError: (_, __) {
              Image.network(
                  'https://media.istockphoto.com/id/1270067126/photo/smiling-indian-man-looking-at-camera.jpg?s=612x612&w=0&k=20&c=ovIQ5GPurLd3mOUj82jB9v-bjGZ8updgy1ACaHMeEC0=');
            },
            child: ClipOval(
              child: AuthUtlity.userInfo.data?.photo != null
                  ? Image.memory(
                      base64Decode(AuthUtlity.userInfo.data!.photo!),
                      fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
                    )
                  : Image.network(
                      'https://t4.ftcdn.net/jpg/01/86/29/31/360_F_186293166_P4yk3uXQBDapbDFlR17ivpM6B1ux0fHG.jpg'),

            ),
          ),
          title: Text(
            '${AuthUtlity.userInfo.data?.firstName} ${AuthUtlity.userInfo.data?.lastName}',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 14),
          ),
          subtitle: Text(
            '${AuthUtlity.userInfo.data?.email}',
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
          trailing: IconButton(
              onPressed: () async {
                await AuthUtlity.clearInfo();
                if (mounted) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const Login()),
                      (route) => false);

                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Logout Successful')));
                }
              },
              icon: const Icon(
                Icons.login,
                color: Colors.white,
              )),
        ),
      ),
    );
  }
}

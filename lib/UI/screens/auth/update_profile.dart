import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:task_managment/UI/screens/buttom_navigation.dart';
import 'package:task_managment/UI/widget/User_profile_banner.dart';
import 'package:task_managment/UI/widget/screen_background.dart';
import 'package:task_managment/data/model/network_response.dart';
import 'package:task_managment/data/services/network_caller.dart';
import 'package:task_managment/data/utils/urls.dart';
import '../../../data/model/auth_utility.dart';
import '../../../data/model/login_model.dart';

class update_profile extends StatefulWidget {
  const update_profile({Key? key}) : super(key: key);

  @override
  State<update_profile> createState() => _update_profileState();
}

class _update_profileState extends State<update_profile> {
  UserData userData = AuthUtlity.userInfo.data!;

  File? _pimage;
  late String bytes;

  Future imagepick() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }
    final imgtemp = File(image.path);
    setState(() {
      _pimage = imgtemp;
      bytes = convertIntoBase64(_pimage!);
      // log(b64.toString());
    });
  }

  String convertIntoBase64(File file) {
    List<int> imageBytes = file.readAsBytesSync();
    String base64File = base64Encode(imageBytes);
    return base64File;
  }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();

  GlobalKey<FormState> _updateform = GlobalKey<FormState>();

  Future<void> user_data() async {
    _emailController.text = AuthUtlity.userInfo.data!.email!;
    _firstnameController.text = AuthUtlity.userInfo.data!.firstName!;
    _lastnameController.text = AuthUtlity.userInfo.data!.lastName!;
    _mobileController.text = AuthUtlity.userInfo.data!.mobile!;
    bytes = AuthUtlity.userInfo.data!.photo!;
  }

  @override
  void initState() {
    // TODO: implement initState
    user_data();

    super.initState();
  }

  Future<void> updateprofile() async {
    NetworkResponse response = await NetworkCaller()
        .postrequest(Urls.profile_update, <String, dynamic>{
      "email": _emailController.text.trim(),
      "firstName": _firstnameController.text.trim(),
      "lastName": _lastnameController.text.trim(),
      "mobile": _mobileController.text.trim(),
      "photo": bytes,
    });

    if (response.isSuccess) {
      userData.firstName = _firstnameController.text.trim();
      userData.lastName = _lastnameController.text.trim();
      userData.mobile = _mobileController.text.trim();
      userData.photo = bytes;
AuthUtlity.updateUserInfo(userData);
      if (mounted) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Buttom_nav()),
            (route) => false);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Profile update succesfull'),
        ));
      }
    } else {
      log(response.statusCode.toString());
    }
  }

  Widget build(BuildContext context) {
    bool password = true;
    return Scaffold(
      body: screen_background(
        child: SingleChildScrollView(
          child: Column(
            children: [
              User_profile_banner(),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Form(
                  key: _updateform,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 22,
                      ),
                      Text(
                        'Update Profile',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Stack(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 18.0),
                            child: Center(
                              child: CircleAvatar(
                                radius: 70,
                                backgroundColor: Colors.blueAccent,
                                child: ClipOval(
                                  child: bytes != null
                                      ? Image.memory(
                                          base64Decode(bytes),
                                          fit: BoxFit.cover,
                                          width: 200.0,
                                          height: 200.0,
                                        )
                                      : Image.network(
                                          'https://t4.ftcdn.net/jpg/01/86/29/31/360_F_186293166_P4yk3uXQBDapbDFlR17ivpM6B1ux0fHG.jpg'),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 210,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 30.0),
                                child: CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.deepOrangeAccent,
                                    child: IconButton(
                                        onPressed: () {
                                          imagepick();
                                        },
                                        icon: Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                        ))),
                              ),
                              Spacer(
                                flex: 20,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 22,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 22,
                      ),
                      TextFormField(
                        readOnly: true,
                        enableInteractiveSelection: false,
                        focusNode: FocusNode(),
                        enabled: false,
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(hintText: 'Email'),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: _firstnameController,
                        keyboardType: TextInputType.text,
                        decoration:
                            const InputDecoration(hintText: 'First Name'),
                        validator: (String? value) {
                          if (value?.isEmpty ?? true) {
                            return 'Enter your first name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: _lastnameController,
                        keyboardType: TextInputType.text,
                        decoration:
                            const InputDecoration(hintText: 'Last Name'),
                        validator: (String? value) {
                          if (value?.isEmpty ?? true) {
                            return 'Enter your last name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: _mobileController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(hintText: 'Mobile'),
                        validator: (String? value) {
                          if (value?.isEmpty ?? true) {
                            return 'Enter your mobile number';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {
                              if (!_updateform.currentState!.validate()) {
                                return;
                              }
                              updateprofile();
                            },
                            child: const Icon(Icons.arrow_forward_ios_sharp)),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:task_managment/data/model/network_response.dart';
import 'package:task_managment/data/services/network_caller.dart';

import '../../../data/utils/urls.dart';
import '../../widget/screen_background.dart';
import 'loginScreen.dart';

class reset_password extends StatefulWidget {
  final String email, otp;
  const reset_password({Key? key, required this.email, required this.otp})
      : super(key: key);

  @override
  State<reset_password> createState() => _reset_passwordState();
}

class _reset_passwordState extends State<reset_password> {
  final GlobalKey<FormState> _password_form = GlobalKey<FormState>();
  bool password = true;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _password_confirmController =
      TextEditingController();

  Future<void> setpassword() async {
    if (_passwordController.text == _password_confirmController.text) {
      print(widget.email);
      print(widget.otp);
      NetworkResponse response = await NetworkCaller()
          .postrequest(Urls.password_change, <String, dynamic>{
        "email": widget.email,
        "OTP": widget.otp,
        "password": _passwordController.text,
      });

      if (response.isSuccess) {
        log(response.body.toString());
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Password Changed Successful')));
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Login()),
              (route) => false);
        }
      }else{
        log(response.body.toString());
      }
    } else {
      if (mounted) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text('Warning'),
                  content: const Text('Password not matched'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Okay'))
                  ],
                ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen_background(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: Form(
                key: _password_form,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 70,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text('Set Password',
                            style: Theme.of(context).textTheme.titleLarge),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                            'Minimum password should be 8 letters with number and symbols',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Colors.grey)),
                      ),
                    ),
                    TextFormField(
                      controller: _passwordController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          hintText: 'Password',
                          suffixIcon: IconButton(
                            onPressed: () {
                              password = false;
                              setState(() {});
                              Future.delayed(Duration(seconds: 1))
                                  .then((value) {
                                password = true;
                                setState(() {});
                              });
                            },
                            icon: Icon(Icons.remove_red_eye),
                          )),
                      obscureText: password,
                      validator: (String? value) {
                        if ((value?.isEmpty ?? true) || (value!.length <= 5)) {
                          return 'Enter your password more than 6';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: _password_confirmController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          hintText: 'Confirm Password',
                          suffixIcon: IconButton(
                            onPressed: () {
                              password = false;
                              setState(() {});
                              Future.delayed(Duration(seconds: 1))
                                  .then((value) {
                                password = true;
                                setState(() {});
                              });
                            },
                            icon: Icon(Icons.remove_red_eye),
                          )),
                      obscureText: password,
                      validator: (String? value) {
                        if ((value?.isEmpty ?? true) || (value!.length <= 5)) {
                          return 'Enter your password more than 6';
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
                            if (!_password_form.currentState!.validate()) {
                              return;
                            }

                            setpassword();
                          },
                          child: const Text('Confirm')),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Have an account',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 15,
                              letterSpacing: 0.5),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Login()),
                                  (route) => false);
                            },
                            child: const Text('Sign In'))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

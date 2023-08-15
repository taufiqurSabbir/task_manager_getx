import 'package:flutter/material.dart';
import 'package:task_managment/UI/state_manager/sign_upController.dart';
import '../../widget/screen_background.dart';
import 'loginScreen.dart';
import 'package:get/get.dart';

class signup extends StatefulWidget {
  const signup({Key? key}) : super(key: key);

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  bool password = true;

  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _first_namecontroller = TextEditingController();
  final TextEditingController _last_namecontroller = TextEditingController();
  final TextEditingController _mobilecontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: screen_background(
      child: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Form(
              key: formkey,
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
                      child: Text('Join With US',
                          style: Theme.of(context).textTheme.titleLarge),
                    ),
                  ),
                  TextFormField(
                    controller: _emailcontroller,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(hintText: 'Email'),
                    validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return 'Enter your email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _first_namecontroller,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(hintText: 'First Name'),
                    validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return 'Enter your First name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _last_namecontroller,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(hintText: 'Last Name'),
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
                    controller: _mobilecontroller,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(hintText: 'Mobile'),
                    validator: (String? value) {
                      if ((value?.isEmpty ?? true) || (value!.length < 11)) {
                        return 'Enter your valid mobile number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _passwordcontroller,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        hintText: 'Password',
                        suffixIcon: IconButton(
                            onPressed: () {
                              password = false;
                              setState(() {});
                              Future.delayed(Duration(seconds: 2))
                                  .then((value) {
                                password = true;
                                setState(() {});
                              });
                            },
                            icon: Icon(Icons.remove_red_eye_outlined))),
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
                  GetBuilder<SignUpController>(builder: (SignUpController) {
                    return SizedBox(
                      width: double.infinity,
                      child: Visibility(
                        visible: SignUpController.signupinprogress == false,
                        replacement:
                            const Center(child: CircularProgressIndicator()),
                        child: ElevatedButton(
                            onPressed: () {
                              if (!formkey.currentState!.validate()) {
                                return;
                              }
                              SignUpController.userSignUp(
                                      _emailcontroller.text.trim(),
                                      _first_namecontroller.text.trim(),
                                      _last_namecontroller.text.trim(),
                                      _mobilecontroller.text.trim(),
                                      _passwordcontroller.text,
                                      '')
                                  .then((value) {
                                if (value == 'true') {
                                  Get.snackbar('Field',
                                      'Something Wrong please try again');
                                } else {
                                  Get.to(const Login());
                                  Get.snackbar('Success',
                                      'Signup Succsfull please login here');
                                }
                              });
                            },
                            child: const Icon(Icons.arrow_forward_ios_sharp)),
                      ),
                    );
                  }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account?',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontSize: 15,
                            letterSpacing: 0.5),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()));
                          },
                          child: const Text('Sign in'))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}

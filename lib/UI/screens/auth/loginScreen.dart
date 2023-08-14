import 'package:flutter/material.dart';
import 'package:task_managment/UI/screens/buttom_navigation.dart';
import 'package:task_managment/UI/widget/screen_background.dart';
import 'package:task_managment/data/model/auth_utility.dart';
import 'package:task_managment/data/model/login_model.dart';
import 'package:task_managment/data/model/network_response.dart';
import 'package:task_managment/data/services/network_caller.dart';
import 'package:task_managment/data/utils/urls.dart';
import 'SignUp_screen.dart';
import 'email_varification_screen.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool password = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isloginprogress = false;

  Future<void> login() async {
    Map<String, dynamic> request_body = {
      "email": _emailController.text.trim(),
      "password": _passwordController.text,
    };
    isloginprogress=true;

    final NetworkResponse response =
        await NetworkCaller().postrequest(Urls.login, request_body);
    isloginprogress=false;

    if (response.isSuccess) {
      login_model model = login_model.fromJson(response.body!);
      await AuthUtlity.saveUserInfo(model);
      if(mounted){
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Buttom_nav()),
            (route) => false);
      }
    } else {
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Incorrect Email or password')));
      }
    }
  }

  final GlobalKey<FormState> _formLogin = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: screen_background(
      child: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Form(
              key: _formLogin,
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
                      child: Text('Get Started with',
                          style: Theme.of(context).textTheme.titleLarge),
                    ),
                  ),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(hintText: 'Email'),
                    validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return 'Enter Your Email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _passwordController,
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
                            icon: Icon(Icons.remove_red_eye))),
                    obscureText: password,
                    validator: (String? value) {
                      if ((value?.isEmpty ?? true) || (value!.length <= 5)) {
                        return 'Enter Your Password minimum 6 digit';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Visibility(
                      visible: isloginprogress ==false,
                      replacement: Center(child: CircularProgressIndicator()),
                      child: ElevatedButton(
                          onPressed: () {
                            if (!_formLogin.currentState!.validate()) {
                              return;
                            }
                            login();
                            // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Buttom_nav()), (route) => false);
                          },
                          child: const Icon(Icons.arrow_forward_ios_sharp)),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 18),
                      child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        email_varification()));
                          },
                          child: const Text(
                            'Forget Password?',
                            style: TextStyle(color: Colors.grey),
                          )),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don\'t have an account',
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
                                    builder: (context) => signup()));
                          },
                          child: const Text('Sign Up'))
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

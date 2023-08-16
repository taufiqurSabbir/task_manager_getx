import 'package:flutter/material.dart';
import 'package:task_managment/UI/screens/auth/OTP_varification.dart';
import 'package:task_managment/UI/widget/screen_background.dart';
import 'package:get/get.dart';

import '../../state_manager/email_varification.dart';


class email_varification extends StatefulWidget {
  const email_varification({Key? key}) : super(key: key);

  @override
  State<email_varification> createState() => _email_varificationState();
}

class _email_varificationState extends State<email_varification> {

 final GlobalKey<FormState> _formstate = GlobalKey<FormState>();

  TextEditingController _emailcontroller = TextEditingController();

 final EmailVarification emailvarification = Get.put(EmailVarification());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen_background(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(24.0),
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
                      child: Text('Your Email Address',
                          style: Theme.of(context).textTheme.titleLarge),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                          'A 6 digits pin will send to your email address',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Colors.grey)),
                    ),
                  ),
                  Form(
                    key: _formstate,
                    child: TextFormField(
                      controller: _emailcontroller,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(hintText: 'Email'),
                      validator: (String ? value){
                        if(value?.isEmpty ?? true){
                          return 'Enter your valid email';
                        }
                        return null;
                      },
                    ),
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
                         if(!_formstate.currentState!.validate()){
                           return;
                         }
                         emailvarification.email_send(_emailcontroller.text.trim()).then((result){
                           if(result==true){
                             Get.offAll(()=>OTP_varification(email: _emailcontroller.text.trim()));
                             Get.snackbar('Success', 'OTP sent to your email..! please check');
                           }else{
                             Get.snackbar('Failed', 'User Not find');
                           }
                         });
                        },
                        child: const Icon(Icons.arrow_forward_ios_sharp)),
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
                            Navigator.pop(context);
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
    );
  }
}

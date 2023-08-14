import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_managment/UI/screens/auth/reset_password.dart';
import 'package:task_managment/UI/widget/screen_background.dart';
import 'package:task_managment/data/model/network_response.dart';
import 'package:task_managment/data/services/network_caller.dart';

import '../../../data/utils/urls.dart';
import 'loginScreen.dart';

class OTP_varification extends StatefulWidget {
  final String email;
  const OTP_varification({Key? key, required  this.email}) : super(key: key);


  @override
  State<OTP_varification> createState() => _OTP_varificationState();
}

class _OTP_varificationState extends State<OTP_varification> {
  GlobalKey<FormState> _otpform = GlobalKey<FormState>();
TextEditingController _otpcontroller = TextEditingController();

Future<void> otpverify()async {
  if(_otpcontroller.text==''){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Empty value not allow')));
  }else{
    String otpVarifyUrl = Urls.otp_varify+widget.email+'/'+_otpcontroller.text.trim();
    NetworkResponse response = await NetworkCaller().getrequest(otpVarifyUrl);
    if(response.isSuccess){
      log(response.body.toString());

      if(response.body?['status']=='success'){
        if(mounted){
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) =>reset_password(otp:_otpcontroller.text.trim(),email:widget.email)),
                  (route) => false);
        }
      }else{
        if(mounted){
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: const Text('Warning'),
                      content: Text(response.body?['data']),
                      actions: [
                        TextButton(
                            onPressed: () {
                              _otpcontroller.clear();
                              Navigator.pop(context);
                            },
                            child: const Text('Okay'))
                      ],
                    ));
          }
        }

    }else{
      log(response.body.toString());
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
                      child: Text('PIN Verification',
                          style: Theme.of(context).textTheme.titleLarge),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                          'A 6 digits pin sent to your email address',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Colors.grey)),
                    ),
                  ),



                  Form(
                    child: PinCodeTextField(
                      length: 6,
                      controller: _otpcontroller,
                      obscureText: false,
                      animationType: AnimationType.fade,
                      keyboardType: TextInputType.number,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        activeFillColor: Colors.white,
                        inactiveFillColor: Colors.white,
                        inactiveColor: Colors.red,
                        activeColor: Colors.white,
                        selectedFillColor: Colors.white,
                        selectedColor: Colors.blueAccent,

                      ),
                      animationDuration: Duration(milliseconds: 300),
                      backgroundColor: Colors.white,
                      enableActiveFill: true,
                      cursorColor: Colors.blueAccent,
                      validator: (String ? value){
                        if(value?.isEmpty ?? true){
                          return 'Enter OTP here';
                        }
                      },

                      onCompleted: (v) {
                        print("Completed");
                      },
                      onChanged: (value) {
                        print(value);
                        setState(() {

                        });
                      },
                      beforeTextPaste: (text) {
                        print("Allowing to paste $text");
                        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                        //but you can show anything you want here, like your pop up saying wrong paste format or etc
                        return true;
                      }, appContext: context,
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
                          // if(!_otpform.currentState!.validate()){
                          //   return;
                          // }

                          otpverify();

                        },
                        child: const Text('Verify')),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already Have an account?',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontSize: 15,
                            letterSpacing: 0.5),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Login()), (route) => false);
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

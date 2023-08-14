import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:task_managment/UI/screens/buttom_navigation.dart';
import 'package:task_managment/UI/widget/User_profile_banner.dart';
import 'package:task_managment/data/model/network_response.dart';
import 'package:task_managment/data/services/network_caller.dart';

import '../../data/utils/urls.dart';
import '../widget/screen_background.dart';

class add_new_task extends StatefulWidget {
  const add_new_task({Key? key}) : super(key: key);

  @override
  State<add_new_task> createState() => _add_new_taskState();
}

class _add_new_taskState extends State<add_new_task> {
  TextEditingController _titleController =TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  final GlobalKey<FormState> _add_task = GlobalKey<FormState>();
  bool isprogreess = false;

   Future<void>addNewTask()async {
     isprogreess = true;
     if(mounted){
       setState(() {
       });
     }

     Map<String,dynamic> requestbody={
       "title":_titleController.text.trim(),
       "description":_descriptionController.text.trim(),
       "status":"New"
     };

       NetworkResponse response = await NetworkCaller().postrequest(Urls.addNewTask,
           requestbody);

     isprogreess=false;
     if(mounted){
       setState(() {});
     }
       if(response.isSuccess){
         log(response.body.toString());
         if(mounted){
           Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Buttom_nav()), (route) => false);
           _titleController.clear();
           _descriptionController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('successfully added New task')));
      }
    }else{
         if(mounted){
           log(response.body.toString());
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Something wrong..! Try again')));
      }
    }
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen_background(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              User_profile_banner(),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Form(
                  key: _add_task,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 25,),
                      Text('Add New Task',style: Theme.of(context).textTheme.titleLarge,),
                      TextFormField(
                        controller: _titleController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(hintText: 'Title'),
                        validator: (String ? value){
                          if(value?.isEmpty ?? true){
                            return 'Enter task Title';
                          }
                        },
                      ),
                      SizedBox(height: 14,),
                      TextFormField(
                        controller: _descriptionController,
                        maxLines: 4,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(hintText: 'Description'),
                        validator: (String ? value){
                          if(value?.isEmpty ?? true){
                            return 'Enter task Description';
                          }
                        },

                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Visibility(
                          visible: isprogreess == false,
                          replacement: Center(child: CircularProgressIndicator()),

                          child: ElevatedButton(
                              onPressed: () {
                               if( !_add_task.currentState!.validate()){
                                  return;
                                }
                               addNewTask();

                              },
                              child: const Icon(Icons.arrow_forward_ios_sharp)),
                        ),
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

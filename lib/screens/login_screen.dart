import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_quiz/Widgets/input_text_field.dart';
import 'package:online_quiz/resources/auth_methods.dart';
import 'package:online_quiz/screens/sign_up_screen.dart';
import 'package:online_quiz/screens/student/studentscreen.dart';
import 'package:online_quiz/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'faculty/facultyScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  String selectedValue = value1;
  @override
  Widget build(BuildContext context) {
   final Width=MediaQuery.of(context).size.width;
   final Height=MediaQuery.of(context).size.height;
   login()async{
     String res = await AuthMethod().loginUser(email: emailcontroller.text.trim(), password: passcontroller.text.trim());
     if(res=='success'){
       var pref = await SharedPreferences.getInstance();
       pref.setString('key', selectedValue);
       print(selectedValue);
     }
     if(selectedValue == value1 && res =='success'){
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>StudentScreen()));

     }
     else if(selectedValue == value2 && res =='success'){
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>FacultyScreen()));
     }
     shosnacbar(context, res);
   }

    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: Width > 600
              ? EdgeInsets.symmetric(
              horizontal: Width / 2.9)
              : const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
      
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              DropdownButton<String>(
                borderRadius: BorderRadius.circular(10),
                autofocus:true,
                value: selectedValue,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedValue = newValue!;
                  });
                },
                items: <String>[value1, value2,]
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value)
                  );
                }).toList(),
              ),
              SizedBox(height: 25,),
              InputText(controller: emailcontroller, hint: "Enter your Email"),
              SizedBox(height: 20,),
              InputText(controller: passcontroller, hint:'Enter password',ispass: true,isform: true,),
              SizedBox(height: 25,),
              FilledButton(onPressed:login, child: Text('  Log in  ')),
              SizedBox(height: 10,),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Do not have accunt '),
                    InkWell(
                        child: Text('Resiter',style: TextStyle(color: Colors.deepPurple),),
                      onTap: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
                      },
                    )
                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}

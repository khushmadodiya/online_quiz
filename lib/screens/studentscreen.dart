import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../resources/auth_methods.dart';
import 'login_screen.dart';

class StudentScreen extends StatefulWidget {
  const StudentScreen({super.key});

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: Center(child: Text('Sudent Screen')),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
          String res= await AuthMethod().signOut();
          if(res=='success') {
            var pref = await SharedPreferences.getInstance();
            pref.setString('key', 'null');
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
          }
        },
      ),));
  }
}

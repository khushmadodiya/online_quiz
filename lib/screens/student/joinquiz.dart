import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_quiz/resources/firestore_methso.dart';
import 'package:online_quiz/screens/student/studentscreen.dart';

import '../../Widgets/input_text_field.dart';
import '../../utils/utils.dart';
import '../faculty/facultyScreen.dart';

class JoinQuiz extends StatefulWidget {
  const JoinQuiz({super.key});

  @override
  State<JoinQuiz> createState() => _JoinQuizState();
}

class _JoinQuizState extends State<JoinQuiz> {

  TextEditingController codecontroller = TextEditingController();
  _submit()async{
    String res = await FireStoreMethos().add_student_to_quiz(quid: codecontroller.text.trim());
    if(res=='success'){
      shosnacbar(context, res);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>StudentScreen()));
    }
  }
  @override
  Widget build(BuildContext context) {
    final Width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Join Quiz"),
      ),

      body: Container(
        padding: Width > 600
            ? EdgeInsets.symmetric(horizontal: Width / 2.9)
            : const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 70,
            ),
            InputText(controller: codecontroller, hint: "Enter code"),
            SizedBox(
              height: 20,
            ),
            FilledButton(onPressed: _submit, child: Text('  Submit  ')),
            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }
}

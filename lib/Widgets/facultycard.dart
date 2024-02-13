import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_quiz/resources/firestore_methso.dart';
import 'package:flutter/services.dart';

import '../screens/faculty/question_screen.dart';
import '../screens/faculty/student_marks_screen.dart';
import '../utils/utils.dart';

class FacultyCard extends StatefulWidget {
  final snap;
  const FacultyCard({
    super.key,
    required this.snap,
  });

  @override
  State<FacultyCard> createState() => _FacultyCardState();
}

class _FacultyCardState extends State<FacultyCard> {
  // void _delete() async {
  //   String res = await AuthMethod().delete(widget.snap['uid']);
  //   shosnacbar(context, res);
  // }

  // _showdialog(BuildContext context) {
  //   return showDialog(
  //       context: context,
  //       builder: (context) {
  //         return SimpleDialog(
  //           backgroundColor: Colors.black,
  //           children: [
  //             SimpleDialogOption(
  //                 padding: EdgeInsets.all(20),
  //                 child: Text('Delete this customer detail'),
  //                 onPressed: () {
  //                   _dialog(context);
  //                   // Navigator.pop(context);
  //                 })
  //           ],
  //         );
  //       });
  // }

  void _copyToClipboard() {
    Clipboard.setData(
        ClipboardData(text:widget.snap['quizuid'].toString()));
    Navigator.pop(context);
    shosnacbar(context, 'Text copied to clipboard');
  }

  // _dialog(BuildContext context) {
  //   return showDialog(
  //       context: context,
  //       builder: (context) =>
  //           AlertDialog(title: Text('Are you sure'), actions: [
  //             TextButton(
  //                 onPressed: () {
  //                   // _delete();
  //                   Navigator.pop(context);
  //                   Navigator.pop(context);
  //                 },
  //                 child: Text('Yes'))
  //           ]));
  // }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
        margin: EdgeInsets.symmetric(
          horizontal: width > webScreenSize ? width * 0.3 : 30,
          vertical: width > webScreenSize ? 15 : 10,
        ),
        height: MediaQuery.of(context).size.height / 5,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color.fromRGBO(193, 174, 242, 100),
          borderRadius: BorderRadius.circular(15),
        ),
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => QuestionScreen(snap: widget.snap)));
          },
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ListTile(
              title: Text(
                widget.snap['quiztitle'].toString(),
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                widget.snap['subname'].toString(),
                style: TextStyle(fontSize: 15),
              ),
              trailing: IconButton(
                onPressed: () async {
                  showDialog(
                      useRootNavigator: false,
                      context: context,
                      builder: (context) {
                        return SimpleDialog(
                          children: [
                            SimpleDialogOption(
                                child: Column(
                                  children: [
                                    Text('Share Quiz'),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.deepPurple)),
                                            child: SelectableText(
                                              widget.snap['quizuid'].toString(),
                                              style: TextStyle(fontSize: 15),
                                              textAlign: TextAlign.justify,
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: _copyToClipboard,
                                          icon: Icon(Icons.copy),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                onPressed: () {}),
                            SizedBox(
                              height: 10,
                            ),
                            SimpleDialogOption(
                                child: Center(
                                    child: Text(
                                  'Delete Quiz',
                                  style: TextStyle(fontSize: 20),
                                )),
                                onPressed: () async {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                              title: Text('Are you sure'),
                                              actions: [
                                                TextButton(
                                                    onPressed: () async {
                                                      Navigator.pop(context);
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text('No')),
                                                TextButton(
                                                    onPressed: () async {
                                                      String res =
                                                          await FireStoreMethos()
                                                              .deleteequiz(
                                                                  quizuid: widget
                                                                          .snap[
                                                                      'quizuid']);
                                                      Navigator.pop(context);
                                                      Navigator.pop(context);
                                                      shosnacbar(context, res);
                                                    },
                                                    child: Text('Yes'))
                                              ]));
                                }),
                            SimpleDialogOption(
                              child: Text('Student Marks List'),
                              onPressed: (){
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>StudnetsMarksScreen(snap: widget.snap,)));
                              },
                        
                            )
                          ],
                        );
                      });
                },
                icon: const Icon(Icons.more_vert),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    widget.snap['name'],
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
            )
          ]),
        ));
  }
}

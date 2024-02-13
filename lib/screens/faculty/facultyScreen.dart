import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:online_quiz/Widgets/facultycard.dart';
import 'package:online_quiz/resources/auth_methods.dart';
import 'package:online_quiz/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
import 'create_quiz.dart';


class FacultyScreen extends StatefulWidget {
  const FacultyScreen({super.key});

  @override
  State<FacultyScreen> createState() => _FacultyScreenState();
}

class _FacultyScreenState extends State<FacultyScreen> {
  String url = '';
  @override
  void initState() {
    // TODO: implement initState
    getphotourl();
  }

  void getphotourl() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('faculty')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    url = await snapshot['photoUrl'].toString();
    print('url$url');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: FaIcon(FontAwesomeIcons.bars),
        ),
        title: Text('Online Quiz'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(2.0), // Adjust the height as needed
          child: Divider(
            thickness: 1,
            color: Colors.black54,
          ),
        ),
        actions: [
          InkWell(
            onTap: () async {},
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://firebasestorage.googleapis.com/v0/b/online-quiz-8566e.appspot.com/o/profile%2FpuyOskxJE2Y7JFDxpeclvuWoGSC3?alt=media&token=42637376-db7c-42cc-b031-581d246ca386'))),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          IconButton(
              onPressed: () {
                showDialog(
                  useRootNavigator: false,
                  context: context,
                  builder: (context) {
                    return SimpleDialog(
                      children: [
                        SimpleDialogOption(
                            child: Center(
                                child: Text(
                              'Log out',
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
                                                      await AuthMethod()
                                                          .signOut();
                                                  if (res == 'success') {
                                                    var pref =
                                                        await SharedPreferences
                                                            .getInstance();
                                                    pref.setString('key', '');
                                                    Navigator.pop(context);
                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    MyApp()));
                                                  }
                                                },
                                                child: Text('Yes')),
                                          ]));
                            }),
                      ],
                    );
                  },
                );
              },
              icon: Icon(Icons.settings))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CreateQuiz()));
        },
        child: Icon(Icons.add),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('quiz').where('facultyuid',isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              return FacultyCard(
                snap: snapshot.data!.docs[index].data(),
              );
            },
          );
        },
      ),
    );
  }
}
// onPressed: ()async{
// await AuthMethod().signOut();
// Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
// },

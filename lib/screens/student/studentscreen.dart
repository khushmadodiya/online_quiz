import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:online_quiz/Widgets/student_card.dart';
import 'package:online_quiz/resources/auth_methods.dart';
import 'package:online_quiz/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../main.dart';
import 'joinquiz.dart';

class StudentScreen extends StatefulWidget {
  final quizuid;
  const StudentScreen({super.key, this.quizuid});

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  String url = '';
  String quizid='';
  @override
  void initState() {
    // TODO: implement initState
    getphotourl();
  }

  void getphotourl() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('student')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    // DocumentSnapshot snap = await FirebaseFirestore.instance
    //     .collection('student')
    //     .doc(FirebaseAuth.instance.currentUser!.uid)
    //     .get();
    url = await snapshot['photoUrl'].toString();
    // quizid=await snapshot[''];
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
                          'https://firebasestorage.googleapis.com/v0/b/online-quiz-8566e.appspot.com/o/profile%2F9YAyGqhAKAXQQIH42JM5dqajQBd2?alt=media&token=09f48716-13a6-49e2-831c-4a96aa6978ba'))),
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
                                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginScreen()), (route) => false);
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
            context, MaterialPageRoute(builder: (context) => JoinQuiz()));
        },
        child: Center(child: Text('Join')),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('student').doc(FirebaseAuth.instance.currentUser!.uid).collection('quizes').where('status',isEqualTo: false)
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
              return StudentCard(
                snap: snapshot.data!.docs[index].data(),
              );
            },
          );
        },
      ),
    );
  }
}
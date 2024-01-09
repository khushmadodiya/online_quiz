

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:online_quiz/Widgets/facultycard.dart';
import 'package:online_quiz/resources/auth_methods.dart';
import 'package:online_quiz/screens/create_quiz.dart';
import 'package:online_quiz/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class FacultyScreen extends StatefulWidget {
  const FacultyScreen({super.key});

  @override
  State<FacultyScreen> createState() => _FacultyScreenState();
}

class _FacultyScreenState extends State<FacultyScreen> {
  String url='';
  @override
  void initState() {
    // TODO: implement initState
    getphotourl();
  }
  void getphotourl() async{
    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('faculty').doc(useruid).get();
    url = await snapshot.get('photoUrl').toString();
    print('url$url');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
          },
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
            onTap: ()async{
            },
            child: Container(
             height: 20,
              width: 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(image: NetworkImage('$url'))
              ),

            ),
          ),
          IconButton(onPressed: ()async{
            String res = await AuthMethod().signOut();
            if(res=='success'){
              var pref = await SharedPreferences.getInstance();
               pref.setString('key', '');
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyApp()));

            }
          }, icon: Icon(Icons.settings))
        ],

      ),


      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateQuiz()));
        },
        child: Icon(Icons.add),
      ),

      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('faculty')
            .doc(useruid)
            .collection('quiz')
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
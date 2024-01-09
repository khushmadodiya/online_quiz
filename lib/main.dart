import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:online_quiz/firebase_options.dart';
import 'package:online_quiz/screens/facultyScreen.dart';
import 'package:online_quiz/screens/login_screen.dart';
import 'package:online_quiz/screens/sign_up_screen.dart';
import 'package:online_quiz/screens/studentscreen.dart';
import 'package:online_quiz/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
var key ='';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  var pref = await SharedPreferences.getInstance();
  key = pref.getString('key').toString();
  print(key);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if(snapshot.connectionState==ConnectionState.active){
            if(snapshot.hasData){
              if(key=='Student'){
                return StudentScreen();
              }
              else if(key=='Faculty'){
                return FacultyScreen();
              }
            }
            else if(snapshot.hasError){
              return Center(child: Text('some error occur'),);
            }
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return LoginScreen();
    },
      ),
    );
  }
}




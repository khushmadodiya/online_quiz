import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
FirebaseFirestore _firestore = FirebaseFirestore.instance;


class FireStoreMethos {
  Future<String> createquiz(
      {required String quiztitle,
      required String name,
      required String subname}) async {
    var quizuid = Uuid().v1();
    String res = 'some error occure';
    await _firestore
        .collection('faculty')
        .doc(_auth.currentUser!.uid)
        .collection('quiz')
        .doc(quizuid)
        .set({
      'quizuid': quizuid,
      'quiztitle': quiztitle,
      'name': name,
      'subname': subname
    }).onError((error, stackTrace) => res = 'some error occure $error');
    res = 'success';
    return res;
  }
  Future<String> addquestion(
      {required String question,
        required String option1,
        required String option2,
        required String option3,
        required String option4,
        required String rightans,
        required String quid
      }) async {
    var uid = Uuid().v1();
    String res = 'some error occure';
    await _firestore
        .collection('faculty')
        .doc(_auth.currentUser!.uid)
        .collection('quiz')
        .doc(quid).collection('questions').doc(uid)
        .set({
      'question': question,
      'option1': option1,
      'option2': option2,
      'option3': option3,
      'option4': option4,
      'ans':rightans
    }).onError((error, stackTrace) => res = 'some error occure $error');
    res = 'success';
    return res;
  }
}

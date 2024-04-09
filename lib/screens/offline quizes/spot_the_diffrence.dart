
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keyboard_hider/keyboard_hider.dart';
import 'package:online_quiz/Widgets/card_widget.dart';
import 'package:online_quiz/globle.dart';
import 'package:online_quiz/resources/firestore_methso.dart';
import 'package:online_quiz/screens/HomeScreen.dart';

class Spot extends StatefulWidget {
  const Spot({super.key});

  @override
  State<Spot> createState() => _SpotState();
}

class _SpotState extends State<Spot> {


  void sendans(ans,int index)async{

    hideTextInput();
    var res =await FireStoreMethos().setAns(ans,index.toString(),'Spot');
    print(res);
    if(res=='s'){
      Fluttertoast.showToast(msg: 'succses');
    }

  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:ListView.builder(itemBuilder: (context,index){
        final TextEditingController anscontroller=TextEditingController();
        return CardWid(index: index,isspot:true);

      },
        itemCount: spot.length,
      ),
    );
  }
}

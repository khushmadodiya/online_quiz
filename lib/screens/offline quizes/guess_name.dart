import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keyboard_hider/keyboard_hider.dart';
import 'package:online_quiz/Widgets/card_widget.dart';
import 'package:online_quiz/globle.dart';

import '../../resources/firestore_methso.dart';

class Guess extends StatefulWidget {
  const Guess({super.key});

  @override
  State<Guess> createState() => _GuessState();
}

class _GuessState extends State<Guess> {
  final TextEditingController anscontroller=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:ListView.builder(itemBuilder: (context,index){
        return CardWid(index: index);

      },
        itemCount: spot.length,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:online_quiz/globle.dart';

class Spot extends StatefulWidget {
  const Spot({super.key});

  @override
  State<Spot> createState() => _SpotState();
}

class _SpotState extends State<Spot> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Spot the diffrence'),
      ),
      body:Container(
        child: ListView.builder(itemBuilder: (context,index){
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20)
              ),
              child: Image.asset('assets/spot/${spot[index]}'),
            ),
          );
        },
          itemCount: spot.length,
        ),
      ),
    );
  }
}

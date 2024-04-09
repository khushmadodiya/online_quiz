import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keyboard_hider/keyboard_hider.dart';

import '../globle.dart';
import '../resources/firestore_methso.dart';

class CardWid extends StatefulWidget {
  final index;
  final isspot;
  const CardWid({super.key, required this.index, this.isspot=false});

  @override
  State<CardWid> createState() => _CardWidState();
}

class _CardWidState extends State<CardWid> {
  bool flag =false;
  TextEditingController anscontroller = TextEditingController();
  void sendans(ans,int index)async{

    hideTextInput();
    var res =await FireStoreMethos().setAns(ans,index.toString(),'Gess');
    print(res);
    if(res=='s'){
      Fluttertoast.showToast(msg: 'succses');
    }


  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Container(
            height: MediaQuery.of(context).size.height/3.1,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              // color: Colors.grey
            ),
            child:
            Column(
                children: [
                  widget.isspot ?Container(height:200,child: Image.asset('assets/spot/${spot[widget.index]}')):Container(height:200,child: Image.asset('assets/animals/${animals[widget.index]}')),
                  Container(
                      height: MediaQuery.of(context).size.height/14,
                      color: Colors.black,
                      child: Row(
                        children: [
                          IconButton(onPressed: (){
                            if(flag){
                              setState(() {
                                flag=false;
                              });
                            }
                            else{
                              setState(() {
                                flag=true;
                              });
                            }
                          }, icon: flag ?  Icon(Icons.favorite,color: Colors.deepPurple,):Icon( Icons.favorite_outline)),
                          Expanded(
                            child: TextField(
                              controller: anscontroller,
                              decoration: InputDecoration(
                                  hintText: '   Enter answer ..'
                              ),
                            ),
                          ),
                          IconButton(onPressed: (){
                            sendans(anscontroller.text.trim(),widget.index);
                            anscontroller.clear();
                          }, icon: Icon(Icons.send_outlined,color: Colors.deepPurple,)),
                          IconButton(onPressed: (){}, icon: Icon(Icons.message ,))
                        ],
                      )
                  ),
                ]
            ),
          )
      )
    );
  }
}

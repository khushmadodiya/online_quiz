import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/utils.dart';

class QuestionCard extends StatefulWidget {
  final snap;
  final index;
  const QuestionCard({super.key,required this.snap, this.index});

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
        margin: EdgeInsets.symmetric(
          horizontal: width > webScreenSize ? width * 0.3 : 30,
          vertical: width > webScreenSize ? 15 : 10,
        ),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color.fromRGBO(193, 174, 242, 100),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              ListTile(
                leading: Text('${widget.index.toString()})',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
              title:SelectableText('${widget.snap['question'].toString()}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),

              trailing: IconButton(
                onPressed: (){},
                icon: const Icon(Icons.more_vert),
              ),

            ),
             ListTile(
               leading: Text('I)',style: TextStyle(fontSize: 17),),
               title: SelectableText(widget.snap['option1'].toString(),style: TextStyle(fontSize: 17),),
             ),
              ListTile(
                leading: Text('II)',style: TextStyle(fontSize: 17),),
                title: SelectableText(widget.snap['option2'].toString(),style: TextStyle(fontSize: 17),),
              ),
              ListTile(
                leading: Text('III)',style: TextStyle(fontSize: 17),),
                title: SelectableText(widget.snap['option3'].toString(),style: TextStyle(fontSize: 17),),
              ),
              ListTile(
                leading: Text('IV)',style: TextStyle(fontSize: 17),),
                title: SelectableText(widget.snap['option4'].toString(),style: TextStyle(fontSize: 17),),
                // trailing: Text("ans = ${widget.snap['ans']}",style: TextStyle(fontSize: 17),),
              ),
              Align(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("ans = ${widget.snap['ans']}",style: TextStyle(fontSize: 17),),
                ),
                alignment: Alignment.bottomCenter,
              )

            ]
        )
    );
  }
}

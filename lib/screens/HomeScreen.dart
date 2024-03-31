import 'package:flutter/material.dart';
import 'package:online_quiz/screens/login_screen.dart';
import 'package:online_quiz/screens/offline%20quizes/spot_the_diffrence.dart';
import 'package:online_quiz/screens/sign_up_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   onPressed: () {},
        //   icon: FaIcon(FontAwesomeIcons.bars),
        // ),
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
                  color: Colors.deepPurple[100],
                  borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(Icons.person,size: 30,),
            )
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
                              child: Container(
                                width:double.infinity,
                               
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color:Colors.deepPurple[100],
                                ),
                                height: 40,
                                child: Center(
                                  child: Text(
                                    'Log In',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ),
                            ),
                            onPressed: () async {
                              Navigator.pop(context);
                               Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));

                            }),
                        SimpleDialogOption(
                            child: Container(
                              width:double.infinity,
                              decoration:BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color:Colors.deepPurple[100],
                              ),
                              child: Center(
                                child: Text(
                                  'Register',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              height: 40,
                            ),
                            onPressed: () async {
                              Navigator.pop(context);
                             Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
                            }),
                      ],
                    );
                  },
                );
              },
              icon: Icon(Icons.settings))
        ],
      ),
      body: Container(
         child: Column(
           children: [
             SizedBox(height: 20,),
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 10.0),
               child: InkWell(
                 onTap: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>Spot()));
                 },

                 child: Container(
                   width:double.infinity,
                   decoration:BoxDecoration(
                     borderRadius: BorderRadius.circular(20),
                     color:Colors.deepPurple[100],
                   ),
                   child: Center(
                     child: Text(
                       'Spot the diffrence',
                       style: TextStyle(fontSize: 20),
                     ),
                   ),
                   height: 40,
                 ),
               ),
             ),
             SizedBox(height: 20,),
              Padding(
               padding: const EdgeInsets.symmetric(horizontal: 10.0),
               child: Container(
                 width:double.infinity,
                 decoration:BoxDecoration(
                   borderRadius: BorderRadius.circular(20),
                   color:Colors.deepPurple[100],
                 ),
                 child: Center(
                   child: Text(
                     'Spot the diffrence',
                     style: TextStyle(fontSize: 20),
                   ),
                 ),
                 height: 40,
               ),
             ),
             SizedBox(height: 20,),
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 10.0),
               child: Container(
                 width:double.infinity,
                 decoration:BoxDecoration(
                   borderRadius: BorderRadius.circular(20),
                   color:Colors.deepPurple[100],
                 ),
                 child: Center(
                   child: Text(
                     'Spot the diffrence',
                     style: TextStyle(fontSize: 20),
                   ),
                 ),
                 height: 40,
               ),
             ),
             SizedBox(height: 20,),

           ],
         ),
      ),
    );
  }
}

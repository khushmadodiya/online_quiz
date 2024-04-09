import 'package:flutter/material.dart';
import 'package:online_quiz/screens/login_screen.dart';
import 'package:online_quiz/screens/offline%20quizes/guess_name.dart';
import 'package:online_quiz/screens/offline%20quizes/spot_the_diffrence.dart';
import 'package:online_quiz/screens/sign_up_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
_tabController=TabController(length: 2, vsync: this);
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   onPressed: () {},
        //   icon: FaIcon(FontAwesomeIcons.bars),
        // ),
        title: Text('Online Quiz'),
        bottom:TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              child: Text('Spot the Difference'),
            ),
            Tab(
              child: Text('Guess name'),
            ),
          ],
          
        ),
        actions: [

          InkWell(
              onTap: () {
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
                                    style: TextStyle(fontSize: 20,color: Colors.black),
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
                                  style: TextStyle(fontSize: 20,color: Colors.black),
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
              child:Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple[100],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(Icons.person,size: 30,color: Colors.black,),
                ),
              ),
          )
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Spot(),
          Guess()
        ]

      )

    );
  }
}

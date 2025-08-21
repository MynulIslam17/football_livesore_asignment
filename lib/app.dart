
import 'package:firebase_assignment/ui/screens/home_screen.dart';
import 'package:firebase_assignment/ui/screens/match_info_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MatchUpdate extends StatelessWidget{
  const MatchUpdate({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

    //  home: HomeScreen(),
      debugShowCheckedModeBanner: false,

      theme: ThemeData(

        textTheme: const  TextTheme(
          titleSmall: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 19,
            color: Colors.black


          )

        )


      ),

      initialRoute:HomeScreen.name,

      routes: {

        HomeScreen.name  : (context) => HomeScreen(),
      //  MatchInfoScreen.name : (context) => MatchInfoScreen()


      },

    );

  }


}

 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_assignment/data/models/match_model.dart';
import 'package:firebase_assignment/ui/screens/match_info_screen.dart';
import 'package:firebase_assignment/ui/widgets/match_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {

   static const String name="/homeScreen";

   const HomeScreen({super.key});

   @override
   State<HomeScreen> createState() => _HomeScreenState();
 }

 class _HomeScreenState extends State<HomeScreen> {


  List<MatchModel> _matchList=[];
  FirebaseFirestore db=FirebaseFirestore.instance;
  bool _isLoading=false;


  // Future<void> _fetchData() async{
  //
  //   setState(() {
  //     _isLoading=true;
  //   });
  //
  //   _matchList.clear();
  //
  //     QuerySnapshot snapshots  = await db.collection("football").get();
  //
  //     for(QueryDocumentSnapshot doc in snapshots.docs){
  //
  //       MatchModel model=MatchModel(
  //             id: doc.id,
  //           team1_name: doc["team1_name"],
  //           team2_name: doc["team2_name"],
  //           team1_goal:doc["team1_goal"],
  //           team2_goal:doc["team2_goal"],
  //           curent_time: doc["current_time"],
  //           match_time: doc["match_time"]
  //       );
  //
  //
  //       _matchList.add(model);
  //
  //
  //     }
  //
  //     await Future.delayed(Duration(seconds: 1));
  //
  //   setState(() {
  //
  //     _isLoading=false;
  //
  //   });
  //
  //
  // }
  //
  //
  // @override
  // void initState() {
  //   // TODO: implement initState
  //
  //   _fetchData();
  //   super.initState();
  // }
  //
  //



   @override
   Widget build(BuildContext context) {
     return Scaffold(
       backgroundColor: Color(0xFFE62F2F),
       appBar: AppBar(
         backgroundColor: Colors.redAccent,
          actions: [

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.redAccent.shade100,
                    borderRadius:BorderRadius.circular(10)
                  ),
                  child: Center(child:IconButton(onPressed: (){},
                      padding: EdgeInsets.zero,
                      icon: Icon(Icons.calendar_month_rounded,size: 30,color: Colors.white,))

                  )
              ),
            )
          ],
         leading: IconButton(onPressed: (){},
             icon: Icon(Icons.menu,size: 30,color: Colors.white,)
         )
       ),
       
       body: SingleChildScrollView(
         child: Padding(
           padding: const EdgeInsets.all(8.0),
           child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
             children: [
         
               const SizedBox(height: 30,),
         
              // Text("Live\nMatches",style:TextStyle(fontSize: 40),)
         
         
               RichText(
                   text: TextSpan(
         
                    style: TextStyle( // it is default value  if not overrride then it  will set
                      fontSize:34,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
         
                    ) ,
         
                     children:const [
                       TextSpan(
                         text: "Live\n"
                       ),
         
                       TextSpan(
                         text:"Matches",
                         style: TextStyle(color: Colors.black
                         )
                       )
         
         
                     ]
         
         
         
               ),
               ),
         
               const  SizedBox(
                 height: 20,
               ),
         


           StreamBuilder<QuerySnapshot>(
               stream: db.collection("football").snapshots(),


               builder: (context,snapshots){

                 if(snapshots.hasError){

                   return   Center(

                     child: Text("Something went wrong"),
                   );
                 }

                 if(snapshots.connectionState==ConnectionState.waiting){


                   return Center(child: CircularProgressIndicator(
                     color: Colors.white,
                   ),);
                 }


                 if(snapshots.hasData){

                   _matchList.clear();

                   for(QueryDocumentSnapshot doc in snapshots.data!.docs){

                     MatchModel model=MatchModel(
                                     id: doc.id,
                                   team1_name: doc["team1_name"],
                                   team2_name: doc["team2_name"],
                                   team1_goal:doc["team1_goal"],
                                   team2_goal:doc["team2_goal"],
                                   curent_time: doc["current_time"],
                                   match_time: doc["match_time"]
                               );


                     _matchList.add(model);


                   }





                 }




                 return ListView.builder(
                   shrinkWrap: true,
                   physics: NeverScrollableScrollPhysics(),

                   itemBuilder: (context,index){



                   final model=_matchList[index];

                   return MatchCard(onclick: (){


                     Navigator.push(context, MaterialPageRoute(builder: (context)=>MatchInfoScreen(
                       model: model,

                     )));

                   },
                       model: model
                   );


                 },

                   itemCount: _matchList.length,


                 );




               }



           )








             ],
         
         
         
         
           ),
         ),
       ),
       
       
       
       
     );
   }
 }

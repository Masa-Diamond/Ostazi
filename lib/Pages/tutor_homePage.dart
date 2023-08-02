// ignore_for_file: file_names, unused_import, prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, unnecessary_new

import 'package:flutter/material.dart';
import 'package:grad_project/Pages/Test-Calander.dart';
import 'package:grad_project/Pages/add_appointments.dart';
import 'package:grad_project/Pages/chat_reg_teacher.dart';
//import 'package:grad_project/Pages/calender.dart';
import 'package:grad_project/Pages/courses_clases_tutor.dart';
import 'package:grad_project/Pages/tutor_calendar.dart';
import 'package:grad_project/main.dart';
import 'package:grad_project/pages/tutor_account.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grad_project/Pages/inbox-student.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firestore = FirebaseFirestore.instance;
late User signedInUser;


class TutorHomePage extends StatefulWidget {
  const TutorHomePage({super.key});

  @override
  State<TutorHomePage> createState() => _TutorHomePageState();
}

class _TutorHomePageState extends State<TutorHomePage> {
  late String FirstName;
  @override
  final _auth = FirebaseAuth.instance;
 
  final users = FirebaseAuth.instance.currentUser;
  final info = FirebaseFirestore.instance
                        .collection("tutors")
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .get()
                        .then((value) => value)
                        .then((value) => value.data());
  @override
  void initState(){
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async{
    try {
      final user = _auth.currentUser;
      if (user != null){
      signedInUser = user;
      print(signedInUser.email);
      DocumentSnapshot ds = await FirebaseFirestore
      .instance.collection('tutors').doc(_auth.currentUser!.uid).get();
      FirstName = ds.get('FirstName'); print(FirstName);
      FirebaseFirestore.instance
            .collection('tutors')
            .doc(_auth.currentUser!.uid)
            .snapshots().listen((userData) { 
              setState(() {
                FirstName = userData.data()!['FirstName'];
              });
            });
      }
    } catch (e) {
      print(e);
    }
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color.fromARGB(255, 4, 4, 71),
      appBar: AppBar(
        iconTheme: IconThemeData(size:30,color: Color.fromARGB(255, 192, 218, 240)),
        backgroundColor: Color.fromARGB(255, 4, 4, 71),
        title:
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: 250,height: 100,
               decoration: BoxDecoration(
               image: DecorationImage(
               image: AssetImage("assets/images/logo2.png"),
               fit: BoxFit.fitWidth
           ),),
          ),           
        ],),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => LogIn() ));
            },
             icon: Icon(Icons.logout), color: Color.fromARGB(255, 234, 234, 250),)
        ],
      ),
      body: Padding(padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          SizedBox(height:10,),
          FutureBuilder(
            future: info,
            builder: (context, snapshot){
              if (snapshot.hasData){
                var acc = FirebaseFirestore.instance.collection('tutors')
                .doc(FirebaseAuth.instance.currentUser!.uid).get()
                .then((value) => {
                  FirstName = value.get('FirstName'),
                });
                return Container(
                  padding: EdgeInsets.all(5),
                  color: Color.fromARGB(255, 4, 4, 71),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        
                        Column(
                              children: [
                                Text('مرحبا بعودتك',
                                style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 244, 244, 248),
                                ),),
                                SizedBox(height: 5,),
                                Row(
                                  children: [
                                    Text(FirstName,
                                    style: TextStyle(
                                    fontSize: 27,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 222, 222, 225),
                                    ),),
                                    SizedBox(width: 4,),
                                    Text('أستاذ ',
                                    style: TextStyle(
                                    fontSize: 27,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 222, 222, 225),
                                    ),),
                                  ],
                                ),
                              ],
                            ),
                        
                            
                        Container(
                          width: 60, height: 60,
                          decoration: BoxDecoration(
                            border: Border.all(width: 2,color:Color.fromARGB(255, 208, 208, 208) ),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage('assets/images/rondy-stickers-surprised-head.gif'), 
                              colorFilter: new ColorFilter.mode(Color.fromARGB(255, 245, 217, 1),
                                BlendMode.dstATop),
                            ),
                          ),
                        ),
                      ],
                    ),
                );
              }
              return Container();
            }
          ),
          
          SizedBox(height:90,),
          Expanded(
            child:GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 1,
              crossAxisSpacing: 30,
              mainAxisSpacing: 20,
              children: <Widget>[
                    Container(
                      height: 120,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 231, 239, 220),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[Color.fromARGB(255, 241, 234, 193),Color.fromARGB(255, 253, 246, 204)],
                         // colors: <Color>[Color.fromARGB(255, 235, 238, 231),Color.fromARGB(255, 235, 238, 231)],
                          
                        ),
                        borderRadius: BorderRadius.circular(13),
                        boxShadow: [BoxShadow(
                          color: Color.fromARGB(255, 183, 181, 181),
                          blurRadius: 6.0,
                        )]
                        
                      ),
                      child: Column(
                        children: <Widget>[
                          //SvgPicture.network(url),
                          GestureDetector(
                            onTap: (){
                              Navigator.pushReplacement(context, 
                              MaterialPageRoute(builder: (context) => TestCalender() ));//TutorCalendar()
                            },
                            child: Icon(Icons.calendar_month_outlined, size: 80,
                              color: Color.fromARGB(255, 4, 4, 71)),
                          ),
                          Spacer(),
                          Text(
                           "التقويم",
                           style: TextStyle(
                           fontWeight: FontWeight.w900,
                           fontSize: 20.0,
                           color: Color.fromARGB(255, 4, 4, 71),
                      ),
                  ),
    
                        ],
                      ),
                    ),
       
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 231, 239, 220),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[Color.fromARGB(255, 230, 187, 209),Color.fromARGB(255, 249, 205, 227)],
                          //colors: <Color>[Color.fromARGB(255, 235, 238, 231),Color.fromARGB(255, 235, 238, 231)],
                        ),
                        borderRadius: BorderRadius.circular(13),
                        boxShadow: [BoxShadow(
                          color: Color.fromARGB(255, 193, 190, 190),
                          blurRadius: 6.0,
                        )]
                      ),
                      child: Column(
                        children: <Widget>[
                          //SvgPicture.asset(assetName),
                          GestureDetector(
                            onTap: (){
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TutorAccount() ));
                            },
                            child: Icon(Icons.settings_rounded, size: 90,
                              color: Color.fromARGB(255, 4, 4, 71)),
                          ),
                          Spacer(),
                          Text(
                           "ضبط حسابي",
                           style: TextStyle(
                           fontWeight: FontWeight.w900,
                           fontSize: 20.0,
                           color: Color.fromARGB(255, 4, 4, 71),
                      ),
                  ),
    
                        ],
                      ),
                    ),
       
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 231, 239, 220),
                        gradient: LinearGradient(  
                          begin: Alignment.topCenter, 
                          end: Alignment.bottomCenter,
                          colors: <Color>[Color.fromARGB(255, 180, 217, 172),Color.fromARGB(255, 198, 237, 189)],
                          //colors: <Color>[Color.fromARGB(255, 235, 238, 231),Color.fromARGB(255, 235, 238, 231)],
                        ),
                        borderRadius: BorderRadius.circular(17),
                        boxShadow: [BoxShadow(
                          color: Color.fromARGB(255, 158, 154, 154),
                          blurRadius: 6.0,
                        )]
                      ),
                      child: Column(
                        children: <Widget>[
                          //SvgPicture.asset(assetName),
                          GestureDetector(
                            onTap: (){
                              Navigator.pushReplacement(context,
                               MaterialPageRoute(builder: (context) => AddAppointments() ));
                            },
                            child: Icon(Icons.av_timer_outlined, size: 90,
                              color: Color.fromARGB(255, 4, 4, 71)),
                          ),
                          Spacer(),
                          Text(
                           "اضافة حصص",
                           style: TextStyle(
                           fontWeight: FontWeight.w900,
                           fontSize: 20.0,
                           color: Color.fromARGB(255, 4, 4, 71),
                          ),),
                          ],
                       ),
                    ),


                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 231, 239, 220),
                        gradient: LinearGradient(  
                          begin: Alignment.topCenter, 
                          end: Alignment.bottomCenter,
                          colors: <Color>[Color.fromARGB(255, 212, 187, 167),Color.fromARGB(255, 231, 195, 168),],
                          //colors: <Color>[Color.fromARGB(255, 235, 238, 231),Color.fromARGB(255, 235, 238, 231)],
                        ),
                        borderRadius: BorderRadius.circular(17),
                        boxShadow: [BoxShadow(
                          color: Color.fromARGB(255, 158, 154, 154),
                          blurRadius: 6.0,
                        )]
                      ),
                      child: Column(
                        children: <Widget>[
                          //SvgPicture.asset(assetName),
                          GestureDetector(
                            onTap: (){
                              Navigator.pushReplacement(context,
                               MaterialPageRoute(builder: (context) => ClassesPage() ));
                            },
                            child: Icon(Icons.business_outlined, size: 90,
                              color: Color.fromARGB(255, 4, 4, 71)),
                          ),
                          Spacer(),
                          Text(
                           "حصص المعهد",
                           style: TextStyle(
                           fontWeight: FontWeight.w900,
                           fontSize: 20.0,
                           color: Color.fromARGB(255, 4, 4, 71),
                          ),),
                          ],
                       ),
                    ),

                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 231, 239, 220),
                        gradient: LinearGradient(  
                          begin: Alignment.topCenter, 
                          end: Alignment.bottomCenter,
                          colors: <Color>[Color.fromARGB(255, 183, 214, 226),Color.fromARGB(255, 209, 243, 255)],
                          //colors: <Color>[Color.fromARGB(255, 235, 238, 231),Color.fromARGB(255, 235, 238, 231)],
                        ),
                        borderRadius: BorderRadius.circular(17),
                        boxShadow: [BoxShadow(
                          color: Color.fromARGB(255, 158, 154, 154),
                          blurRadius: 6.0,
                        )]
                      ),
                      child: Column(
                        children: <Widget>[
                          //SvgPicture.asset(assetName),
                          GestureDetector(
                            onTap: (){
                              Navigator.pushReplacement(context, 
                              MaterialPageRoute(builder: (context) => ChatRegTea() ));
                            },
                            child: Icon(Icons.mark_unread_chat_alt, size: 90,
                              color: Color.fromARGB(255, 4, 4, 71)),
                          ),
                          Spacer(),
                          Text(
                           "المحادثات",
                           style: TextStyle(
                           fontWeight: FontWeight.w900,
                           fontSize: 20.0,
                           color: Color.fromARGB(255, 4, 4, 71),
                      ),
                  ),
                  ],
                      ),
                    ),


                   
                  ],
            ), 
            ),
        ],
      ),
      ),
    );
  }
}
// ignore_for_file: unused_import, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:grad_project/Pages/add_appointments.dart';
//import 'package:grad_project/Pages/calender.dart';
import 'package:grad_project/Pages/courses_clases_tutor.dart';
import 'package:grad_project/Pages/tutor_account.dart';
import 'package:grad_project/Pages/tutor_calendar.dart';
import 'package:grad_project/Pages/tutor_homePage.dart';

import '../main.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grad_project/Pages/inbox-student.dart';
import 'package:firebase_auth/firebase_auth.dart';



final _firestore = FirebaseFirestore.instance;
late User signedInUser;
final _auth = FirebaseAuth.instance;
late String TutorAccountt ;
late String TutorID ;
late String TutorEmail;

final users = FirebaseAuth.instance.currentUser;
  final info = FirebaseFirestore.instance
                        .collection("tutors")
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .get()
                        .then((value) => value)
                        .then((value) => value.data());

class TutorNavBar extends StatefulWidget {
  const TutorNavBar({super.key});

  @override
  State<TutorNavBar> createState() => _TutorNavBarState();
}

class _TutorNavBarState extends State<TutorNavBar> {
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
     var UserData = FirebaseFirestore.instance
      .collection("tutors").where('uid', isEqualTo: _auth.currentUser!.uid).snapshots();
      print(_auth.currentUser!.uid);
      //String UserAccount = UserData['Account'];
      /*var UserAccount = FirebaseFirestore.instance
      .collection("users").doc(_auth.currentUser!.uid).get().then((value) => {
        StudentAccount = value.get('Account').toString()
        
      });*/
      
      DocumentSnapshot ds = await FirebaseFirestore.instance.collection('tutors').doc(_auth.currentUser!.uid).get();
      TutorAccountt = ds.get('Account');
      TutorID = ds.get('uid');
      TutorEmail = ds.get('email');
      print(TutorAccountt );
      print(TutorID);
      }
    } catch (e) {
      print(e);
    }
  }
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor:Color.fromARGB(255, 244, 244, 248),
      child: FutureBuilder(
        future: info,
        builder: (context, snapshot){
          if (snapshot.hasData){
            var acc = FirebaseFirestore.instance.collection('tutors')
            .doc(FirebaseAuth.instance.currentUser!.uid).get()
            .then((value) => {
              TutorAccountt = value.get('Account'),
              
              TutorEmail = value.get('email'),
              
            });
            return ListView(
              padding: EdgeInsets.zero,
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text(TutorAccountt,
                  style: TextStyle(
                  color: Color.fromARGB(255, 244, 244, 248),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  ),), 
                  accountEmail: Text(TutorEmail,
                  style: TextStyle(
                  color: Color.fromARGB(255, 244, 244, 248),
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  ),), 
                  currentAccountPicture: CircleAvatar(
                    child: ClipOval(
                      child: Image.asset("assets/images/129664470-teacher-male-avatar-character-vector-illustration-design.png",
                      width: 90, height: 90, fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color:Color.fromARGB(255, 4, 4, 71),
                    image: DecorationImage(
                      image: AssetImage("assets/images/msedge_pxZjLQmGeZ.png"),
                      fit: BoxFit.cover,
                      ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.home,size:35,
                  color: Color.fromARGB(255, 180, 178, 211),),
                  title: Text('الرئيسية',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(255, 4, 4, 71),
                    fontSize: 15
                  ),),
                  onTap: (){
                    Navigator.pushReplacement(
                      context, 
                      MaterialPageRoute(builder: (context) => TutorHomePage()));                        
                  }, 
                ),
                ListTile(
                  leading: Icon(Icons.perm_identity_rounded,size: 35,color:Color.fromARGB(255, 195, 197, 158),),
                  title: Text('حسابي',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(255, 4, 4, 71),
                    fontSize: 15
                  ),),
                  onTap: (){
                    Navigator.pushReplacement(
                      context, 
                      MaterialPageRoute(builder: (context) => TutorAccount()));                        
                  },            
                ),
                
                ListTile(
                  leading: Icon(Icons.calendar_month_outlined,size: 35,color:Color.fromARGB(255, 177, 180, 185),),
                  title: Text('التقويم', 
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(255, 4, 4, 71),
                    fontSize: 15
                  ),),
                  onTap: (){
                    Navigator.pushReplacement(
                      context, 
                      MaterialPageRoute(builder: (context) => TutorCalendar()));                        
                  },            
                ),
          
                ListTile(
                  leading: Icon(Icons.alarm_add_outlined,size: 35,color:Color.fromARGB(255, 186, 150, 149),),
                  title: Text('اضافة مواعيد', 
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(255, 4, 4, 71),
                    fontSize: 15
                  ),),
                  onTap: (){
                    Navigator.pushReplacement(
                      context, 
                      MaterialPageRoute(builder: (context) => AddAppointments()));                        
                  },            
                ),
                ListTile(
                  leading: Icon(Icons.business_outlined,size: 35,
                  color:Color.fromARGB(255, 218, 165, 172),),
                  title: Text('حصص المعهد', 
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(255, 4, 4, 71),
                    fontSize: 15
                  ),),
                  onTap: (){
                    Navigator.pushReplacement(
                      context, 
                      MaterialPageRoute(builder: (context) => ClassesPage()));                        
                  },            
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.logout,size:35,color:Color.fromARGB(255, 42, 33, 84)),
                  title: Text('تسجيل الخروج',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(255, 4, 4, 71),
                    fontSize: 15
                  ),),
                  onTap: (){
                    Navigator.pushReplacement(
                      context, 
                      MaterialPageRoute(builder: (context) => LogIn()));                        
                  },            
                ),
              ],
            );
          }
          return Container();
        }
        
      ),
      
    );
  }
}
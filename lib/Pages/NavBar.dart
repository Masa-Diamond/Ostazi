// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:grad_project/Pages/acoount.dart'; //
import 'package:grad_project/Pages/bookings.dart';
import 'package:grad_project/Pages/chat_reg.dart';
import 'package:grad_project/Pages/courses.dart'; //
import 'package:grad_project/Pages/home.dart'; //
import 'package:grad_project/Pages/inbox-student.dart';
import 'package:grad_project/Pages/search.dart'; //
import 'package:grad_project/Pages/tutors.dart'; //
import 'package:grad_project/main.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grad_project/Pages/inbox-student.dart';
import 'package:firebase_auth/firebase_auth.dart';



final _firestore = FirebaseFirestore.instance;
late User signedInUser;
final _auth = FirebaseAuth.instance;
late String StudentAccount ;
late String StudentID ;
late String StudentEmail;

final users = FirebaseAuth.instance.currentUser;
  final info = FirebaseFirestore.instance
                        .collection("users")
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .get()
                        .then((value) => value)
                        .then((value) => value.data());

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
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
      .collection("users").where('uid', isEqualTo: _auth.currentUser!.uid).snapshots();
      print(_auth.currentUser!.uid);
      //String UserAccount = UserData['Account'];
      /*var UserAccount = FirebaseFirestore.instance
      .collection("users").doc(_auth.currentUser!.uid).get().then((value) => {
        StudentAccount = value.get('Account').toString()
        
      });*/
      
      DocumentSnapshot ds = await FirebaseFirestore.instance.collection('users').doc(_auth.currentUser!.uid).get();
      StudentAccount = ds.get('Account');
      StudentID = ds.get('uid');
      StudentEmail = ds.get('email');
      print(StudentAccount);
      print(StudentID);
      }
    } catch (e) {
      print(e);
    }
  }

  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor:Color.fromARGB(255, 244, 244, 248),//Color.fromARGB(255, 4, 4, 71),
      child: FutureBuilder(
        future: info,
        builder: (context, snapshot){
          if (snapshot.hasData){
            var acc = FirebaseFirestore.instance.collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid).get()
            .then((value) => {
              StudentAccount = value.get('Account'),
              
              StudentEmail = value.get('email'),
              
            });
            return ListView(
              padding: EdgeInsets.zero,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text(StudentAccount,
                  style: TextStyle(
                    color: Color.fromARGB(255, 244, 244, 248),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),), 
                  accountEmail: Text(StudentEmail,
                  style: TextStyle(
                    color: Color.fromARGB(255, 244, 244, 248),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),),       
                  currentAccountPicture: CircleAvatar(
                    child: ClipOval(
                      child: Image.asset("assets/images/bubble-gum-womans-head.gif",
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
                  leading: Icon(Icons.home,size:35,color: Color.fromARGB(255, 243, 214, 127),),
                  title: Text('الرئيسية',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(255, 4, 4, 71),
                    fontSize: 15
                  ),),
                  onTap: (){
                    Navigator.pushReplacement(
                      context, 
                      MaterialPageRoute(builder: (context) => homePage()));                        
                  },            
                ), 
          
                ListTile(
                  leading: Icon(Icons.explore_rounded,size: 35,color:Color.fromARGB(255, 132, 175, 210)),
                  title: Text('البحث',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(255, 4, 4, 71),
                    fontSize: 15
                  ),),
                  onTap: (){
                    Navigator.pushReplacement(
                      context, 
                      MaterialPageRoute(builder: (context) => searchStu()));                        
                  },            
                ),
          
                ListTile(
                  leading: Icon(Icons.perm_identity_rounded,size: 35,color:Color.fromARGB(255, 249, 126, 85),),
                  title: Text('حسابي',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(255, 4, 4, 71),
                    fontSize: 15
                  ),),
                  onTap: (){
                    Navigator.pushReplacement(
                      context, 
                      MaterialPageRoute(builder: (context) => StuProfile()));                        
                  },            
                ),
          
                Divider(),
          
                ListTile(
                  leading: Icon(Icons.school_sharp,size:35,color:Color.fromARGB(255, 213, 149, 226)),
                  title: Text('حصص المعهد',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(255, 4, 4, 71),
                    fontSize: 15
                  ),),
                  onTap: (){
                    Navigator.pushReplacement(
                      context, 
                      MaterialPageRoute(builder: (context) => courses()));                        
                  },            
                ),
          
                ListTile(
                  leading: Icon(Icons.class_,size:35,color:Color.fromARGB(255, 245, 135, 190)),
                  title: Text('أساتذتي',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(255, 4, 4, 71),
                    fontSize: 15
                  ),),
                  onTap: (){
                    Navigator.pushReplacement(
                      context, 
                      MaterialPageRoute(builder: (context) => tutors()));                        
                  },            
                ),
          
                ListTile(
                  leading: Icon(Icons.app_registration,size:35,color: Color.fromARGB(255, 179, 239, 166),),
                  title: Text('الحجوزات',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(255, 4, 4, 71),
                    fontSize: 15
                  ),),
                  onTap: (){
                    Navigator.pushReplacement(
                      context, 
                      MaterialPageRoute(builder: (context) => bookings()));                        
                  },            
                ),
          
                ListTile(
                  leading: Icon(Icons.inbox,size:35,color: Color.fromARGB(255, 156, 159, 210),),
                  title: Text('المحادثات',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(255, 4, 4, 71),
                    fontSize: 15
                  ),),
                  onTap: (){
                    Navigator.pushReplacement(
                      context, 
                      MaterialPageRoute(builder: (context) => ChatReg()));                        
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
        /*ListView(
          padding: EdgeInsets.zero,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(StudentAccount,
              style: TextStyle(
                color: Color.fromARGB(255, 244, 244, 248),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),), 
              accountEmail: Text(StudentEmail,
              style: TextStyle(
                color: Color.fromARGB(255, 244, 244, 248),
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),),       
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  child: Image.asset("assets/images/bubble-gum-womans-head.gif",
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
              leading: Icon(Icons.home,size:35,color: Color.fromARGB(255, 243, 214, 127),),
              title: Text('الرئيسية',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(255, 4, 4, 71),
                fontSize: 15
              ),),
              onTap: (){
                Navigator.pushReplacement(
                  context, 
                  MaterialPageRoute(builder: (context) => homePage()));                        
              },            
            ), 
      
            ListTile(
              leading: Icon(Icons.explore_rounded,size: 35,color:Color.fromARGB(255, 132, 175, 210)),
              title: Text('البحث',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(255, 4, 4, 71),
                fontSize: 15
              ),),
              onTap: (){
                Navigator.pushReplacement(
                  context, 
                  MaterialPageRoute(builder: (context) => searchStu()));                        
              },            
            ),
      
            ListTile(
              leading: Icon(Icons.perm_identity_rounded,size: 35,color:Color.fromARGB(255, 249, 126, 85),),
              title: Text('حسابي',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(255, 4, 4, 71),
                fontSize: 15
              ),),
              onTap: (){
                Navigator.pushReplacement(
                  context, 
                  MaterialPageRoute(builder: (context) => StuProfile()));                        
              },            
            ),
      
            Divider(),
      
            ListTile(
              leading: Icon(Icons.school_sharp,size:35,color:Color.fromARGB(255, 213, 149, 226)),
              title: Text('حصص المعهد',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(255, 4, 4, 71),
                fontSize: 15
              ),),
              onTap: (){
                Navigator.pushReplacement(
                  context, 
                  MaterialPageRoute(builder: (context) => courses()));                        
              },            
            ),
      
            ListTile(
              leading: Icon(Icons.class_,size:35,color:Color.fromARGB(255, 245, 135, 190)),
              title: Text('أساتذتي',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(255, 4, 4, 71),
                fontSize: 15
              ),),
              onTap: (){
                Navigator.pushReplacement(
                  context, 
                  MaterialPageRoute(builder: (context) => tutors()));                        
              },            
            ),
      
            ListTile(
              leading: Icon(Icons.app_registration,size:35,color: Color.fromARGB(255, 179, 239, 166),),
              title: Text('الحجوزات',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(255, 4, 4, 71),
                fontSize: 15
              ),),
              onTap: (){
                Navigator.pushReplacement(
                  context, 
                  MaterialPageRoute(builder: (context) => bookings()));                        
              },            
            ),
      
            ListTile(
              leading: Icon(Icons.inbox,size:35,color: Color.fromARGB(255, 156, 159, 210),),
              title: Text('المحادثات',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(255, 4, 4, 71),
                fontSize: 15
              ),),
              onTap: (){
                Navigator.pushReplacement(
                  context, 
                  MaterialPageRoute(builder: (context) => ChatReg()));                        
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
        ),*/
      ),
    );
  }
}
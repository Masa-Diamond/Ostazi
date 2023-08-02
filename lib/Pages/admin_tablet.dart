// ignore_for_file: unused_import, unused_field, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:grad_project/Pages/adminPeople_class.dart';
import 'package:grad_project/Pages/side_bar_admin.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grad_project/Pages/inbox-student.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firestore = FirebaseFirestore.instance;
late User signedInUser; //this will give us the email

class AdminTablet extends StatefulWidget {
  const AdminTablet({super.key});

  @override
  State<AdminTablet> createState() => _AdminTabletState();
}

class _AdminTabletState extends State<AdminTablet> {
  List selectedIndex = [];
  static List<Managers> managers =[
    Managers("عدنان أحمد", "مدير المعهد", "0597512034"),
    Managers("سالم علي", "نائب المدير", "0598214095"),
    Managers("أنس محمد", "الموارد البشرية", "0562031528"),
    Managers("يزيد غفران", "السكرتير الأول", "0597021350"),
    Managers("عاصم فريد", "السكرتير الثاني", "0590239521"),
  ];

  DateTime _focusDate = DateTime.now();
  @override
  final _auth = FirebaseAuth.instance;
  
  
  String? messageText; // this will give us the message that was sent
  @override
  void initState(){
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser(){
    try {
      final user = _auth.currentUser;
      if (user != null){
      signedInUser = user;
      print(signedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color.fromARGB(255, 244, 244, 248),
      drawer: SideBar(),
      appBar: AppBar(
        iconTheme: IconThemeData(size:30,color: Color.fromARGB(255, 244, 244, 248),//Color.fromARGB(255, 192, 218, 240)
        ),
        backgroundColor: Color.fromARGB(255, 4, 4, 71),
        elevation: 5,
        title:
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 250,height: 100,
               decoration: BoxDecoration(
               image: DecorationImage(
               image: AssetImage("assets/images/logo2.png"),
               fit: BoxFit.fitWidth
           ),),
          ),
        ]),
     ),
      
      body: Column(mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width*0.8,
            height: MediaQuery.of(context).size.height*0.25,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color.fromRGBO(253, 216, 53, 1),
              borderRadius:BorderRadius.circular(20),
            ),
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Column(mainAxisAlignment: MainAxisAlignment.center,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [ 
                    Text.rich(TextSpan(
                      style: TextStyle(
                        color: Color.fromARGB(255, 4, 4, 71),
                        fontSize: 16, fontWeight: FontWeight.w600,
                      ),
                      children:[
                        TextSpan(text: " مرحبا بك"),
                        TextSpan(text: " المعهد العلمي",
                          style: TextStyle(
                          fontWeight: FontWeight.bold)
                        ),
                        TextSpan(text: "في تطبيق أستاذي"),
                      ]
                    )),
                    SizedBox(height: 10,),
                    Text(',يمكنك من متابعة الطلاب و الأساتذه بالاضافة الى اضافة حصص المعهد و الأساتذة الجدد ',
                    style:TextStyle(
                      fontSize: 16, color:Color.fromARGB(255, 4, 4, 71),
                      fontWeight: FontWeight.w400, height: 1.5 
                    ),),
                    Text('!لديك الكثير من العمل و نتمنى لك يوما طيبا',
                    style:TextStyle(
                      fontSize: 16, color:Color.fromARGB(255, 4, 4, 71),
                      fontWeight: FontWeight.w400, height: 1.5 
                    ),),
                    SizedBox(height: 10,),
                  ],
                ),
                Spacer(),
                Container(
                  width: MediaQuery.of(context).size.width*0.15,
                  height: MediaQuery.of(context).size.height*0.1,
                  //color: Color.fromARGB(255, 1, 20, 35),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/msedge_eEnTKJSzhG.png"),
                      fit: BoxFit.cover,
                    )
                  ),
                ),
                ],
                ),
               ),
                //SizedBox(height:120,),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius:BorderRadius.circular(20),
                      color: Colors.white,//Colors.pink[100], 
                    ),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Text('طاقم المعهد العلمي',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              color: Color.fromARGB(255, 4, 4, 71),
                              fontSize:23, fontWeight: FontWeight.bold 
                            ),),
                          ],
                        ),
                        Divider(
                          thickness: 0.5,
                          color: Colors.grey,
                        ),
                       
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: managers.length,
                          itemBuilder: (context,index){
                            return Container(
                              margin: EdgeInsets.only(bottom:15),
                              padding: EdgeInsets.symmetric(horizontal:30,vertical:15),
                              width: MediaQuery.of(context).size.width*0.6,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 249, 246, 228),
                                borderRadius: BorderRadius.all(Radius.circular(15),),
                                border: Border.all(width:1,color: Color.fromARGB(255, 200, 199, 201),)
                              ),
                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text(managers[index].Phone!,
                                    style:TextStyle(
                                    color:Color.fromARGB(255, 1, 1, 41),
                                    fontSize:18, fontWeight: FontWeight.w400
                                  ),),                                 
                                  SizedBox(width:100,),
                                  Text(managers[index].Position!,
                                    style:TextStyle(
                                    color:Color.fromARGB(255, 1, 1, 45),
                                    fontSize:18, fontWeight: FontWeight.w400
                                  ) ,),
                                  SizedBox(width: 170,),
                                  Text(managers[index].FullName!,
                                    style:TextStyle(
                                    color:Color.fromARGB(255, 1, 1, 40),
                                    fontSize:18, fontWeight: FontWeight.w400
                                  ) ,),
                                ],
                              ),
                            );
                          }
                        ),
                      ],
                    ),
                  ),
                ),
              
        ],
      ),
    );
  }
}
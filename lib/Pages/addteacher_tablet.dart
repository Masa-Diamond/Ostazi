// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grad_project/Pages/side_bar_admin.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grad_project/Pages/teachers_desktop.dart';
import 'package:grad_project/Pages/tutors_class.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../model/teachers_model.dart';

final _firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;
late User signedInUser;

class AddTeacherTablet extends StatefulWidget {
  const AddTeacherTablet({super.key});

  @override
  State<AddTeacherTablet> createState() => _AddTeacherTabletState();
}

class _AddTeacherTabletState extends State<AddTeacherTablet> {
  late String email;
  late String password;
  late String FirstName;
  late String LastName;
  late String Account;
  late String Field;
  late String School;
  @override
  final _auth = FirebaseAuth.instance;
  
  
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
        //leading: Icon(Icons.edit),
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
          ],),
      ),

      body: SingleChildScrollView(
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            SizedBox(height:20,),
            Center(
              child: Text("تسجيل أستاذ جديد",
              style:TextStyle(
                color: Color.fromARGB(255, 9, 1, 54),
                fontWeight: FontWeight.bold, fontSize: 30,
              ),),
            ),
            SizedBox(height:25,),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25.0,vertical: 10),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              //color: Colors.black,
              child: Column(crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("الاسم الثاني",
                          style:TextStyle(
                            color:Color.fromARGB(255, 9, 1, 54),
                            fontSize:17, fontWeight:FontWeight.w600,
                          ),),
                          Container(
                            width: MediaQuery.of(context).size.width*0.42,
                            padding: EdgeInsets.only(right: 14), 
                            height:40,
                            margin: EdgeInsets.only(top:13),
                            child: TextField(
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color:Color.fromARGB(255, 9, 1, 54),
                                fontSize:17, fontWeight:FontWeight.w500,  
                              ),
                              decoration: InputDecoration(
                                hintText: "أبو علي",
                                filled: true,
                                fillColor: Color.fromARGB(255, 251, 247, 219),
                                enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(width:2 ,
                                color:Color.fromARGB(255, 4, 4, 71), ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      Column(crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("الاسم الأول",
                          style:TextStyle(
                            color:Color.fromARGB(255, 9, 1, 54),
                            fontSize:17, fontWeight:FontWeight.w600,
                          ),),
                          Container(
                            width: MediaQuery.of(context).size.width*0.42,
                            padding: EdgeInsets.only(right: 14), 
                            height:40,
                            margin: EdgeInsets.only(top:13),
                            //color: Colors.amber[100],
                            child: TextField(
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color:Color.fromARGB(255, 9, 1, 54),
                                fontSize:17, fontWeight:FontWeight.w500,  
                              ),
                              decoration: InputDecoration(
                                hintText: "أحمد",
                                filled: true,
                                fillColor: Color.fromARGB(255, 251, 247, 219),
                                enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(width:2 ,
                                color:Color.fromARGB(255, 4, 4, 71), ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: 20,),
                  Column(crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(mainAxisAlignment: MainAxisAlignment.end,
                       // ignore: prefer_const_literals_to_create_immutables
                       children: [
                        Text("اسم الحساب",
                        style:TextStyle(
                          color:Color.fromARGB(255, 9, 1, 54),
                          fontSize:17, fontWeight:FontWeight.w600,
                        ),),
                        IconButton(onPressed: null, icon:Icon(Icons.account_circle,
                        color:Color.fromARGB(255, 4, 4, 71),size: 15,)),
                        ],
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width*0.7,
                        padding: EdgeInsets.only(right: 14), 
                        height:40,
                        margin: EdgeInsets.only(top:8),
                        child: TextField(
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color:Color.fromARGB(255, 9, 1, 54),
                            fontSize:17, fontWeight:FontWeight.w500,  
                          ),
                          decoration: InputDecoration(
                            hintText: "احمد ابو علي",
                            filled: true,
                            fillColor: Color.fromARGB(255, 251, 247, 219),
                            enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(width:2 ,
                            color:Color.fromARGB(255, 4, 4, 71), ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20,),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(mainAxisAlignment: MainAxisAlignment.end,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Text("التخصص",
                              style:TextStyle(
                                color:Color.fromARGB(255, 9, 1, 54),
                                fontSize:17, fontWeight:FontWeight.w600,
                              ),),
                              IconButton(onPressed: null, icon:Icon(Icons.class_,
                              color:Color.fromARGB(255, 4, 4, 71),size: 15,)),
                            ],
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width*0.42,
                            padding: EdgeInsets.only(right: 14), 
                            height:40,
                            margin: EdgeInsets.only(top:13),
                            child: TextField(
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color:Color.fromARGB(255, 9, 1, 54),
                                fontSize:17, fontWeight:FontWeight.w500,  
                              ),
                              decoration: InputDecoration(
                                hintText: "فيزياء",
                                filled: true,
                                fillColor: Color.fromARGB(255, 251, 247, 219),
                                enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(width:2 ,
                                color:Color.fromARGB(255, 4, 4, 71), ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(mainAxisAlignment: MainAxisAlignment.end,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Text("المدرسة",
                              style:TextStyle(
                                color:Color.fromARGB(255, 9, 1, 54),
                                fontSize:17, fontWeight:FontWeight.w600,
                              ),),
                              IconButton(onPressed: null, icon:Icon(Icons.work,
                              color:Color.fromARGB(255, 4, 4, 71),size: 15,)),
                            ],
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width*0.42,
                            padding: EdgeInsets.only(right: 14), 
                            height:40,
                            margin: EdgeInsets.only(top:13),
                            //color: Colors.amber[100],
                            child: TextField(
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color:Color.fromARGB(255, 9, 1, 54),
                                fontSize:17, fontWeight:FontWeight.w500,  
                              ),
                              decoration: InputDecoration(
                                hintText: "العائشية",
                                filled: true,
                                fillColor: Color.fromARGB(255, 251, 247, 219),
                                enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(width:2 ,
                                color:Color.fromARGB(255, 4, 4, 71), ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: 20,),
                  Column(crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(mainAxisAlignment: MainAxisAlignment.end,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Text("كلمة السر",
                          style:TextStyle(
                            color:Color.fromARGB(255, 9, 1, 54),
                            fontSize:17, fontWeight:FontWeight.w600,
                          ),),
                          IconButton(onPressed: null, icon:Icon(Icons.email,
                          color:Color.fromARGB(255, 4, 4, 71),size: 15,)),
                        ],
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width*0.7,
                        padding: EdgeInsets.only(right: 14), 
                        height:40,
                        margin: EdgeInsets.only(top:8),
                        child: TextField(
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color:Color.fromARGB(255, 9, 1, 54),
                            fontSize:17, fontWeight:FontWeight.w500,  
                          ),
                          decoration: InputDecoration(
                            hintText: " ",
                            filled: true,
                            fillColor: Color.fromARGB(255, 251, 247, 219),
                            enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(width:2 ,
                            color:Color.fromARGB(255, 4, 4, 71), ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          
                  SizedBox(height: 30,),
                  Row(mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () async{
                          try {
                            //if(formkey.currentState!.validate()){
                              final newUser = await _auth.createUserWithEmailAndPassword(
                                              email: email, password: password);
                              FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
                              User? user = _auth.currentUser;
                              TutorrModel tutorrModel = TutorrModel();
                              tutorrModel.email = user!.email;
                              tutorrModel.FirstName = FirstName;
                              tutorrModel.LastName = LastName;
                              tutorrModel.Account = Account;
                              tutorrModel.School = School;
                              tutorrModel.Field = Field;
                              tutorrModel.Uid = user.uid; 
                              await firebaseFirestore.collection("tutors")
                              .add(tutorrModel.toMap());
                              final snackBar = SnackBar(
                                content: Text("لقد تم انشاء الحساب بنجاح ",
                                style: const TextStyle(
                                  fontSize: 28, color: Color.fromARGB(255, 247, 240, 204)
                                ),),
                                backgroundColor: Color.fromARGB(255, 8, 1, 48),
                                duration: const Duration(seconds: 5)
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              //Fluttertoast.showToast(msg: "تم انشاء الحساب بنجاح");
                              Navigator.pushReplacement
                              (context, MaterialPageRoute(
                              builder: (context) => AddTeacherTablet() ));
                              
                            //}
                          } catch (e) {
                            print(e);
                            final snackBar = SnackBar(
                              content: Text("لقد حصل خلل ما "+ e.toString(),
                              style: const TextStyle(
                                fontSize: 28, color: Color.fromARGB(255, 247, 204, 204)
                              ),),
                              backgroundColor: Color.fromARGB(255, 8, 1, 48),
                              duration: const Duration(seconds: 5)
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          }
                        },
                        child: Container(
                        padding: EdgeInsets.all(8),
                        width: MediaQuery.of(context).size.width*0.08,
                        height: MediaQuery.of(context).size.height*0.05,
                        decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(10),
                        // ignore: prefer_const_literals_to_create_immutables
                        boxShadow: [BoxShadow(
                          color: Color.fromARGB(255, 7, 0, 58),
                          spreadRadius:1,blurRadius:8,offset: Offset(4,4)),
                          BoxShadow(
                          color: Color.fromARGB(255, 246, 245, 251),
                          spreadRadius:1,blurRadius:8,offset: Offset(-4,-4))
                          ]
                        ),
                        child: Center(
                          child: Text("تسجيل",
                          style: TextStyle(
                            color: Color.fromARGB(255, 7, 0, 58),
                            fontSize:16, fontWeight: FontWeight.w700,
                          ),
                          ),
                        ),
                        
                        )
                      ),
                    ],
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
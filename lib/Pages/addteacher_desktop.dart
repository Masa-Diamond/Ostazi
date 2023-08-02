// ignore_for_file: unused_import, prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

class AddTeacherDesktop extends StatefulWidget {
  const AddTeacherDesktop({super.key});

  @override
  State<AddTeacherDesktop> createState() => _AddTeacherDesktopState();
}

class _AddTeacherDesktopState extends State<AddTeacherDesktop> {
  final formkey = GlobalKey<FormState>();
  late String email;
  late String password;
  late String FirstName;
  late String LastName;
  late String Account;
  late String Field;
  late String School;
  late String Price;
  late String Rating = '0.0';
  //bool showSpinner = false;
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
      backgroundColor:Color.fromARGB(255, 4, 4, 71),
      body: SafeArea(
        child:Row(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            ////// Side Bar
            Expanded(child: SideBar()),
            ////// Main Body
            Expanded(flex: 4,
            child: Container(
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color:Color.fromARGB(255, 244, 244, 248),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                children: [
                  Row( mainAxisAlignment: MainAxisAlignment.center,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Text("تسجيل أستاذ جديد",
                      style:TextStyle(
                        color: Color.fromARGB(255, 9, 1, 54),
                        fontWeight: FontWeight.bold, fontSize: 30,
                      ),),
                    ], 
                  ),
                  SizedBox(height:10,), 
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 25.0,vertical: 10),
                    width: MediaQuery.of(context).size.width,
                   // height: MediaQuery.of(context).size.height*0.2,
                    padding: EdgeInsets.all(30),
                    child: Form(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(crossAxisAlignment: CrossAxisAlignment.end,
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  Text("الاسم الثاني",
                                  style:TextStyle(
                                    color:Color.fromARGB(255, 9, 1, 54),
                                    fontSize:17, fontWeight:FontWeight.w600,
                                  ),),
                                  Container(
                                    width: MediaQuery.of(context).size.width*0.3,
                                    padding: EdgeInsets.only(right: 14), 
                                    height:40,
                                    margin: EdgeInsets.only(top:13),
                                    child: TextFormField(
                                      textAlign: TextAlign.right,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return ("يجب تعبئة الاسم الأخير");
                                        }
                                        return null;
                                      },
                                        onChanged: (value){
                                            LastName = value;
                                          },
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
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  Text("الاسم الأول",
                                  style:TextStyle(
                                    color:Color.fromARGB(255, 9, 1, 54),
                                    fontSize:17, fontWeight:FontWeight.w600,
                                  ),),
                                  Container(
                                    width: MediaQuery.of(context).size.width*0.3,
                                    padding: EdgeInsets.only(right: 14), 
                                    height:40,
                                    margin: EdgeInsets.only(top:13),
                                    //color: Colors.amber[100],
                                    child: TextFormField(
                                      textAlign: TextAlign.right,
                                      validator: (value) {
                                        RegExp regex = new RegExp(r'^.{3,}$');
                                        if (value!.isEmpty) {
                                          return ("يجب تعبئة الاسم الاول");
                                        }
                                        if (!regex.hasMatch(value)) {
                                          return ("قم بادخال اسم صحيح! على الأقل ثلاثة حروف");
                                        }
                                        return null;
                                      },
                                        onChanged: (value){
                                            FirstName = value;
                                          },
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
                    
                          SizedBox(height:20,),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(crossAxisAlignment: CrossAxisAlignment.end,
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  Row(mainAxisAlignment: MainAxisAlignment.end,
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
                                    width: MediaQuery.of(context).size.width*0.3,
                                    padding: EdgeInsets.only(right: 14), 
                                    height:40,
                                    margin: EdgeInsets.only(top:8),
                                    child: TextFormField(
                                      textAlign: TextAlign.right,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return ("يجب تعبئة اسم الحساب");
                                        }
                                        return null;
                                      },
                                      onChanged: (value){
                                          Account = value;
                                        },
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
                              Column(crossAxisAlignment: CrossAxisAlignment.end,
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  Text("(سعر حصة الخصوصي (الأولية",
                                  style:TextStyle(
                                    color:Color.fromARGB(255, 9, 1, 54),
                                    fontSize:17, fontWeight:FontWeight.w600,
                                  ),),
                                  Container(
                                    width: MediaQuery.of(context).size.width*0.3,
                                    padding: EdgeInsets.only(right: 14), 
                                    height:40,
                                    margin: EdgeInsets.only(top:13),
                                    //color: Colors.amber[100],
                                    child: TextFormField(
                                      textAlign: TextAlign.right,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return ("يجب تعبئةالسعر");
                                        }
                                        return null;
                                      },
                                        onChanged: (value){
                                            Price = value;
                                          },
                                      style: TextStyle(
                                        color:Color.fromARGB(255, 9, 1, 54),
                                        fontSize:17, fontWeight:FontWeight.w500,  
                                      ),
                                      decoration: InputDecoration(
                                        hintText: "100",
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
                          
                          SizedBox(height:10,),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(crossAxisAlignment: CrossAxisAlignment.end,
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  Row(mainAxisAlignment: MainAxisAlignment.end,
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
                                    width: MediaQuery.of(context).size.width*0.3,
                                    padding: EdgeInsets.only(right: 14), 
                                    height:40,
                                    margin: EdgeInsets.only(top:13),
                                    child: TextFormField(
                                      textAlign: TextAlign.right,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return ("يجب تعبئة مجال التخصص");
                                        }
                                        return null;
                                      },
                                      onChanged: (value){
                                          Field = value;
                                        },
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
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  Row(mainAxisAlignment: MainAxisAlignment.end,
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
                                    width: MediaQuery.of(context).size.width*0.3,
                                    padding: EdgeInsets.only(right: 14), 
                                    height:40,
                                    margin: EdgeInsets.only(top:13),
                                    //color: Colors.amber[100],
                                    child: TextFormField(
                                      textAlign: TextAlign.right,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return ("يجب تعبئة مجال  اسم المدرسة");
                                        }
                                        return null;
                                      },
                                      onChanged: (value){
                                          School= value;
                                        },
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
                    
                          SizedBox(height:10,),
                          Column(crossAxisAlignment: CrossAxisAlignment.end,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Row(mainAxisAlignment: MainAxisAlignment.end,
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
                                width: MediaQuery.of(context).size.width*0.4,
                                padding: EdgeInsets.only(right: 14), 
                                height:40,
                                margin: EdgeInsets.only(top:8),
                                child: TextFormField(
                                  obscureText: true,
                                  textAlign: TextAlign.right,
                                    validator: (value) {
                                      RegExp regex = new RegExp(r'^.{6,}$');
                                      if (value!.isEmpty) {
                                        return ("كلمة السر متطلب اساسي");
                                      }
                                      if (!regex.hasMatch(value)) {
                                        return ("قم بادخال كلمة سر مناسبة! على الأقل ستة حروف");
                                      }
                                    },
                                      onChanged: (value){
                                          password = value;
                                        },
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
                    
                          SizedBox(height:10,),
                          Column(crossAxisAlignment: CrossAxisAlignment.end,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Row(mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text("البريد الالكتروني",
                                  style:TextStyle(
                                    color:Color.fromARGB(255, 9, 1, 54),
                                    fontSize:17, fontWeight:FontWeight.w600,
                                  ),),
                                  IconButton(onPressed: null, icon:Icon(Icons.email,
                                  color:Color.fromARGB(255, 4, 4, 71),size: 15,)),
                                ],
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width*0.4,
                                padding: EdgeInsets.only(right: 14), 
                                height:40,
                                margin: EdgeInsets.only(top:8),
                                child: TextFormField(
                                  keyboardType: TextInputType.emailAddress, 
                                  textAlign: TextAlign.right,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return ("الرجاء ادخال البريد الالكتروني");
                                    }
                                    // reg expression for email validation
                                    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                        .hasMatch(value)) {
                                      return ("الرجاء ادخال بريد الكتروني صحيح");
                                    }
                                    return null;
                                  },
                                  onChanged: (value){
                                      email = value;
                                    },
                                  style: TextStyle(
                                    color:Color.fromARGB(255, 9, 1, 54),
                                    fontSize:17, fontWeight:FontWeight.w500,  
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "something@gmail.com",
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
                          
                          
                          Row(mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () async{
                                  //print("here");
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
                                      tutorrModel.Rating = Rating;
                                      tutorrModel.Price = Price;
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
                                      builder: (context) => AddTeacherDesktop() ));
                                      
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
                  ),
                ],
              ),
            ),
            ),
          ],
        ),
      ),
    );
  }
}
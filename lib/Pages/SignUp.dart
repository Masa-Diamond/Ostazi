// ignore_for_file: unused_import, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grad_project/Pages/home.dart';
import 'package:grad_project/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../model/user_model.dart';

final _auth = FirebaseAuth.instance;

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // This widget is the root of your application.
  final formkey = GlobalKey<FormState>();
  String name="";
  late String email;
  late String password;
  late String FirstName;
  late String LastName;
  late String Account;
  late String School;
  late String Grade;
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 244, 244, 248),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SingleChildScrollView(
          child: Column( children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.55,
              decoration: BoxDecoration(
               // color: Color.fromARGB(255, 96, 152, 114),            
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                image: DecorationImage(
                 image: AssetImage('assets/images/signup.png'),
                 fit: BoxFit.cover,
                 
                   ),
              ),
              
      
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25.0),
              // ignore: prefer_const_literals_to_create_immutables
              child: Form(
                key: formkey,
                child: Column(children: <Widget>[
              
                  SizedBox(height: 50.0),
                  TextFormField( 
                    style: TextStyle(fontWeight: FontWeight.w600,color: Color.fromARGB(255, 4, 4, 71),),             
                    textAlign: TextAlign.right,
                    validator: (value) {
                    RegExp regex = new RegExp(r'^.{3,}$');
                    if (value!.isEmpty) {
                      return ("يجب تعبئة الاسم الأول");
                    }
                    if (!regex.hasMatch(value)) {
                      return ("قم بادخال اسم صحيح! على الأقل ثلاثة حروف");
                    }
                    return null;
                  },
                    onChanged: (value){
                        FirstName = value;
                      },
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2,
                        color:Color.fromARGB(255, 4, 4, 71) ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2,
                        color:Color.fromARGB(255, 4, 4, 71), ),
                      ),
                      hintText: 'الاسم الأول',
                    //  prefixIcon: Icon(Icons.person, color: Color.fromARGB(255, 97, 82, 82)),
                     ),
                    /* validator: (value){
                      if(value!.isEmpty || !RegExp(r'^[أ-ي]+$').hasMatch(value)){
                        return "الرجاء ادخال اسم صحيح";
                      }else{
                        return null;
                      }
                     },*/
                  ),
              
              
                  SizedBox(height: 50.0),
                  TextFormField( 
                    style: TextStyle(fontWeight: FontWeight.w600,color: Color.fromARGB(255, 4, 4, 71),),             
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
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2,
                        color:Color.fromARGB(255, 4, 4, 71) ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2,
                        color:Color.fromARGB(255, 4, 4, 71), ),
                      ),
                      hintText: 'الاسم الأخير',
                     // prefixIcon: Icon(Icons.person, color: Color.fromARGB(255, 97, 82, 82)),
                     ),
                  ),
              
                  SizedBox(height: 50.0),
                  TextFormField( 
                    style: TextStyle(fontWeight: FontWeight.w600,color: Color.fromARGB(255, 4, 4, 71),),             
                    textAlign: TextAlign.right,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("يجب تعبئة اسم الحساب الشخصي");
                      }
                      return null;
                    },
                    onChanged: (value){
                        Account = value;
                      },
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2,
                        color:Color.fromARGB(255, 4, 4, 71) ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2,
                        color:Color.fromARGB(255, 4, 4, 71), ),
                      ),
                      hintText: 'اسم الحساب',
                      prefixIcon: Icon(Icons.account_box_rounded, color: Color.fromARGB(255, 4, 4, 71)),
                     ),
                  ),
              
                  SizedBox(height: 50.0),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,  
                    style: TextStyle(fontWeight: FontWeight.w600,color: Color.fromARGB(255, 4, 4, 71),),             
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
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2,
                        color:Color.fromARGB(255, 4, 4, 71) ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2,
                        color:Color.fromARGB(255, 4, 4, 71), ),
                      ),
                      hintText: 'الايميل',
                      prefixIcon: Icon(Icons.email_outlined, color: Color.fromARGB(255, 4, 4, 71)),
                     ),
                  ),
              
                  SizedBox(height: 50.0),
                  TextFormField( 
                    obscureText: true,
                    style: TextStyle(fontWeight: FontWeight.w600,color: Color.fromARGB(255, 4, 4, 71),),             
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
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2,
                        color:Color.fromARGB(255, 4, 4, 71) ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2,
                        color:Color.fromARGB(255, 4, 4, 71), ),
                      ),
                      hintText: 'كلمة السر',
                      prefixIcon: Icon(Icons.lock, color: Color.fromARGB(255, 4, 4, 71)),
                     ),
                  ),
              
                  SizedBox(height: 50.0),
                  TextFormField( 
                    style: TextStyle(fontWeight: FontWeight.w600,color: Color.fromARGB(255, 4, 4, 71),),             
                    textAlign: TextAlign.right,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("يجب تعبئة اسم المدرسة");
                      }
                      return null;
                    },
                    onChanged: (value){
                        School = value;
                      },
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2,
                        color:Color.fromARGB(255, 4, 4, 71) ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2,
                        color:Color.fromARGB(255, 4, 4, 71), ),
                      ),
                      hintText: 'اسم المدرسة',
                      prefixIcon: Icon(Icons.school_rounded, color: Color.fromARGB(255, 4, 4, 71)),
                     ),
                  ),
              
                  SizedBox(height: 50.0),
                  TextFormField( 
                    style: TextStyle(fontWeight: FontWeight.w600,color: Color.fromARGB(255, 4, 4, 71),),             
                    textAlign: TextAlign.right,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("يجب تعبئة الصف");
                      }
                      return null;
                    },
                    onChanged: (value){
                        Grade = value;
                      },
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2,
                        color:Color.fromARGB(255, 4, 4, 71) ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2,
                        color:Color.fromARGB(255, 4, 4, 71), ),
                      ),
                      hintText: 'الصف',
                      prefixIcon: Icon(Icons.class_rounded, color: Color.fromARGB(255, 4, 4, 71)),
                     ),
                  ),
              
                  
              
                  SizedBox(height: 35.0),
                  GestureDetector(
                    onTap: () async{
                      try {
                        if(formkey.currentState!.validate()){
                          final newUser = await _auth.createUserWithEmailAndPassword(
                          email: email, password: password);
                          //.then ((value)) async {
                            FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
                            User? user = _auth.currentUser;
                            UserModel userModel = UserModel();
                            userModel.email = user!.email;
                            userModel.FirstName = FirstName;
                            userModel.LastName = LastName;
                            userModel.Account = Account; 
                            userModel.Uid = user.uid;
                            userModel.School = School;
                            userModel.Grade = Grade;

                            await firebaseFirestore.collection("users").doc(user.uid)
                            .set(userModel.toMap());
                            Fluttertoast.showToast(msg: "تم انشاء الحساب بنجاح");
                          //};
                          // ignore: use_build_context_synchronously
                          Navigator.pushReplacement
                          (context, MaterialPageRoute(
                          builder: (context) => homePage() ));
                          setState(() {
                            showSpinner = false;
                          });
                        }
                          
                      } catch (e) {
                      }
                    },
                    child: Container(
                      height: 50.0,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 3.0,
                          color: Color.fromARGB(255, 4, 4, 71)),
                        //style: OutlineInputBorder.styleFrom(side: BorderSide(width: 3.0),), 
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                            colors: <Color>[Color.fromARGB(255, 232, 231, 246),Color.fromARGB(255, 174, 219, 255)],
                        ),
                        borderRadius: BorderRadius.circular(50.0),
                        
                      ),
                      child: Center(
                        child: Text(
                          'انشاء الحساب',
                          style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0,
                          color: Color.fromARGB(255, 4, 4, 71),
                        ),
                        ),
                        ),
                    ),
                  ),
              
                  SizedBox(height: 35.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    // ignore: prefer_const_literals_to_create_immutables
                    children:[ 
                      GestureDetector(
                        onTap: () async{
                          
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LogIn() ));
                        },
                        child: Text(
                        ' تسجيل الدخول',
                        style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize:18.0,
                              decoration: TextDecoration.underline,
                              color: Color.fromARGB(255, 39, 52, 238),
                            ),
                            ),
                      ),
              
                    SizedBox(width: 10.0),
                    Text(
                      ' لديك حساب بالفعل؟',
                      style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize:18.0,
                            color: Color.fromARGB(255, 4, 4, 71),
                          ),
                    ),
                    
                    ],
                  ),
              
                  SizedBox(height: 35.0),
              
                ],
                ),
              ),
            ),
          ],
      
        
        ),
        
        ),
      ),
      
    );
  }
}
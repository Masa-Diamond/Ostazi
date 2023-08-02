// ignore_for_file: unused_import, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:grad_project/Pages/chat_reg.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'inbox-student.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ChatSignUp extends StatefulWidget {
  const ChatSignUp({super.key});

  @override
  State<ChatSignUp> createState() => _ChatSignUpState();
}

class _ChatSignUpState extends State<ChatSignUp> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 177, 177, 199),
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
              //child: Form(
                //key: formkey,
                child: Column(children: <Widget>[
              
                  SizedBox(height: 50.0),
                  /*TextField( 
                    style: TextStyle(fontWeight: FontWeight.w600,color: Color.fromARGB(255, 4, 4, 71),),             
                    textAlign: TextAlign.right,
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
                  ),*/
              
              
                  /*SizedBox(height: 50.0),
                  TextField( 
                    style: TextStyle(fontWeight: FontWeight.w600,color: Color.fromARGB(255, 4, 4, 71),),             
                    textAlign: TextAlign.right,
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
                  ),*/
              
                  /*SizedBox(height: 50.0),
                  TextField( 
                    style: TextStyle(fontWeight: FontWeight.w600,color: Color.fromARGB(255, 4, 4, 71),),             
                    textAlign: TextAlign.right,
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
                  ),*/
              
                  SizedBox(height: 50.0),
                  TextField(
                    onChanged: (value){
                      email = value;
                    },
                    keyboardType: TextInputType.emailAddress,  
                    style: TextStyle(fontWeight: FontWeight.w600,color: Color.fromARGB(255, 4, 4, 71),),             
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2,
                        color:Color.fromARGB(255, 4, 4, 71) ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2,
                        color:Color.fromARGB(255, 4, 4, 71), ),
                      ),
                      hintText: 'البريد الالكتروني',
                      prefixIcon: Icon(Icons.email_outlined, color: Color.fromARGB(255, 4, 4, 71)),
                     ),
                  ),
              
                  SizedBox(height: 50.0),
                  TextField( 
                    onChanged: (value){
                      password = value;
                    },
                    obscureText: true,
                    style: TextStyle(fontWeight: FontWeight.w600,color: Color.fromARGB(255, 4, 4, 71),),             
                    textAlign: TextAlign.right,
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
              
                  /*SizedBox(height: 50.0),
                  TextField( 
                    style: TextStyle(fontWeight: FontWeight.w600,color: Color.fromARGB(255, 4, 4, 71),),             
                    textAlign: TextAlign.right,
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
                  ),*/
              
                  /*SizedBox(height: 50.0),
                  TextField( 
                    style: TextStyle(fontWeight: FontWeight.w600,color: Color.fromARGB(255, 4, 4, 71),),             
                    textAlign: TextAlign.right,
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
                  ),*/
              
                  
              
                  SizedBox(height: 35.0),
                  GestureDetector(
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
                    onTap: () async{
                     // print(email);
                      //print(password); 
                        setState(() {
                          showSpinner = true;
                        });                   
                        try {
                          final newUser = await _auth.createUserWithEmailAndPassword(
                            email: email, password: password);
                            // ignore: use_build_context_synchronously
                            Navigator.pushReplacement
                            (context, MaterialPageRoute(
                            builder: (context) => ChatStu() ));
                            setState(() {
                              showSpinner = false;
                            }); 
                        } catch (e) {
                          print(e);
                          
                        }
                    },
                  ),
              
                  SizedBox(height: 35.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    // ignore: prefer_const_literals_to_create_immutables
                    children:[ 
                      GestureDetector(
                        onTap: (){
                          Navigator.pushReplacement(context,
                           MaterialPageRoute(builder: (context) => ChatReg() ));
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
              //),
            ),
          ],
      
        
        ),
        
        ),
      ),
    );
  }
}
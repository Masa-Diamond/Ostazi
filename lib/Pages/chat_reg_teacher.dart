// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:grad_project/Pages/chat_signup.dart';
import 'package:grad_project/Pages/inbox-student.dart';

import 'SignUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'chatting.dart';
import 'inbox-teacher.dart';

class ChatRegTea extends StatefulWidget {
  const ChatRegTea({super.key});

  @override
  State<ChatRegTea> createState() => _ChatRegTeaState();
}

class _ChatRegTeaState extends State<ChatRegTea> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 166, 166, 198),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SingleChildScrollView(
          child: Column(children: <Widget> [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: BoxDecoration(
                //color: Color.fromARGB(255, 96, 152, 114),            
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(140),
                  bottomRight: Radius.circular(150),
                ),
                image: DecorationImage(
                 image: AssetImage('assets/images/boylog.png'),
                 fit: BoxFit.cover,
                 // ignore: unnecessary_new
                 colorFilter: new ColorFilter.mode(Color.fromARGB(255, 185, 213, 161).withOpacity(1), BlendMode.dstATop),
                 
                   )
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25.0),
              // ignore: prefer_const_literals_to_create_immutables
              //child: Form(
                //key: formkey,
                child: Column(children: <Widget>[
                  SizedBox(height: 50.0),
                  TextField(
                    keyboardType: TextInputType.emailAddress, 
                    style: TextStyle(fontWeight: FontWeight.w600,color: Color.fromARGB(255, 4, 4, 71),),             
                    textAlign: TextAlign.right,
                    onChanged: (value){
                      email = value;
                    },
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2,
                        color:Color.fromARGB(255, 4, 4, 71), ),
                        
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2,
                        color:Color.fromARGB(255, 4, 4, 71), ),
                      ),
                      hintText: 'اسم المستخدم',
                      prefixIcon: Icon(Icons.person, color: Color.fromARGB(255, 4, 4, 71)),
                     ),
                     
                  ),
                     
                  SizedBox(height: 50.0),
                  TextField(  
                    style: TextStyle(fontWeight: FontWeight.w600,color: Color.fromARGB(255, 4, 4, 71),),              
                    textAlign: TextAlign.right,
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
                     obscureText: true, //hide the text
                  ),
              
                  SizedBox(height: 35.0),
                  
                  GestureDetector(
                    child: InkWell(
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
                            'تسجيل الدخول',
                            style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 20.0,
                            color: Color.fromARGB(255, 4, 4, 71),
                          ),
                          ),
                        ),
                      ),
                      onTap: ()async{
                        //print(email);
                        //print(password);
                        
                        
                        try {
                            final user = await _auth.signInWithEmailAndPassword(
                            email: email, password: password);
                            // ignore: use_build_context_synchronously
                            
                            if (user  != null){
                              // ignore: use_build_context_synchronously
                              Navigator.pushReplacement
                              (context, MaterialPageRoute(
                              builder: (context) => ChatTeacher() ));
                              setState(() {
                                showSpinner = false;
                              }); 
                            }
                        } catch (e) {
                          print(e);
                        }
                        
                        
                      }, 
                    ),
                  ),
              
                  SizedBox(height: 30.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    // ignore: prefer_const_literals_to_create_immutables
                    children:[ 
                      GestureDetector(
                        onTap: (){
                          
                         Navigator.pushReplacement(
                            context, MaterialPageRoute(
                              builder: (context) => ChatSignUp()));
                        },
                        child: Text(
                        '  انشاء حساب جديد',
                        style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize:18.0,
                              decoration: TextDecoration.underline,
                              color: Color.fromARGB(255, 220, 13, 13),
                            ),
                            ),
                      ),
              
                    SizedBox(width: 10.0),
                    Text(
                      ' لا يوجد لديك حساب؟ ',
                      style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize:18.0,
                            color: Color.fromARGB(255, 4, 4, 71),
                          ),
                    ),
                    
                    ],
                  ),
                ]
                ),
              //),
            ),
         
               ]
               ),
         
        ),
      ),
    );
  }
}
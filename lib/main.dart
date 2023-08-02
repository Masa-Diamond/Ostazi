// ignore_for_file: prefer_const_constructors, unused_import, unnecessary_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grad_project/Pages/LogIn_Desktop.dart';
import 'package:grad_project/Pages/Responsive_LogIn.dart';
import 'package:grad_project/Pages/Responsive_admin_homePage.dart';
import 'package:grad_project/Pages/SignUp.dart';
import 'package:grad_project/Pages/admin.dart';
import 'package:grad_project/Pages/chatting.dart';
import 'package:grad_project/Pages/forgot_password.dart';
import 'package:grad_project/Pages/home.dart';
import 'package:grad_project/Pages/introduction.dart';
import 'package:grad_project/Pages/tutor_homePage.dart';
import 'package:grad_project/constants.dart';
// ignore: implementation_imports
import 'package:flutter/src/painting/gradient.dart';
import 'Pages/LogIn_Tablet.dart';
import 'Pages/admin_tablet.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
//import 'firebase_options.dart';
//import 'dart:html';
import 'package:firebase_core/firebase_core.dart';

import 'model/route_names.dart';
import 'model/routes.dart';

final _auth = FirebaseAuth.instance;

Future <void> main() async{ 
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    //name: "flutterweb",
    /*options: FirebaseOptions(
      /*apiKey: "XXX",
      appId: "XXX",
      messagingSenderId: "XXX",  
      projectId: "XXX",*/
      apiKey: "AIzaSyCjia2hM-wz2tM3aELkMFszRCji0OyuelA",
      appId: "1:923388246178:web:2cdb8fd26e44b64bb7bffb",
      messagingSenderId: "923388246178",
      projectId: "austazi",
    ), */   
  );
  runApp(const MyApp()); //(VxState(store: MyStore(), child: MyApp()) );  //const MyApp()
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    // routes: {
    //  "/Home":(context) => LogInDesktop()
    // },
      theme: ThemeData(  
        
        primarySwatch:  Colors.grey, 
        fontFamily: 'Montserrat'

      ),
      //initialRoute: _auth.currentUser != null ? ChattScreen.screeenRout ,
      debugShowCheckedModeBanner: false, 
      home: ResponsiveLogIn(DesktopBody: LogInDesktop(),TabletBody: LogInTablet(),MobileBody:IntroScreen(),), /*FutureBuilder(
       // future: _initialization,
        builder: (context, snapshot) {
          if(snapshot.hasError){print("error");}
          if(snapshot.connectionState == ConnectionState.done){
            return ResponsiveLogIn(DesktopBody: LogInDesktop(),TabletBody: LogInTablet(),MobileBody:IntroScreen(),);
          }
          else {return ResponsiveLogIn(DesktopBody: LogInDesktop(),TabletBody: LogInTablet(),MobileBody:IntroScreen(),);
          }  
        })*/
        );
      //ResponsiveAdmin(DesktopBody: AdminPage(), TabletBody: AdminTablet()),//IntroScreen(),
    
  }
}

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State <LogIn> createState() =>  LogInState();
}

class  LogInState extends State <LogIn> {
  final formkey = GlobalKey<FormState>();
  String name="";
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Color.fromARGB(255, 203, 215, 185)
      //Color.fromARGB(255, 214, 225, 199)
      backgroundColor: Color.fromARGB(255, 244, 244, 248),
      body: 
       SingleChildScrollView (
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
            child: Form(
              key: formkey,
              child: Column(children: <Widget>[
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
                      color:Color.fromARGB(255, 4, 4, 71), ),
                      
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2,
                      color:Color.fromARGB(255, 4, 4, 71), ),
                    ),
                    hintText: 'البريد الالكتروني/اسم المستخدم',
                    prefixIcon: Icon(Icons.person, color: Color.fromARGB(255, 4, 4, 71)),
                   ),
                   
                ),
                   
                SizedBox(height: 50.0),
                TextFormField(  
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
                   obscureText: true,
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
                    onTap: () async{

                      try {
                        if(formkey.currentState!.validate()){
                            User? currentuser;
                            await _auth.signInWithEmailAndPassword(
                              email: email, password: password
                              ).then((fAuth) {
                                currentuser = fAuth.user;
                              });
                            if (currentuser != null){
                              await FirebaseFirestore.instance
                              .collection("users") 
                              .doc(currentuser!.uid)
                              .get().then((snap) {
                                if(snap.exists){
                                  Navigator.pushReplacement
                                  (context, MaterialPageRoute(   
                                  builder: (context) => homePage() ));       
                                }
                                else {
                                  FirebaseFirestore.instance
                                  .collection("tutors") 
                                  .doc(currentuser!.uid)
                                  .get().then((snap){
                                    if(snap.exists){
                                      final snackBar = SnackBar(
                                        content: Text("تم تسجيل الدخول بنجاح ",
                                        style: const TextStyle(
                                          fontSize: 20, color: Color.fromARGB(255, 247, 204, 204)
                                        ),),
                                        backgroundColor: Color.fromARGB(255, 8, 1, 48),
                                        duration: const Duration(seconds: 5)
                                      );
                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                      Navigator.pushReplacement
                                      (context, MaterialPageRoute(   
                                      builder: (context) => TutorHomePage() ));
                                    }
                                  });
                                  }
                                  
                              });
                            }  
                        }
                            
                        } catch (e) {
                          print(e);
                          final snackBar = SnackBar(
                            content: Text("!كلمة المرور أو البريد الالكتروني غير صحيحين",
                            style: const TextStyle(
                              fontSize: 20, color: Color.fromARGB(255, 247, 204, 204)
                            ),),
                            backgroundColor: Color.fromARGB(255, 8, 1, 48),
                            duration: const Duration(seconds: 5)
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                    }, 
                  ),
                ),
            
                SizedBox(height: 30.0),
                Column(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: (){
                        
                        Navigator.pushReplacement(
                          context, MaterialPageRoute(
                            builder: (context) => ForgotPassEmail()));
                      },
                      child: Text(
                      '  هل نسيت كلمة المرور؟',
                      style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize:18.0,
                            decoration: TextDecoration.underline,
                            color: Color.fromARGB(255, 2, 2, 109),
                          ),
                          ),
                    ),
                    SizedBox(height: 7,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      // ignore: prefer_const_literals_to_create_immutables
                      children:[ 
                        GestureDetector(
                          onTap: (){
                            
                           Navigator.pushReplacement(
                              context, MaterialPageRoute(
                                builder: (context) => SignUp()));
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
                  ],
                ),
              ]
              ),
            ),
          ),
       
             ]
             ),
       
       ),
    );
  }
}


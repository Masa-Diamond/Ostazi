// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grad_project/Pages/Responsive_admin_homePage.dart';
import 'package:grad_project/Pages/admin.dart';
import 'package:grad_project/Pages/admin_tablet.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';


final _auth = FirebaseAuth.instance; 

class LogInDesktop extends StatefulWidget {
  const LogInDesktop({super.key});
  static const String route = '/LogInAdmin';
  @override
  State<LogInDesktop> createState() => _LogInDesktopState();
}

class _LogInDesktopState extends State<LogInDesktop> {
  final formkey = GlobalKey<FormState>();
  String name="";
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 244, 244, 248),
      body: SingleChildScrollView(
        child: Form(
          child: Center(
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width*0.4,
                  height: MediaQuery.of(context).size.height*0.8,
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
                  width: MediaQuery.of(context).size.width*0.5,
                  //key: formkey,
                  child: Column(
                    children: [
                      SizedBox(height: 50.0),
                      TextFormField( 
                        style: TextStyle(fontWeight: FontWeight.w600,color: Color.fromARGB(255, 4, 4, 71),),             
                        textAlign: TextAlign.right,
                            /*  validator: (value) {
                            if (value!.isEmpty) {
                              return ("الرجاء ادخال البريد الالكتروني");
                            }
                            // reg expression for email validation
                            if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                .hasMatch(value)) {
                              return ("الرجاء ادخال بريد الكتروني صحيح");
                            }
                            return null;
                          },*/
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
                          hintText: 'البريد الالكتروني',
                          prefixIcon: Icon(Icons.person, color: Color.fromARGB(255, 4, 4, 71)),
                        ),
                        
                      ),
                        
                      SizedBox(height: 50.0),
                      TextFormField(  
                        style: TextStyle(fontWeight: FontWeight.w600,color: Color.fromARGB(255, 4, 4, 71),),              
                        textAlign: TextAlign.right,
                        /*validator: (value) {
                          RegExp regex = new RegExp(r'^.{6,}$');
                          if (value!.isEmpty) {
                            return ("كلمة السر متطلب اساسي");
                          }
                          if (!regex.hasMatch(value)) {
                            return ("قم بادخال كلمة سر مناسبة! على الأقل ستة حروف");
                          }
                        },*/
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
                                color: Color.fromARGB(255, 4, 4, 71),),
                              ),
                            ),
                          ),
                          onTap: () async{
                            
                            try {
                                User? currentAdmin;
                                await _auth.signInWithEmailAndPassword(
                                  email: email, password: password
                                  ).then((fAuth) {
                                    currentAdmin = fAuth.user;
                                  });
                                if (currentAdmin != null){
                                  await FirebaseFirestore.instance
                                  .collection("admin") 
                                  .doc(currentAdmin!.uid)
                                  .get().then((snap) {
                                    if(snap.exists){
                                     // Navigator.of(context).pushNamed(AdminPage().route);
                                      Navigator.pushReplacement
                                      (context, MaterialPageRoute(
                                        builder: (context) =>
                                         ResponsiveAdmin(DesktopBody: AdminPage()
                                         ,TabletBody: AdminTablet(),) ));       
                                    }
                                     
                                  });
                                }  
                              } catch (e) {
                                Fluttertoast.showToast(msg: e!.toString());
                                print(e);
                              }
                          },
                         /* onTap: (){
                            Navigator.pushReplacement
                            (context, MaterialPageRoute(
                              builder: (context) => ResponsiveAdmin(DesktopBody: AdminPage(),TabletBody: AdminTablet(),) ));
                            
                          },*/
                        ),
                      ),
        
                      SizedBox(height: 60.0),
                      /*Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: (){
                              
                            Navigator.pushReplacement(
                                context, MaterialPageRoute(
                                  builder: (context) => AdminPage()));
                            },
                            child: Text('  انشاء حساب جديد',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize:18.0,
                                  decoration: TextDecoration.underline,
                                  color: Color.fromARGB(255, 220, 13, 13),),
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
                      ),*/
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    
    );
  }
}
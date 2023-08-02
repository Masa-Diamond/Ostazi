// ignore_for_file: unused_import, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, unnecessary_new

import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:grad_project/Pages/home.dart';
import 'package:grad_project/Pages/search.dart';

import '../model/user_model.dart';
import 'NavBar.dart';
//import 'package:grad_project/Pages/NavBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grad_project/Pages/inbox-student.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firestore = FirebaseFirestore.instance;
late User signedInUser;

class StuProfile extends StatefulWidget {
  const StuProfile({super.key});

  @override
  
  State<StuProfile> createState() => _StuProfileState();
}

class _StuProfileState extends State<StuProfile> {
  //int index=1;
  late String Account;
  late String email;
  late String FirstName;
  late String LastName;
  late String School;
  late String Grade;

  late String UpdatedAccount;
  late String Updatedemail;
  late String UpdatedFirstName;
  late String UpdatedLastName;
  late String UpdatedSchool;
  late String UpdatedGrade;
  @override
  final _auth = FirebaseAuth.instance;
  final users = FirebaseAuth.instance.currentUser;
  final info = FirebaseFirestore.instance
                        .collection("users")
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .get()
                        .then((value) => value)
                        .then((value) => value.data());
  
                       
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
      DocumentSnapshot ds = await FirebaseFirestore.instance.collection('users').doc(_auth.currentUser!.uid).get();
      Account = ds.get('Account');
      print(Account);
      FirstName = ds.get('FirstName');
      print(FirstName);
      LastName = ds.get('LastName');
      print(LastName);
      School = ds.get('School');
      print(School);
      Grade = ds.get('Grade');
      print(Grade);
      email = signedInUser.email.toString();
      print(email);

      FirebaseFirestore.instance
            .collection('users')
            .doc(_auth.currentUser!.uid)
            .snapshots().listen((userData) { 
              setState(() {
                Account = userData.data()!['Account'];
              });
            });
      
      }
    } catch (e) {
      print(e);
    }
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 235, 238, 231),
      drawer: NavBar(),
      appBar: AppBar(   
        iconTheme: IconThemeData(size:30,color: Color.fromARGB(255, 192, 218, 240)),              
        backgroundColor: Color.fromARGB(255, 4, 4, 71),
        title:
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
               image: DecorationImage(
               image: AssetImage("assets/images/loogo.png"),
               fit: BoxFit.fitWidth,
           ),
          ),
            ),
            Center(
              child: Text('تعديل الملف الشخصي',
              //textAlign: Alignment.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize:20.0,
                color:Color.fromARGB(255, 244, 244, 248),
              ),
              ),
            ),
          ],
        ),
      ),

   

      body:  
       Container(
        
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/msedge_pxZjLQmGeZ.png"),
            //colorFilter: new ColorFilter.mode(Color.fromARGB(255, 4, 4, 71).withOpacity(0.5), BlendMode.dstATop),
            fit: BoxFit.cover,
          ),
        ),
         child: Container(
            padding: EdgeInsets.all(20),
            child: 
            GestureDetector(
              onTap: (){
                FocusScope.of(context).unfocus();
              },
              child: ListView(
                children: [
                  Center(
                    child: Stack(
                      children: [
                         Container(
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                              border: Border.all(width: 4,color:Color.fromARGB(255, 208, 208, 208) ),
                              boxShadow: [
                                BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  color: Color.fromARGB(255, 208, 208, 208),
                                ),
                                     
                              ],
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage('assets/images/bubble-gum-womans-head.gif'),
                                fit: BoxFit.cover,
                                colorFilter: new ColorFilter.mode(Color.fromARGB(255, 245, 249, 146),
                                 BlendMode.dstATop),
                               // ignore: unnecessary_new
                               //colorFilter: new ColorFilter.mode(Color.fromARGB(255, 185, 213, 161).withOpacity(1), BlendMode.dstATop),
                                             
                                        ),
                                        ),
                            ),
                        
                         Positioned(
                          bottom: 0,
                          //right: 0,
                          left:0 ,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 4,
                                color: Color.fromARGB(255, 4, 4, 71),
                              ),
                              color: Color.fromARGB(255, 246, 249, 173),
                            ),
                            child: Icon(
                              Icons.edit,
                              color:Color.fromARGB(255, 4, 4, 71) ,
                            ),
           
                         ),
                         ), 
                        
                      ],
                    ),
                  ),
             
                  SizedBox(height: 40),
                  SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        FutureBuilder(
                          future: info,
                          builder: (context, snapshot){
                            /*if(snapshot.hasData){
                              snapshot.connectionState == ConnectionState.done
                            }*/
                            if (snapshot.hasData){
                              var acc = FirebaseFirestore.instance.collection('users')
                              .doc(FirebaseAuth.instance.currentUser!.uid).get()
                              .then((value) => {
                                Account = value.get('Account'),
                                FirstName = value.get('FirstName'),
                                LastName = value.get('LastName'),
                                School = value.get('School'),
                                Grade = value.get('Grade'),
                                email = value.get('email'),
                                
                              });
                              
                              return Container(
                                margin: EdgeInsets.symmetric(horizontal: 0.7),
                                child: Column(
                                  children: [
                                    SizedBox(height: 50.0),
                                    TextField(   
                                        onChanged: (value) {
                                          UpdatedAccount = value;
                                        },                                                  
                                        textAlign: TextAlign.right,
                                        decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(width: 2,
                                        color:Color.fromARGB(255, 208, 208, 208) ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(width: 2,
                                        color:Color.fromARGB(255, 208, 208, 208), ),
                                      ),
                                      contentPadding: EdgeInsets.all(15),
                                      labelText: "الحساب الشخصي",
                                      floatingLabelBehavior: FloatingLabelBehavior.always,
                                      labelStyle: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 30,
                                        color: Color.fromARGB(255, 208, 208, 208),
                                      ),
                                      hintText: Account,
                                      hintStyle: TextStyle(
                                        color: Color.fromARGB(255, 208, 208, 208),
                                      ),
                                      
                                      prefixIcon: Icon(Icons.person, color: Color.fromARGB(255, 245, 211, 156)),
                                      ),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize:20 ,
                                        color: Color.fromARGB(255, 208, 208, 208),
                                        ),
                                    ),
              
                                    SizedBox(height: 40.0),
                                    TextField( 
                                        onChanged: (value) {
                                          Updatedemail = value;
                                        },
                                        style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20,
                                        color: Color.fromARGB(255, 208, 208, 208),),             
                                        textAlign: TextAlign.right,
                                        decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(width: 2,
                                        color:Color.fromARGB(255, 208, 208, 208) ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(width: 2,
                                        color:Color.fromARGB(255, 208, 208, 208), ),
                                      ),
                                      contentPadding: EdgeInsets.all(15),
                                      labelText: "البريد الالكتروني",
                                      floatingLabelBehavior: FloatingLabelBehavior.always,
                                      labelStyle: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 30,
                                        color: Color.fromARGB(255, 208, 208, 208),
                                      ),
                                      hintText: email,
                                      hintStyle: TextStyle(
                                        color: Color.fromARGB(255, 208, 208, 208),
                                        //fontWeight: FontWeight.w600,
                                      ),
                                      
                                      prefixIcon: Icon(Icons.email_outlined, color: Color.fromARGB(255, 245, 211, 156)),
                                      ),
                                    ),
              
                                    SizedBox(height: 40.0),
                                    TextField( 
                                      obscureText: true,
                                        style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20,
                                        color: Color.fromARGB(255, 208, 208, 208),),             
                                        textAlign: TextAlign.right,
                                        decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(width: 2,
                                        color:Color.fromARGB(255, 208, 208, 208) ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(width: 2,
                                        color:Color.fromARGB(255, 208, 208, 208), ),
                                      ),
                                      contentPadding: EdgeInsets.all(15),
                                      labelText: "كلمة السر",
                                      floatingLabelBehavior: FloatingLabelBehavior.always,
                                      labelStyle: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 30,
                                        color: Color.fromARGB(255, 208, 208, 208),
                                      ),
                                      hintText: '********',
                                      hintStyle: TextStyle(
                                        color: Color.fromARGB(255, 208, 208, 208),
                                        //fontWeight: FontWeight.w600,
                                      ),
                                      
                                      prefixIcon: Icon(Icons.password_outlined, color: Color.fromARGB(255, 245, 211, 156)),
                                      ),
                                    ),
              
                                    SizedBox(height: 40),
                                    TextField( 
                                        onChanged: (value) {
                                          UpdatedFirstName = value;
                                        },
                                        style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20,
                                        color: Color.fromARGB(255, 208, 208, 208),),             
                                        textAlign: TextAlign.right,
                                        decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(width: 2,
                                        color:Color.fromARGB(255, 208, 208, 208) ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(width: 2,
                                        color:Color.fromARGB(255, 208, 208, 208), ),
                                      ),
                                      contentPadding: EdgeInsets.all(15),
                                      labelText: "الاسم الأول",
                                      floatingLabelBehavior: FloatingLabelBehavior.always,
                                      labelStyle: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 30,
                                        color: Color.fromARGB(255, 208, 208, 208),
                                      ),
                                      hintText: FirstName,
                                      hintStyle: TextStyle(
                                        color: Color.fromARGB(255, 208, 208, 208),
                                        //fontWeight: FontWeight.w600,
                                      ),
                                      
                                      prefixIcon: Icon(Icons.person, color: Color.fromARGB(255, 245, 211, 156)),
                                      ),
                                    ),
              
                                    SizedBox(height: 40.0),
       
                                    TextField( 
                                        onChanged: (value) {
                                          UpdatedLastName = value;
                                        },
                                        style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20,
                                        color: Color.fromARGB(255, 208, 208, 208),),             
                                        textAlign: TextAlign.right,
                                        decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(width: 2,
                                        color:Color.fromARGB(255, 208, 208, 208) ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(width: 2,
                                          color:Color.fromARGB(255, 208, 208, 208), ),
                                      ),
                                      contentPadding: EdgeInsets.all(15),
                                      labelText: "الاسم الأخير",
                                      floatingLabelBehavior: FloatingLabelBehavior.always,
                                      labelStyle: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 30,
                                        color: Color.fromARGB(255, 208, 208, 208),
                                      ),
                                      hintText: LastName,
                                      hintStyle: TextStyle(
                                        color: Color.fromARGB(255, 208, 208, 208),
                                        //fontWeight: FontWeight.w600,
                                      ),
                                      
                                        prefixIcon: Icon(Icons.person, color: Color.fromARGB(255, 245, 211, 156)),
                                      ),
                                    ),
              
                                    SizedBox(height: 40.0),
                                    TextField( 
                                        onChanged: (value) {
                                          UpdatedSchool = value;
                                        },
                                        style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20,
                                        color: Color.fromARGB(255, 208, 208, 208),),             
                                        textAlign: TextAlign.right,
                                        decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(width: 2,
                                        color:Color.fromARGB(255, 208, 208, 208) ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(width: 2,
                                        color:Color.fromARGB(255, 208, 208, 208), ),
                                      ),
                                      contentPadding: EdgeInsets.all(15),
                                      labelText: "اسم المدرسة",
                                      floatingLabelBehavior: FloatingLabelBehavior.always,
                                      labelStyle: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 30,
                                        color: Color.fromARGB(255, 208, 208, 208),
                                      ),
                                      hintText: School,
                                      hintStyle: TextStyle(
                                        color: Color.fromARGB(255, 208, 208, 208),
                                        //fontWeight: FontWeight.w600,
                                      ),
                                      
                                      prefixIcon: Icon(Icons.school_outlined, color: Color.fromARGB(255, 245, 211, 156)),
                                      ),
                                    ),
              
                                    SizedBox(height: 40.0),
       
                                    TextField( 
                                        onChanged: (value) {
                                          UpdatedGrade = value;
                                        },
                                        style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20,
                                        color: Color.fromARGB(255, 208, 208, 208),),             
                                        textAlign: TextAlign.right,
                                        decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(width: 2,
                                        color:Color.fromARGB(255, 208, 208, 208) ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(width: 2,
                                        color:Color.fromARGB(255, 208, 208, 208), ),
                                      ),
                                      contentPadding: EdgeInsets.all(15),
                                      labelText: "الصف",
                                      floatingLabelBehavior: FloatingLabelBehavior.always,
                                      labelStyle: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 30,
                                        color: Color.fromARGB(255, 208, 208, 208),
                                      ),
                                      hintText: Grade,
                                      hintStyle: TextStyle(
                                        color: Color.fromARGB(255, 208, 208, 208),
                                        //fontWeight: FontWeight.w600,
                                      ),
                                      
                                      prefixIcon: Icon(Icons.class_outlined, color: Color.fromARGB(255, 245, 211, 156)),
                                      ),
                                    ),
              
                                    SizedBox(height: 50.0),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        OutlinedButton(
                                          onPressed:(){
                                            Navigator.pushReplacement
                                            (context, MaterialPageRoute(
                                            builder: (context) => StuProfile() ));
                                          } ,
                                          child: Text("الغاء",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w900,
                                            letterSpacing: 2,
                                            color: Color.fromARGB(255, 245, 211, 156),
                                          ),
                                          ),
                                          style: OutlinedButton.styleFrom(
                                            //primary: Color.fromARGB(255, 208, 208, 208),
                                            side: BorderSide(width: 4,color: Color.fromARGB(255, 245, 211, 156)),
                                            padding: EdgeInsets.symmetric(horizontal: 50,vertical: 8),
                                            //shape: BeveledRectangleBorder(
                                            // borderRadius: BorderRadius.circular(10),
                                            //border: Border.all()
                                            
                                          //),
                                          ),
                                        
                                        ),

                                        //SizedBox(width: 30),

                                        ElevatedButton(
                                          onPressed: ()async{
                                            print(UpdatedAccount); print(UpdatedFirstName);
                                            print(UpdatedLastName);
                                            print(Updatedemail); print(UpdatedSchool); 
                                            print(UpdatedGrade);
                                            FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
                                            User? user = _auth.currentUser;
                                            UserModel userModel = UserModel();
                                            userModel.email = user!.email;
                                            userModel.FirstName = UpdatedFirstName;
                                            userModel.LastName = UpdatedLastName;
                                            userModel.Account = UpdatedAccount; 
                                            userModel.Uid = user.uid;
                                            userModel.School = UpdatedSchool;
                                            userModel.Grade = UpdatedGrade;
                                            print(userModel.LastName);
                                            firebaseFirestore.collection("users")
                                            .doc( _auth.currentUser!.uid).set(userModel.toMap());
                                            final snackBar = SnackBar(
                                              content: Text("تم التعديل ",
                                              style: const TextStyle(
                                                fontSize: 20, color: Color.fromARGB(255, 247, 204, 204)
                                              ),),
                                              backgroundColor: Color.fromARGB(255, 8, 1, 48),
                                              duration: const Duration(seconds: 5)
                                            );
                                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                            Navigator.pushReplacement
                                            (context, MaterialPageRoute(
                                            builder: (context) => StuProfile() ));
                                          },
                                        child: Text("حفظ",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w900,
                                            letterSpacing: 2,
                                            color: Color.fromARGB(255, 4, 4, 71),
                                          ),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            //primary: Color.fromARGB(255, 232, 216, 157),
                                            primary: Color.fromARGB(255, 245, 211, 156),

                                            padding: EdgeInsets.symmetric(horizontal: 50,vertical: 8),
                                          ),
                                          ),
                                      ],
                                    ),
                                    SizedBox(height: 15,),
                                  ]
                                ),
                              );
                            }
                            return CircularProgressIndicator();
                          }
                        ),
                        
                        
                        
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
       ),
      



      bottomNavigationBar: 
         CurvedNavigationBar(
          index: 2,
          buttonBackgroundColor: Color.fromARGB(255, 243, 245, 184),//Color.fromARGB(255, 245, 211, 156),
          backgroundColor: Color.fromARGB(255, 4, 4, 71), 
          color: Color.fromARGB(255, 229, 230, 201),//Color.fromARGB(255, 245, 211, 156),
          animationDuration: Duration(milliseconds: 300),
          animationCurve: Curves.easeInOut,
          items: [
            GestureDetector(
              onTap: (){ 
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => homePage() ));
                    },
              child: Icon(Icons.home_filled, size: 40, 
              color:Color.fromARGB(255, 4, 4, 71),)
              ),

            GestureDetector(
              onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => searchStu() ));
                    },
              child: Icon(Icons.explore_rounded, size: 40, 
              color:Color.fromARGB(255, 4, 4, 71),)
              ),
               
              Icon(Icons.perm_identity, size: 40, 
              color:Color.fromARGB(255, 4, 4, 71),
              )              
          ],      
        ),
    );
  }
}



// ignore_for_file: unused_import, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:grad_project/Pages/TutorNavBar.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grad_project/Pages/inbox-student.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/teachers_model.dart';

final _firestore = FirebaseFirestore.instance;
late User signedInUser;

class TutorAccount extends StatefulWidget {
  const TutorAccount({super.key});

  @override
  State<TutorAccount> createState() => _TutorAccountState();
}

class _TutorAccountState extends State<TutorAccount> {
  double review =4.3;

  late String Account;
  late String email;
  late String FirstName;
  late String LastName;
  late String School;
  late String Field;
  late String Rating;
  late String Price;

  late String UpdatedAccount;
  late String Updatedemail;
  late String UpdatedFirstName;
  late String UpdatedLastName;
  late String UpdatedSchool;
  late String UpdatedField;
  late String UpdatedRating;
  late String UpdatedPrice;
  @override
  final _auth = FirebaseAuth.instance;
  final users = FirebaseAuth.instance.currentUser;
  final info = FirebaseFirestore.instance
                        .collection("tutors")
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
      .collection("tutors").where('uid', isEqualTo: _auth.currentUser!.uid).snapshots();
      print(_auth.currentUser!.uid);
      
      //String UserAccount = UserData['Account'];
      DocumentSnapshot ds = await FirebaseFirestore.instance.collection('tutors').doc(_auth.currentUser!.uid).get();
      Account = ds.get('Account'); print(Account);
      FirstName = ds.get('FirstName'); print(FirstName);
      LastName = ds.get('LastName'); print(LastName);
      School = ds.get('School'); print(School);
      Field = ds.get('Field'); print(Field);
      Price = ds.get('Price'); print(Price);
      Rating = ds.get('Rating'); print(Rating);
      email = signedInUser.email.toString(); print(email);

      FirebaseFirestore.instance
            .collection('tutors')
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
      backgroundColor: Color.fromARGB(255, 244, 244, 248),//Color.fromARGB(255, 254, 227, 237),
      drawer: TutorNavBar(),
      appBar: AppBar(
        iconTheme: IconThemeData(size:30,color: Color.fromARGB(255, 244, 244, 248),//Color.fromARGB(255, 192, 218, 240)
        ),
        backgroundColor: Color.fromARGB(255, 4, 4, 71),
        //leading: Icon(Icons.edit),
        title:
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
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

      body: //SingleChildScrollView(
        //child: 
        FutureBuilder(
          future: info,
          builder: (context, snapshot){
            if (snapshot.hasData){
              var acc = FirebaseFirestore.instance.collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid).get()
              .then((value) => {
                Account = value.get('Account'),
                FirstName = value.get('FirstName'),
                LastName = value.get('LastName'),
                School = value.get('School'),
                Field = value.get('Field'),
                Rating = value.get('Rating'),
                Price = value.get('Price'),
                email = value.get('email'),
                
              });
              return Column(
                children: <Widget> [
                  Container(
                    padding: EdgeInsets.all(5),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.36,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 4, 4, 71),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(60),
                        bottomRight: Radius.circular(60),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        
                        Row(
                          children: [
                            Column(
                              children: [
                                SizedBox(height:70,),
                                  Row(
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: [
                                        SizedBox(width:25,),
                                        Text(Account,
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(255, 222, 222, 225),
                                        ),),
                                        SizedBox(width: 2,),
                                        Text(':الأستاذ/ة -',
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(255, 222, 222, 225),
                                        ),), 
                                    ],
                                  ),
                                  SizedBox(height:25,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: [
                                      SizedBox(width:130,),
                                      Text(Field,
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(255, 199, 199, 202),
                                        ),),
                                        SizedBox(width: 2,),
                                        Text('-',
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(255, 199, 199, 202),
                                        ),),
                                    ],
                                  ),
                                  SizedBox(height:20,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(width:50,),
                                      Text(Rating,
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 235, 235, 237),
                                        fontSize: 25,fontWeight: FontWeight.bold, 
                                      ),),
                                      SizedBox(width:10,),
                                      Icon(Icons.star_border_purple500_rounded,size:22,color: Colors.amber),
                                      Icon(Icons.star_border_purple500_rounded,size:22,color: Colors.amber),
                                      Icon(Icons.star_border_purple500_rounded,size:22,color: Colors.amber),
                                      Icon(Icons.star_border_purple500_rounded,size:22,color: Colors.amber),
                                      Icon(Icons.star_border_purple500_rounded,size:22,color: Colors.amber),
                                    ],
                                  ),
                              ],
                            ),
                            Container(//padding: EdgeInsets.all(10),
                              margin: EdgeInsets.only(right:10,bottom: 10),
                              width: 125, height: 190,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                border: Border.all(width: 2,color:Color.fromARGB(255, 247, 244, 244) ),
                                image: DecorationImage(
                                  image: AssetImage("assets/images/msedge_tJspUHocpV.png"),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  //SizedBox(height: 20,),
                  Expanded(child: SingleChildScrollView(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      padding: EdgeInsets.all(30),
                      color: Color.fromARGB(255, 244, 244, 248),
                      child: Column(children: <Widget>[
                        
                        SizedBox(height: 20.0),
                        TextField(
                          onChanged: (value) {
                            UpdatedAccount = value;
                          },
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width:1 ,
                            color:Color.fromARGB(255, 4, 4, 71), ),
                            ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 1,
                            color:Color.fromARGB(255, 4, 4, 71), ),
                            ),
                          labelText: "الحساب الشخصي",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelStyle: TextStyle(color:Color.fromARGB(255, 4, 4, 71),
                          fontSize:20, fontWeight: FontWeight.w700),
                          hintText: Account,
                          hintStyle: TextStyle(color: Color.fromARGB(255, 57, 57, 64),
                          fontWeight: FontWeight.w700),
                          prefixIcon: Icon(Icons.perm_identity_rounded, color:Color.fromARGB(255, 4, 4, 71),),
                          ),
                          style: TextStyle(color:Color.fromARGB(255, 4, 4, 71),
                          fontSize:18, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 40.0),
                        TextField(
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width:1 ,
                            color:Color.fromARGB(255, 4, 4, 71), ),
                            ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 1,
                            color:Color.fromARGB(255, 4, 4, 71), ),
                            ),
                          labelText: "كلمة المرور",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelStyle: TextStyle(color:Color.fromARGB(255, 4, 4, 71),
                          fontSize:20, fontWeight: FontWeight.w700),
                          hintText: '**********',
                          hintStyle: TextStyle(color: Color.fromARGB(255, 57, 57, 64),
                          fontWeight: FontWeight.w700),
                          prefixIcon: Icon(Icons.password, color:Color.fromARGB(255, 4, 4, 71),),
                          ),
                          style: TextStyle(color:Color.fromARGB(255, 4, 4, 71),
                          fontSize:18, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 40.0),
                        TextField(
                          onChanged: (value) {
                            Updatedemail= value;
                          },
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width:1 ,
                            color:Color.fromARGB(255, 4, 4, 71), ),
                            ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 1,
                            color:Color.fromARGB(255, 4, 4, 71), ),
                            ),
                          labelText: "البريد الالكتروني",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelStyle: TextStyle(color:Color.fromARGB(255, 4, 4, 71),
                          fontSize:20, fontWeight: FontWeight.w700),
                          hintText: email,
                          hintStyle: TextStyle(color: Color.fromARGB(255, 57, 57, 64),
                          fontWeight: FontWeight.w700),
                          prefixIcon: Icon(Icons.email_outlined, color:Color.fromARGB(255, 4, 4, 71),),
                          ),
                          style: TextStyle(color:Color.fromARGB(255, 4, 4, 71),
                          fontSize:18, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 40.0),
                        TextField(
                          onChanged: (value) {
                            UpdatedPrice = value;
                          },
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width:1 ,
                            color:Color.fromARGB(255, 4, 4, 71), ),
                            borderRadius: BorderRadius.all(Radius.circular(5)), 
                            ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 1,
                            color:Color.fromARGB(255, 4, 4, 71), ),
                            ),
                          labelText: "الخصوصي: ₪/ساعة",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelStyle: TextStyle(color:Color.fromARGB(255, 4, 4, 71),
                          fontSize:20, fontWeight: FontWeight.w700),
                          hintText: Price,
                          hintStyle: TextStyle(color: Color.fromARGB(255, 57, 57, 64),
                          fontWeight: FontWeight.w700),
                          prefixIcon: Icon(Icons.attach_money, color:Color.fromARGB(255, 4, 4, 71),),
                          ),
                          style: TextStyle(color:Color.fromARGB(255, 4, 4, 71),
                          fontSize:18, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 40.0),
                        TextField(
                          onChanged: (value) {
                            UpdatedSchool = value;
                          },
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width:1 ,
                            color:Color.fromARGB(255, 4, 4, 71), ),
                            ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 1,
                            color:Color.fromARGB(255, 4, 4, 71), ),
                            ),
                          labelText: "مكان العمل",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelStyle: TextStyle(color:Color.fromARGB(255, 4, 4, 71),
                          fontSize:20, fontWeight: FontWeight.w700),
                          hintText: School,
                          hintStyle: TextStyle(color: Color.fromARGB(255, 57, 57, 64),
                          fontWeight: FontWeight.w700),
                          prefixIcon: Icon(Icons.work, color:Color.fromARGB(255, 4, 4, 71),),
                          ),
                          style: TextStyle(color:Color.fromARGB(255, 4, 4, 71),
                          fontSize:18, fontWeight: FontWeight.w500),
                        ),

                        SizedBox(height:50,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            OutlinedButton(
                              onPressed:(){
                                Navigator.pushReplacement
                                            (context, MaterialPageRoute(
                                            builder: (context) => TutorAccount() ));
                              } ,
                              child: Text('الغاء',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 2,
                                color:Color.fromARGB(255, 4, 4, 71),),),
                                style: OutlinedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(horizontal: 30,vertical: 8),
                                  side: BorderSide(width:1,color:Color.fromARGB(255, 167, 167, 190)),
                                  shape: BeveledRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                            ),

                            ElevatedButton(
                                  onPressed:()async{
                                    print(UpdatedAccount); print(UpdatedPrice);
                                    print(Updatedemail); print(UpdatedSchool); 
                                    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
                                    User? user = _auth.currentUser;
                                    TutorrModel tutorModel = TutorrModel();
                                    tutorModel.email = user!.email;
                                    tutorModel.School = UpdatedSchool;
                                    tutorModel.Price = UpdatedPrice;
                                    tutorModel.Account = UpdatedAccount;
                                    tutorModel.Field = Field;
                                    tutorModel.Rating = Rating;
                                    tutorModel.FirstName =FirstName;
                                    tutorModel.LastName = LastName; 
                                    tutorModel.Uid = user.uid;
                                    print(tutorModel.email); print(tutorModel.Account);
                                    print(tutorModel.School); print(tutorModel.Uid);
                                    print(tutorModel.Price); 

                                    firebaseFirestore.collection("tutors")
                                    .doc( _auth.currentUser!.uid).set(tutorModel.toMap());
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
                                            builder: (context) => TutorAccount() ));
                                  } ,
                                  child: Text("حفظ",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 2,
                                    color:Color.fromARGB(255, 226, 226, 229),
                                  ),),
                                
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(horizontal:30,vertical: 8),
                                    shape: BeveledRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    //fore: Color.fromARGB(255, 4, 4, 71),
                                  ),
                                  backgroundColor: Color.fromARGB(255, 4, 4, 71),
                                  ),
                                ),
                          ],
                        )
                            
                          
                        

                      ]),
                    ),
                  ),),
                  

                ],
              );
            }
            return Container();
          }
        ),
        
      //),
    );
  }
}
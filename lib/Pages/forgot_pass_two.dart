// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:grad_project/Pages/forgor_password_three.dart';
import 'package:grad_project/Pages/forgot_password.dart';

class ForgotPassworddCode extends StatefulWidget {
  const ForgotPassworddCode({super.key});

  @override
  State<ForgotPassworddCode> createState() => _ForgotPassworddCodeState();
}

class _ForgotPassworddCodeState extends State<ForgotPassworddCode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 234, 234, 250),
      appBar: AppBar(
        iconTheme: IconThemeData(size:30,color: Color.fromARGB(255, 192, 218, 240)),
        backgroundColor: Color.fromARGB(255, 4, 4, 71),
        leading: IconButton(
          onPressed: (){
            Navigator.pushReplacement(
            context, 
            MaterialPageRoute(builder: (context) => ForgotPassEmail())); 
          },
          icon: Icon(Icons.arrow_back_ios_new,size: 15,),
        ),
        title:
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(  
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
                hintText: 'قم بادخال رمز التحقق',
                prefixIcon: Icon(Icons.fact_check, color: Color.fromARGB(255, 4, 4, 71)),
                ),
            ),
            SizedBox(height:25,),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                          context, MaterialPageRoute(
                            builder: (context) => NewPassword()));
              },
              child: Container(
                width: MediaQuery.of(context).size.width*0.3,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2.0,
                    color: Color.fromARGB(255, 4, 4, 71)),
                  //style: OutlineInputBorder.styleFrom(side: BorderSide(width: 3.0),), 
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[Color.fromARGB(255, 232, 231, 246),Color.fromARGB(255, 162, 204, 239)],
                  ),
                  borderRadius: BorderRadius.circular(50.0),
                ),
                child: Center(
                  child: Text('التالي',
                  style: TextStyle(
                    color: Color.fromARGB(255, 4, 4, 71),
                    fontSize: 20, fontWeight: FontWeight.bold
                  ),),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
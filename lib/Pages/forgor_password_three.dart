// ignore_for_file: unused_import, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:grad_project/Pages/forgot_pass_two.dart';
import 'package:grad_project/Pages/forgot_password.dart';
import 'package:grad_project/main.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({super.key});

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
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
            MaterialPageRoute(builder: (context) => ForgotPassworddCode())); 
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
            Text('قم بادخال كلمتك المرور الجديدة',
            style: TextStyle(color: Color.fromARGB(255, 9, 1, 52), fontSize: 18,
            fontWeight: FontWeight.w700),),
            SizedBox(height: 15,),
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
                hintText: "",
                prefixIcon: Icon(Icons.password_sharp, color: Color.fromARGB(255, 4, 4, 71)),
                ),
                obscureText: true,
            ),
            SizedBox(height:25,),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                          context, MaterialPageRoute(
                            builder: (context) => LogIn()));
              },
              child: Container(
                width: MediaQuery.of(context).size.width*0.5,
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
                  child: Text('تغيير كلمة المرور',
                  style: TextStyle(
                    color: Color.fromARGB(255, 4, 4, 71),
                    fontSize: 18, fontWeight: FontWeight.bold
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
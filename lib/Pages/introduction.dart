// ignore_for_file: prefer_const_constructors, prefer_final_fields, avoid_unnecessary_containers


import 'package:flutter/material.dart';
import 'package:grad_project/Pages/intro_page1.dart';
import 'package:grad_project/Pages/intro_page2.dart';
import 'package:grad_project/Pages/intro_page3.dart';
import 'package:grad_project/Pages/intro_page4.dart';
import 'package:grad_project/main.dart';
import 'package:grad_project/Pages/SignUp.dart';
//import 'dart:html';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  PageController _controller= PageController();
  bool onLastPage= false;
  bool onsecPage= false;
  bool onfourPage= false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      

      body: Stack(children: [
        PageView(
          controller: _controller,
          onPageChanged: (index){
            setState(() {
              onLastPage = (index ==3);
              onsecPage = (index ==1)||(index ==2);
              
            });
          },
          
          // ignore: prefer_const_literals_to_create_immutables
          children: [
        intro1(),
        intro2(),
        intro4(),
        intro3(),
      ],
      ),

      Container(
        alignment: Alignment(0, 0.75),
        
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //skip
            onsecPage
            ? GestureDetector(
              onTap: (){
                _controller.jumpToPage(2);
               // _controller.nextPage(duration: Duration(microseconds: 500), curve: Curves.easeIn);
              },

              child: Text('السابق',
              style: TextStyle(
                fontFamily: 'Courgette',
                fontWeight: FontWeight.w500,
                letterSpacing: 1.5,
                fontSize: 20.0,
                color: Color.fromARGB(255, 4, 4, 71),
              ),)
              )
              :
              GestureDetector(
              onTap: (){
                _controller.jumpToPage(3);
               // _controller.nextPage(duration: Duration(microseconds: 500), curve: Curves.easeIn);
              },

              child: Text('تخطي',
              style: TextStyle(
                fontFamily: 'Courgette',
                fontWeight: FontWeight.w500,
                letterSpacing: 1.5,
                fontSize: 20.0,
                color: Color.fromARGB(255, 244, 244, 248),
              ),)
              ),




            SmoothPageIndicator(controller: _controller, count: 4,
             ),
            
            //next

            onsecPage
//////////////////////////////////////////////////
           ? 
           onLastPage
            ? GestureDetector(
              onTap: (){
                //_controller.nextPage(duration: Duration(microseconds: 500), curve: Curves.easeIn);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUp() ));
              },

              child: Text('تم',
              style: TextStyle(
                fontFamily: 'Courgette',
                fontWeight: FontWeight.w500,
                fontSize: 20.0,
                letterSpacing: 1.5,
                color: Color.fromARGB(255, 4, 4, 71),
              ),)
              )

              : GestureDetector(
              onTap: (){
                _controller.nextPage(duration: Duration(microseconds: 500), curve: Curves.easeIn);
              },

              child: Text('التالي',
              style: TextStyle(
                fontFamily: 'Courgette',
                fontWeight: FontWeight.w500,
                fontSize: 20.0,
                letterSpacing: 1.5,
                color: Color.fromARGB(255, 4, 4, 71),
              ),)
              )
//////////////////////////////////////////////////////////
              :

              onLastPage
            ? GestureDetector(
              onTap: (){
                //_controller.nextPage(duration: Duration(microseconds: 500), curve: Curves.easeIn);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LogIn() ));
              },

              child: Text('تم',
              style: TextStyle(
                fontFamily: 'Courgette',
                fontWeight: FontWeight.w500,
                fontSize: 20.0,
                letterSpacing: 1.5,
                color: Color.fromARGB(255, 244, 244, 248),
              ),)
              )

              : GestureDetector(
              onTap: (){
                _controller.nextPage(duration: Duration(microseconds: 500), curve: Curves.easeIn);
              },

              child: Text('التالي',
              style: TextStyle(
                fontFamily: 'Courgette',
                fontWeight: FontWeight.w500,
                fontSize: 20.0,
                letterSpacing: 1.5,
                color: Color.fromARGB(255, 244, 244, 248),
              ),)
              ),
              
          ],
        ),
        ),

      ],),
    );
  }
}
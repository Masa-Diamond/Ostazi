// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class intro1 extends StatelessWidget {
  const intro1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 4, 4, 71),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 120,
              child: Text('لنبحث لك عن مدرس خصوصي',
              style: TextStyle(
                //fontFamily: 'Courgette',
                  fontWeight: FontWeight.w800,
                  fontSize: 30.0,
                  letterSpacing: 1.5,
                  color: Color.fromARGB(255, 244, 244, 248),
              ),),
            ),

            Positioned(
              top: 200,
              child: Container(
                padding: const EdgeInsets.all(16),
                //constraints: const BoxConstraints.expand( 
                  width: 400,
                height: 280,

                //),
                
                //color: Colors.pink,
                decoration: BoxDecoration(
                image: DecorationImage(
                 image: AssetImage('assets/images/bloom-stars-fireworks-and-hearts-for-background.gif'),
                 fit: BoxFit.cover,
                 // ignore: unnecessary_new
                // colorFilter: new ColorFilter.mode(Color.fromARGB(255, 185, 213, 161).withOpacity(1), BlendMode.dstATop),
                 
                   )
                ),
              ),
            ),


            Positioned(
              top: 280,
              child: Container(
                width: 400,
                height: 300,
                //color: Colors.pink,
                decoration: BoxDecoration(
                image: DecorationImage(
                 image: AssetImage('assets/images/bloom-woman-and-man-doing-web-browser-development.gif'),
                 fit: BoxFit.cover,
                 // ignore: unnecessary_new
                // colorFilter: new ColorFilter.mode(Color.fromARGB(255, 185, 213, 161).withOpacity(1), BlendMode.dstATop),
                 
                   )
                ),
              ),
            ),


            
          ],
      
        ),
      ),
    );
  }
}
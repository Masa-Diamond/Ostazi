// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class intro2 extends StatelessWidget {
  const intro2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 244, 244, 248),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 120,
              child: Text('الافضل شرحا لدرجات متفوقة',
              style: TextStyle(
                //fontFamily: 'Courgette',
                  fontWeight: FontWeight.w800,
                  fontSize: 30.0,
                  letterSpacing: 1.5,
                  color: Color.fromARGB(255, 4, 4, 71),
              ),),
            ),

            Positioned(
              top: 220,
              child: Container(
                padding: const EdgeInsets.all(16),
                //constraints: const BoxConstraints.expand( 
                // width: 400,
                //height: 300,

                //),
                width: MediaQuery.of(context).size.width,
               height: MediaQuery.of(context).size.height * 0.5,
                //color: Colors.pink,
                decoration: BoxDecoration(
                image: DecorationImage(
                 image: AssetImage('assets/images/flame-480.gif'),
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
                //width: 400,
                //height: 300,
                width: MediaQuery.of(context).size.width,
               height: MediaQuery.of(context).size.height * 0.37,
                //color: Colors.pink,
                decoration: BoxDecoration(
                image: DecorationImage(
                 image: AssetImage('assets/images/juicy-team-discussing-the-project.gif'),
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
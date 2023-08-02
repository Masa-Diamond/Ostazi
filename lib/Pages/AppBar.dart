import 'package:flutter/material.dart';
import 'package:grad_project/Pages/NavBar.dart';

class AppBarr extends StatefulWidget {
  const AppBarr({super.key});

  @override
  State<AppBarr> createState() => _AppBarrState();
}

class _AppBarrState extends State<AppBarr> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 4, 4, 71),
      child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Drawer(child: NavBar(),),
            Container(
              width: 250,
              height: 100,
              //color: Colors.white,
               decoration: BoxDecoration(
               image: DecorationImage(
               image: AssetImage("assets/images/logo2.png"),
               fit: BoxFit.fitWidth
            //colorFilter: new ColorFilter.mode(Color.fromARGB(255, 4, 4, 71).withOpacity(0.5), BlendMode.dstATop),
               //fit: BoxFit.cover,
           ),
          ),
            ),            
          ],
        ),
    );
  }
}
// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:grad_project/Pages/LogIn_Desktop.dart';
import 'package:grad_project/Pages/LogIn_Tablet.dart';
import 'package:grad_project/Pages/ad_stu_desktop.dart';
import 'package:grad_project/Pages/students_tablet.dart';

import '../main.dart';
import 'introduction.dart';

class ResponsiveLogIn extends StatelessWidget {
    final Widget DesktopBody;
    final Widget TabletBody;
    final Widget MobileBody;
    ResponsiveLogIn({required this.DesktopBody,required this.TabletBody,required this.MobileBody});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context,constraints){
        if(constraints.maxWidth < 500){
          return IntroScreen();
        }else if (constraints.maxWidth < 1220){return LogInTablet();}
        else{return LogInDesktop();}
      },
    );
  }
}
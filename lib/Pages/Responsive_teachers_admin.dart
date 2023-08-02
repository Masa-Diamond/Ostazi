// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:grad_project/Pages/ad_stu_desktop.dart';
import 'package:grad_project/Pages/students_tablet.dart';
import 'package:grad_project/Pages/teachers_desktop.dart';
import 'package:grad_project/Pages/teachers_tablet.dart';

class ResponsiveTeacher extends StatelessWidget {
    final Widget DesktopBody;
    final Widget TabletBody;
    ResponsiveTeacher ({required this.DesktopBody,required this.TabletBody});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context,constraints){
        if(constraints.maxWidth < 1220){
          return TeachersTablet();
        }else{return TeachersDesktop();}
      },
    );
  }
}
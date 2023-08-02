// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:grad_project/Pages/ad_stu_desktop.dart';
import 'package:grad_project/Pages/students_tablet.dart';

class ResponsiveStudent extends StatelessWidget {
    final Widget DesktopBody;
    final Widget TabletBody;
    ResponsiveStudent({required this.DesktopBody,required this.TabletBody});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context,constraints){
        if(constraints.maxWidth < 1220){
          return StudentTablet();
        }else{return StuDesktop();}
      },
    );
  }
}
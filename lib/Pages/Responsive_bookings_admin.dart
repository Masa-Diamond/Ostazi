// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:grad_project/Pages/ad_stu_desktop.dart';
import 'package:grad_project/Pages/admin.dart';
import 'package:grad_project/Pages/admin_tablet.dart';
import 'package:grad_project/Pages/bookings_desktop.dart';
import 'package:grad_project/Pages/bookings_tablet.dart';
import 'package:grad_project/Pages/students_tablet.dart';

class ResponsiveBookings extends StatelessWidget {
    final Widget DesktopBody;
    final Widget TabletBody;
    ResponsiveBookings({required this.DesktopBody,required this.TabletBody});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context,constraints){
        if(constraints.maxWidth < 1220){
          return BookingsTablet();
        }else{return BookingsDesktop();}
      },
    );
  }
}
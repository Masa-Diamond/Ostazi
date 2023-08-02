// ignore_for_file: unused_import, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

//import 'dart:js_util'; 

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:grad_project/Pages/AddCourses_Desktop.dart';
import 'package:grad_project/Pages/AddCourses_Tablet.dart';
import 'package:grad_project/Pages/LogIn_Desktop.dart';
import 'package:grad_project/Pages/LogIn_Tablet.dart';
import 'package:grad_project/Pages/Responsive_AddCourses_admin.dart';
import 'package:grad_project/Pages/Responsive_AddTeacher_admin.dart';
import 'package:grad_project/Pages/Responsive_LogIn.dart';
import 'package:grad_project/Pages/Responsive_bookings_admin.dart';
import 'package:grad_project/Pages/Responsive_students_admin.dart';
import 'package:grad_project/Pages/Responsive_teachers_admin.dart';
import 'package:grad_project/Pages/ad_stu_desktop.dart';
import 'package:grad_project/Pages/addteacher_desktop.dart';
import 'package:grad_project/Pages/addteacher_tablet.dart';
import 'package:grad_project/Pages/admin.dart';
import 'package:grad_project/Pages/bookings_desktop.dart';
import 'package:grad_project/Pages/bookings_tablet.dart';
import 'package:grad_project/Pages/introduction.dart';
import 'package:grad_project/Pages/students_tablet.dart';
import 'package:grad_project/Pages/teachers_class.dart';
import 'package:grad_project/Pages/teachers_desktop.dart';
import 'package:grad_project/Pages/teachers_tablet.dart';
import 'package:grad_project/main.dart';

import 'Responsive_admin_homePage.dart';
import 'admin_tablet.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: Container(
        color: Color.fromARGB(255, 4, 4, 71),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              width: 250,height: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/logo2.png"),
                  fit: BoxFit.fitWidth
                ),
              ),
              /*child: Text('Ostazi ',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.yellow[600],
                fontSize: 30, fontWeight: FontWeight.bold,letterSpacing:2.5
              ),),*/
            ),
            ListTile(
              onTap: (){
                Navigator.pushReplacement(
                context, 
                MaterialPageRoute(builder: (context) => ResponsiveAdmin(DesktopBody: AdminPage(), TabletBody: AdminTablet())));
              },
              leading: Icon(Icons.home,size:25,color: Color.fromARGB(255, 244, 244, 248),),
              title: Text('الرئيسية',
              style: TextStyle(
                color:Color.fromARGB(255, 209, 206, 213),
                fontSize:17, fontWeight: FontWeight.w600
              ),),
            ),
            SizedBox(height: 10,),
            ListTile(
              leading: Icon(Icons.perm_contact_calendar_outlined,size:25,color: Color.fromARGB(255, 244, 244, 248),),
              title: Text('الطلاب',
              style: TextStyle(
                color:Color.fromARGB(255, 209, 206, 213),
                fontSize: 17, fontWeight: FontWeight.w600
              ),),
              onTap: (){
                Navigator.pushReplacement(
                context, 
                MaterialPageRoute(builder: (context) => ResponsiveStudent(DesktopBody: StuDesktop(), TabletBody: StudentTablet())));
              },
            ),
            SizedBox(height: 10,),
            ListTile(
              onTap: (){
                Navigator.pushReplacement(
                context, 
                MaterialPageRoute(builder: (context) => ResponsiveTeacher(DesktopBody: TeachersDesktop(), TabletBody: TeachersTablet())));
              },
              leading: Icon(Icons.supervised_user_circle_outlined,size:25,color:Color.fromARGB(255, 244, 244, 248),),
              title: Text('الأساتذة',
              style: TextStyle(
                color:Color.fromARGB(255, 209, 206, 213),
                fontSize: 17, fontWeight: FontWeight.w600
              ),),
            ),
            SizedBox(height: 10,),
            ListTile(
              onTap: (){
                Navigator.pushReplacement(
                context, 
                MaterialPageRoute(builder: (context) => ResponsiveAddTeacher(DesktopBody: AddTeacherTablet(), TabletBody: AddTeacherDesktop())));
              },
              leading: Icon(Icons.add_box_outlined,size:25,color:Color.fromARGB(255, 244, 244, 248),),
              title: Text('تسجيل أستاذ',
              style: TextStyle(
                color:Color.fromARGB(255, 209, 206, 213),
                fontSize: 17, fontWeight: FontWeight.w600
              ),),
            ),
            SizedBox(height: 10,),
            ListTile(
              onTap: (){
                Navigator.pushReplacement(
                context, 
                MaterialPageRoute(builder: (context) => ResponsiveAddCourse(DesktopBody: AddCoursesDesktop(), TabletBody: AddCoursesTablet())));
              },
              leading: Icon(Icons.access_time,size:25,color:Color.fromARGB(255, 244, 244, 248),),
              title: Text('اضافة حصص معهد',
              style: TextStyle(
                color:Color.fromARGB(255, 209, 206, 213),
                fontSize: 17, fontWeight: FontWeight.w600
              ),),
            ),
            SizedBox(height: 10,),
            ListTile(
              onTap: (){
                Navigator.pushReplacement(
                context, 
                MaterialPageRoute(builder: (context) => ResponsiveBookings(DesktopBody: BookingsDesktop(), TabletBody: BookingsTablet())));
              },
              leading: Icon(Icons.app_registration,size:25,color:Color.fromARGB(255, 244, 244, 248),),
              title: Text('حجوزات المعهد',
              style: TextStyle(
              color:Color.fromARGB(255, 209, 206, 213),
              fontSize: 17, fontWeight: FontWeight.w600
              ),),
            ),
            Divider(),
            ListTile(
              onTap: (){
                Navigator.pushReplacement(
                context, 
                MaterialPageRoute(builder: (context) => ResponsiveLogIn(DesktopBody:LogInDesktop(), TabletBody:LogInTablet(),MobileBody:IntroScreen(),)));
              },
              leading: Icon(Icons.logout,size:25,color:Color.fromARGB(255, 244, 244, 248),),
              title: Text('تسجيل الخروج',
              style: TextStyle(
                color:Color.fromARGB(255, 209, 206, 213),
                fontSize:17, fontWeight: FontWeight.w600
              ),),
            ),
            Spacer(),
            //Image.asset("images/msedge_uwv6mWDiJB.png",width: 200,height: 160,),
            Container(
              width: MediaQuery.of(context).size.width*0.2,
              height: MediaQuery.of(context).size.height*0.18,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/msedge_uwv6mWDiJB.png"),
                  //fit: BoxFit.fitWidth
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
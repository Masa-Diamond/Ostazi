// ignore_for_file: unused_import, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:grad_project/Pages/adminPeople_class.dart';
import 'package:grad_project/Pages/side_bar_admin.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grad_project/Pages/inbox-student.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firestore = FirebaseFirestore.instance;
late User signedInUser; //this will give us the email

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});
  static const String route = '/AdminHomePage';
  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  List selectedIndex = [];
  static List<Managers> managers =[
    Managers("عدنان أحمد", "مدير المعهد", "0597512034"),
    Managers("سالم علي", "نائب المدير", "0598214095"),
    Managers("أنس محمد", "الموارد البشرية", "0562031528"),
    Managers("يزيد غفران", "السكرتير الأول", "0597021350"),
    Managers("عاصم فريد", "السكرتير الثاني", "0590239521"),
  ];

  DateTime _focusDate = DateTime.now();
  @override
  final _auth = FirebaseAuth.instance;
  
  
  @override
  void initState(){
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser(){
    try {
      final user = _auth.currentUser;
      if (user != null){
      signedInUser = user;
      print(signedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor:Color.fromARGB(255, 4, 4, 71) ,
      /*appBar: AppBar(
        iconTheme: IconThemeData(size:30,color: Color.fromARGB(255, 192, 218, 240)),
        elevation: 8,
        // ignore: prefer_const_constructors
        backgroundColor: Color.fromARGB(255, 4, 4, 71),
        title:
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: 250,
              height: 100,
              //color: Colors.white,
               decoration: BoxDecoration(
               image: DecorationImage(
               image: AssetImage("assets/images/logo2.png"),
               fit: BoxFit.fitWidth
               ),
              ),
            ),            
          ],
        ),
      ),*/
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //side menu
            Expanded(
              child: SideBar()
            ),
            //Main Page
            Expanded(
              flex: 4,
              child: Container(
                margin: EdgeInsets.all(15),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color:Color.fromARGB(255, 244, 244, 248),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    //header
                    Row( mainAxisAlignment: MainAxisAlignment.end,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Text('الرئيسية',
                        style: TextStyle(
                          color: Color.fromARGB(255, 4, 4, 71),
                          fontSize:30, fontWeight: FontWeight.bold 
                        ),)
                      ],
                    ),

                    Expanded(
                      child:SingleChildScrollView(
                      child:Row( //mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 3,
                            child:
                             Container(
                              child: Column(
                                children: [
                                  SizedBox(width: MediaQuery.of(context).size.width*0.75,),
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(253, 216, 53, 1),
                                      borderRadius:BorderRadius.circular(20),
                                    ),
                                    padding: EdgeInsets.all(20),
                                    child: Row( 
                                      children: [
                                        Column(
                                          children: [
                                            Text.rich(TextSpan(
                                              style: TextStyle(
                                                color: Color.fromARGB(255, 4, 4, 71),
                                                fontSize: 18, fontWeight: FontWeight.w600,
                                              ),
                                              children:[
                                                TextSpan(text: " مرحبا بك"),
                                                TextSpan(text: " المعهد العلمي",
                                                  style: TextStyle(
                                                  fontWeight: FontWeight.bold)
                                                ),
                                                TextSpan(text: "في تطبيق أستاذي"),
                                              ]
                                            )),
                                            SizedBox(height: 10,),
                                            Text(',يمكنك من متابعة الطلاب و الأساتذه بالاضافة الى اضافة حصص المعهد و الأساتذة الجدد ',
                                            style:TextStyle(
                                              fontSize: 16, color:Color.fromARGB(255, 4, 4, 71),
                                              fontWeight: FontWeight.w600, height: 1.5 
                                            ),),
                                            Text('!لديك الكثير من العمل و نتمنى لك يوما طيبا',
                                            style:TextStyle(
                                              fontSize: 16, color:Color.fromARGB(255, 4, 4, 71),
                                              fontWeight: FontWeight.w600, height: 1.5 
                                            ),),
                                            SizedBox(height: 10,),
                                          ],
                                        ),
                                      
                                        Spacer(),
                                        //Image.asset("images/msedge_eEnTKJSzhG.png",height:100,//width:160,
                                        //),
                                        Container(
                                          width: MediaQuery.of(context).size.width*0.1,
                                          height: MediaQuery.of(context).size.height*0.14,
                                          //color: Color.fromARGB(255, 1, 20, 35),
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage("images/msedge_eEnTKJSzhG.png"),
                                              fit: BoxFit.cover,
                                            )
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  
                                  SizedBox(height: 20,),
                                  //Text(currentWidth.toString()),
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius:BorderRadius.circular(20),
                                      color: Colors.white,//Colors.pink[100], 
                                    ),
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      //mainAxisAlignment: MainAxisAlignment.end,
                                      //crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Row(
                                          //mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Text('طاقم المعهد العلمي',
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                              color: Color.fromARGB(255, 4, 4, 71),
                                              fontSize:23, fontWeight: FontWeight.bold 
                                            ),),
                                            
                                          ],
                                        ),
                                      
                                        Divider(
                                          thickness: 0.5,
                                          color: Colors.grey,
                                        ),
                                        
                                        ListView.builder(
                                          //padding: EdgeInsets.all(10),
                                          shrinkWrap: true,
                                          itemCount: managers.length,
                                          itemBuilder:(context, index){
                                            return Container(
                                              margin: EdgeInsets.only(bottom:15),
                                              padding: EdgeInsets.symmetric(horizontal:30,vertical:15),
                                              width: MediaQuery.of(context).size.width*0.6,
                                              decoration: BoxDecoration(
                                                color: Color.fromARGB(255, 249, 246, 228),
                                                borderRadius: BorderRadius.all(Radius.circular(15),),
                                                border: Border.all(width:1,color: Color.fromARGB(255, 200, 199, 201),)
                                              ),
                                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  Text(managers[index].Phone!,
                                                    style:TextStyle(
                                                      color:Color.fromARGB(255, 1, 1, 41),
                                                      fontSize:18, fontWeight: FontWeight.w400
                                                  ),),
                                                
                                                SizedBox(width:100,),
                                                Text(managers[index].Position!,
                                                  style:TextStyle(
                                                  color:Color.fromARGB(255, 1, 1, 45),
                                                  fontSize:18, fontWeight: FontWeight.w400
                                                ) ,),
                                                SizedBox(width: 170,),
                                                Text(managers[index].FullName!,
                                                  style:TextStyle(
                                                  color:Color.fromARGB(255, 1, 1, 40),
                                                  fontSize:18, fontWeight: FontWeight.w400
                                                ) ,),
                                                //Divider(thickness: 0.5,color: Colors.grey,),
                                              ]),
                                            );
                                          } 
                                        ),
                                        /*Table(
                                          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                          children: [
                                            //table header
                                            TableRow(
                                              decoration: BoxDecoration(
                                                border: Border(bottom: 
                                                BorderSide(color: Colors.grey,width: 0.5))
                                              ),
                                              children: [
                                                //tableHeader(" ..."),
                                                tableHeader("رقم الهاتف"),
                                                tableHeader("المنصب"),
                                                tableHeader("الاسم الكامل"),
                                              ]
                                            ),
                                            //table data
                                            tableRow(context,
                                            number: "0593214025",
                                            work: "مدير المعهد",
                                            name: "عدنان احمد"
                                            ),
                                            tableRow(context,
                                            number: "0595012478",
                                            work: "نائب المدير",
                                            name: "ساللم غفران"
                                            ),
                                            tableRow(context,
                                            number: "0595124803",
                                            work: "الموارد البشرية",
                                            name: "حنان اسعد"
                                            ),
                                            tableRow(context,
                                            number: "05902145238",
                                            work: "السكرتير الأول",
                                            name: "هلا عبد الرحمن"
                                            ),
                                            tableRow(context,
                                            number: "0597523916",
                                            work: "السكرتير الثاني",
                                            name: "جنى هاشم"
                                            ),
                    
                                          ],
                                        ),*/
                                      ],
                                    ),
                                  ),
                                
                                ],
                              ),
                            ),
                          ),

                          Expanded(
                            child:Container(
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.amber[100],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("${DateFormat("MMM, yyy").format(_focusDate)}",
                                            style:TextStyle(
                                              color: Color.fromARGB(255, 1, 24, 43),
                                              fontSize:20, fontWeight: FontWeight.bold
                                            ),),
                                            Row(
                                              children: [
                                                InkWell(
                                                  onTap: (){
                                                    setState(() {
                                                      _focusDate=DateTime(_focusDate.year,_focusDate.month-1);
                                                    });
                                                  },
                                                  child:Icon(Icons.chevron_left,
                                                  color:Color.fromARGB(255, 1, 24, 43),),
                                                ),
                                                InkWell(
                                                  onTap: (){
                                                    setState(() {
                                                      _focusDate=DateTime(_focusDate.year,_focusDate.month+1);
                                                    });
                                                  },
                                                  child:Icon(Icons.chevron_right,
                                                  color:Color.fromARGB(255, 1, 24, 43),),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 10,),
                                        TableCalendar(
                                          focusedDay: _focusDate,
                                           firstDay: DateTime.utc(2015),
                                            lastDay: DateTime.utc(2111),
                                            ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      ), 
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TableRow tableRow(context,{number,work,name}){
    return TableRow(
                                              decoration: BoxDecoration(
                                                border: Border(bottom:
                                                BorderSide(color: Colors.grey, width: 0.5), 
                                                ),
                                              ),
                                              children: [
                                                //full name عدنان أحمد", "مدير المعهد", "0597512034")
                                                Text(number,
                                                style: TextStyle(
                                                  fontSize: 16, fontWeight: FontWeight.w500,
                                                  color: Color.fromARGB(255, 4, 4, 71)
                                                ),),
                                                Text(work,
                                                style: TextStyle(
                                                  fontSize: 16, fontWeight: FontWeight.w500,
                                                  color: Color.fromARGB(255, 4, 4, 71)
                                                ),),
                                                Text(name,
                                                style: TextStyle(
                                                  fontSize: 16, fontWeight: FontWeight.w500,
                                                  color: Color.fromARGB(255, 4, 4, 71)
                                                ),)
                                              ]
                                            );
  }

  Widget tableHeader(text){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: Text(text,
      style: TextStyle(
        color: Color.fromARGB(255, 4, 4, 71),
        fontSize: 20, fontWeight: FontWeight.bold,
      ),),
    );
  }
}
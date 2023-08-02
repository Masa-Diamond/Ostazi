// ignore_for_file: prefer_const_constructors

import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:grad_project/Pages/AddSpecificCourse_desktop.dart';
import 'package:grad_project/Pages/CoursesAdminAdd_class.dart';
import 'package:grad_project/Pages/CoursesAdminAdd_class.dart';
import 'package:grad_project/Pages/side_bar_admin.dart';
import 'package:intl/intl.dart';

import 'AddSpecificCourse-tablet.dart';
import 'CoursesAdminAdd_class.dart';
import 'CoursesAdminAdd_class.dart';
import 'Responsive_AddSpecificCourse.dart';

import '../model/courses_model.dart';
import 'AddCourses_Tablet.dart';
import 'Responsive_AddCourses_admin.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grad_project/Pages/inbox-student.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firestore = FirebaseFirestore.instance;
late User signedInUser;

class AddCoursesTablet extends StatefulWidget {
  const AddCoursesTablet({super.key});

  @override
  State<AddCoursesTablet> createState() => _AddCoursesTabletState();
}

class _AddCoursesTabletState extends State<AddCoursesTablet> {
  DateTime _selectedDate = DateTime.now() ;
   List selectedIndex = [];
   static List<CoursesAdmin> coursesAdmin =[
    CoursesAdmin("أيمن صبوح","فيزياء", "11/24/2022", "2:00 PM", "3:00 PM", 20),
    CoursesAdmin("غسان الساحلي","كيمياء", "11/24/2022", "3:00 PM", "4:00 PM", 25),
    CoursesAdmin("حمدي وهبة","رياضيات", "11/24/2022", "4:00 PM", "5:00 PM", 30),
    CoursesAdmin("ماسة السيد","الانجليزية", "11/24/2022", "5:00 PM", "6:00 PM", 20),

    CoursesAdmin("غسان الساحلي","كيمياء", "11/26/2022", "10:00 AM", "11:00 AM", 25),
    CoursesAdmin("حمدي وهبة","رياضيات", "11/26/2022", "11:00 AM", "12:00 PM", 30),
    CoursesAdmin("أيمن صبوح","فيزياء", "11/26/2022", "12:00 PM", "1:00 PM", 20),
    CoursesAdmin("ماسة السيد","الانجليزية", "11/26/2022", "2:00 PM", "3:00 PM", 20),

    CoursesAdmin("أيمن صبوح","فيزياء", "11/30/2022", "2:00 PM", "3:00 PM", 20),
    CoursesAdmin("غسان الساحلي","كيمياء", "11/30/2022", "3:00 PM", "4:00 PM", 25),
    CoursesAdmin("حمدي وهبة","رياضيات", "11/30/2022", "4:00 PM", "5:00 PM", 30),
    CoursesAdmin("ماسة السيد","الانجليزية", "11/30/2022", "5:00 PM", "6:00 PM", 20),

    CoursesAdmin("غسان الساحلي","كيمياء", "12/3/2022", "10:00 AM", "11:00 AM", 25),
    CoursesAdmin("حمدي وهبة","رياضيات", "12/3/2022", "11:00 AM", "12:00 PM", 30),
    CoursesAdmin("أيمن صبوح","فيزياء", "12/3/2022", "12:00 PM", "1:00 PM", 20),
    CoursesAdmin("ماسة السيد","الانجليزية", "12/3/2022", "2:00 PM", "3:00 PM", 20),
   ];
   List<CoursesAdmin> coursesAdmin_List = List.from(coursesAdmin);
   int tapped_index =0;
  void checkSelectedCard(int index){
    print("Tapped index: ${index}");
    tapped_index =index;
  }
  void selected(int index){
    setState((){
      if (selectedIndex.contains(index)) {
        selectedIndex.remove(index);
        } else {
        selectedIndex.add(index);
        }
    });
  }

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
  DeleteData(id) async{
    await FirebaseFirestore.instance.collection('courses').doc(id).delete();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color.fromARGB(255, 244, 244, 248),
      drawer: SideBar(),
      appBar: AppBar(
        iconTheme: IconThemeData(size:30,color: Color.fromARGB(255, 244, 244, 248),//Color.fromARGB(255, 192, 218, 240)
        ),
        backgroundColor: Color.fromARGB(255, 4, 4, 71),
        //leading: Icon(Icons.edit),
        title:
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 250,height: 100,
               decoration: BoxDecoration(
               image: DecorationImage(
               image: AssetImage("assets/images/logo2.png"),
               fit: BoxFit.fitWidth
           ),),
          ),
          ],),
      ),


      body: Column(
        children: [
          Container(
            margin:const EdgeInsets.only(left:20, right:20, top:10 ) ,
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                    context, 
                    MaterialPageRoute(builder: (context) =>ResponsiveAddSpecificCourse(DesktopBody: AddSpecificCourseDesktop(), TabletBody:AddSpecificCourseTablet())));
                  },
                  child: Container(
                    padding: EdgeInsets.only(top:15),
                    width: 120, height:60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color:Color.fromARGB(255, 140, 14, 15),
                    ),
                    child: Text("اضافة حصة +",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color:Color.fromARGB(255, 244, 244, 248),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),),
                  ),
                ),
                SizedBox(width:MediaQuery.of(context).size.width*0.2,),
                Container(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(DateFormat.yMMMMd().format(DateTime.now()),
                      //textAlign: TextAlign.right,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 142, 142, 164),
                        fontSize: 24
                      ),),
                      Text("اليوم",
                      //textAlign: TextAlign.left,
                      style:TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 4, 4, 71),
                        fontSize:30
                      ),)
                    ],
                  ),
                ),
              ],
            ),
          ),
          //CALANDER///////////////////////////////////
          Container(
            margin:const EdgeInsets.only(top:20, left: 20) ,
            child: DatePicker(
              DateTime.now(),
              height: 100, width: 80,
              initialSelectedDate:DateTime.now(),
              selectionColor:Color.fromARGB(255, 140, 14, 15),
              selectedTextColor:Color.fromARGB(255, 244, 244, 248),
              // ignore: prefer_const_constructors
              dateTextStyle:TextStyle(
                fontSize: 20, fontWeight:FontWeight.w600,
                color:Color.fromARGB(255, 166,156,172),  
              ),
              dayTextStyle:TextStyle(
                fontSize: 16, fontWeight:FontWeight.w600,
                color:Color.fromARGB(255, 166,156,172),  
              ),
              monthTextStyle:TextStyle(
                fontSize: 14, fontWeight:FontWeight.w600,
                color:Color.fromARGB(255, 166,156,172),  
              ),
              onDateChange: (date){
                setState(() {
                  _selectedDate=date;
                  print(DateFormat.yMd().format(_selectedDate));
                }); 
              },
            ),
          ),
          //LIST OF APPOINTMENTS///////////////////////////////
          SizedBox(height: MediaQuery.of(context).size.height*0.08,),
          StreamBuilder<QuerySnapshot>(
            stream: _firestore.collection('courses').snapshots(),
            builder: (BuildContext context, snapshot){
              if(!snapshot.hasData){
                return Center(
                  child: Container(
                    child: Text("!لا يوجد أي حصص في هذا اليوم",
                    style: TextStyle(color: Color.fromARGB(255, 4, 1, 47), fontSize: 24, fontWeight: FontWeight.bold),),
                  ),
                );
              }
              return Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index){
                    var data = snapshot.data!.docs[index].data() as Map<String , dynamic>;
                    if(data['Date'] == DateFormat.yMd().format(_selectedDate).toString()){
                      return Center(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal:7,vertical: 20),
                          margin: EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width*0.75,
                          height: MediaQuery.of(context).size.height*0.15,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 202, 192, 207),
                            borderRadius: BorderRadius.all(Radius.circular(15),),
                            border: Border.all(width:1,color: Color.fromARGB(255, 14, 1, 36),//Color.fromARGB(255, 233, 174, 221),
                              ),
                            // ignore: prefer_const_literals_to_create_immutables
                            boxShadow: [BoxShadow(
                              color: Color.fromARGB(255, 215, 215, 215),
                            spreadRadius: 1, blurRadius: 1,
                            ),],
                          ),
                          child: ListTile(
                            leading: 
                            GestureDetector(
                              onTap: (){
                                print(index);
                                showDialog(
                                  context: context,
                                  builder: (context){
                                  return Center(
                                    child: Material(
                                      type: MaterialType.transparency,
                                      child: Container(
                                        padding: const EdgeInsets.only(top:4),
                                        width: MediaQuery.of(context).size.width*0.4,
                                        height:MediaQuery.of(context).size.height*0.24,
                                        decoration: BoxDecoration(
                                          color:Color.fromARGB(255, 244, 244, 248),
                                          borderRadius: BorderRadius.circular(20),
                                          boxShadow: [BoxShadow(
                                            blurRadius: 2, spreadRadius: 2
                                          )],
                                          border: Border.all(width:2,color:Color.fromARGB(255, 4, 4, 71),//Color.fromARGB(255, 233, 174, 221),
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            
                                            GestureDetector(
                                              onTap: () async{
                                                setState(() {
                                                  print(index);
                                                  DeleteData(snapshot.data!.docs[index].id);
                                                  //FirebaseFirestore.instance.collection('courses').doc(index.toString()).delete();
                                                  Navigator.of(context).pop(false);
                                                }); 
                                                //appointments_list.removeWhere((item) => item.id==id);
                                              },
                                              child: Container(
                                                padding: const EdgeInsets.all(5),
                                                margin: const EdgeInsets.only(bottom: 15),
                                                width: 320, height: 50,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(15),
                                                  color:Color.fromARGB(255, 209, 115, 115),
                                                  border: Border.all(width:2,color:Color.fromARGB(255, 209, 115, 115),//Color.fromARGB(255, 233, 174, 221),
                                                  ), 
                                                  /*boxShadow: [BoxShadow(
                                                  blurRadius: 2, spreadRadius: 2,
                                                  color: Color.fromARGB(255, 201, 100, 100),
                                                  )],*/
                                                ),
                                                child:Text(" حذف الحصة",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                  color:Color.fromARGB(255, 244, 244, 248),
                                                  fontSize: 20, fontWeight: FontWeight.bold,
                                                  ),),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: (){
                                                Navigator.of(context).pop(false);
                                              },
                                              child: Container(
                                                padding: const EdgeInsets.all(5),
                                                margin: const EdgeInsets.only(bottom: 1),
                                                width: 320, height: 50,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(15),
                                                  color:Color.fromARGB(255, 244, 244, 248), 
                                                  //border: Border.all(width:2,//color: Color.fromARGB(255, 14, 1, 36),//Color.fromARGB(255, 233, 174, 221),
                                                  //),
                                                  boxShadow: [BoxShadow(
                                                  blurRadius: 2, spreadRadius: 2,
                                                  color: Colors.grey,
                                                  )],
                                                ),
                                                child:Text("اغلاق",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                  color:Color.fromARGB(255, 1, 7, 41),
                                                  fontSize: 20, fontWeight: FontWeight.bold,
                                                  ),),
                                              ),
                                            ),
                                            
                                          ],
                                        ),
                                        ),
                                    ),
                                  );}
                                );
                                //selected(index);
                              },
                              child: Container(
                                  width:90, height:120, 
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color:Color.fromARGB(255, 18, 2, 61),
                                  ),
                                  child:Row(mainAxisAlignment: MainAxisAlignment.center,
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: [
                                      Icon(Icons.delete_forever_rounded,color:Color.fromARGB(255, 226, 226, 248),),
                                      SizedBox(width: 2,),
                                      Text("حذف",
                                      style:TextStyle(
                                        color:Color.fromARGB(255, 226, 226, 248),
                                        fontWeight: FontWeight.bold 
                                      ),),
                                    ], 
                                  ),
                              ),
                            ),

                            title:
                            Row(
                              children: [
                                SizedBox(width: 150,),
                                Row(
                                  children: [
                                    /*Icon(Icons.class_,
                                    color:Color.fromARGB(255, 11, 0, 49),size:27,),*/
                                    SizedBox(width:7,),
                                    Text(data['Field'],
                                    style: TextStyle(
                                      color:Color.fromARGB(255, 1, 1, 43),
                                      fontSize:16, fontWeight: FontWeight.bold
                                    ),),                                           
                                  ],
                                ),
                                SizedBox(width: 160,),
                                Row(
                                  children: [
                                    Text("₪/ساعة",
                                    style: TextStyle(
                                      color:Color.fromARGB(255, 1, 1, 43),
                                      fontSize:16, fontWeight: FontWeight.bold
                                    ),),
                                    SizedBox(width: 5,),
                                    Text(data['Price'],
                                    style: TextStyle(
                                      color:Color.fromARGB(255, 1, 1, 43),
                                      fontSize:16, fontWeight: FontWeight.bold
                                    ),
                                    ),                                                
                                  ],
                                ),
                              ],
                            ),

                            subtitle: 
                            Row(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(width: 150,),
                                    Icon(Icons.timer_rounded,
                                    color:Color.fromARGB(255, 11, 0, 49),size:27,),
                                    SizedBox(width:7,),
                                    Text(data['StartTimr'],
                                    style: TextStyle(
                                      color:Color.fromARGB(255, 1, 1, 43),
                                      fontSize:16, fontWeight: FontWeight.bold
                                    ),),
                                    SizedBox(width:3,),
                                    Text("-",
                                    style: TextStyle(
                                      color:Color.fromARGB(255, 1, 1, 43),
                                      fontSize:16, fontWeight: FontWeight.bold
                                    ),),
                                    SizedBox(width:3,),
                                    Text(data['EndTime'],
                                    style: TextStyle(
                                      color:Color.fromARGB(255, 1, 1, 43),
                                      fontSize:16, fontWeight: FontWeight.bold
                                    ),
                                    ),                                                
                                    SizedBox(width: 50,),
                                    Row(
                                      children: [
                                        Icon(Icons.calendar_month_outlined,
                                        color:Color.fromARGB(255, 11, 0, 49),size:27,),
                                        Text(data['Date'],
                                        style: TextStyle(
                                          color:Color.fromARGB(255, 1, 1, 43),
                                          fontSize:16, fontWeight: FontWeight.bold
                                        ),),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            trailing:
                            Text(data['Tutor'],
                            style: TextStyle(
                              color:Color.fromARGB(255, 1, 1, 43),
                              fontSize:22, fontWeight: FontWeight.bold
                            ),),
                          ),
                        ),
                      );
                    }
                    return Container(); 
                  }
                ),
              );
            }
          ),
          /*Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: coursesAdmin_List.length,
              itemBuilder: (context, index){
                if(coursesAdmin_List[index].Datee==DateFormat.yMd().format(_selectedDate)){
                  return AnimationConfiguration.staggeredList(position:index, 
                    child: SlideAnimation(
                      child: FadeInAnimation(
                        child: Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                checkSelectedCard(index);
                                tapped_index = index;
                                selected(tapped_index);
                                //int ID= appointments_list[index].id;
                                _showSheet(context,index);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal:2,vertical: 20),
                                margin: EdgeInsets.only(bottom:20),
                                width: MediaQuery.of(context).size.width*0.7,
                                height: MediaQuery.of(context).size.height*0.1,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 202, 192, 207),
                                  borderRadius: BorderRadius.all(Radius.circular(15),),
                                  border: Border.all(width:1,color: Color.fromARGB(255, 14, 1, 36),//Color.fromARGB(255, 233, 174, 221),
                                    ),
                                  // ignore: prefer_const_literals_to_create_immutables
                                  boxShadow: [BoxShadow(
                                    color: Color.fromARGB(255, 215, 215, 215),
                                  spreadRadius: 1, blurRadius: 1,
                                  ),],  
                                ),
                                child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            Text("₪/ساعة",
                                            style: TextStyle(
                                              color:Color.fromARGB(255, 1, 1, 43),
                                              fontSize:16, fontWeight: FontWeight.bold
                                            ),),
                                            SizedBox(width: 5,),
                                            Text("${coursesAdmin_List[index].Price}",
                                            style: TextStyle(
                                              color:Color.fromARGB(255, 1, 1, 43),
                                              fontSize:16, fontWeight: FontWeight.bold
                                            ),
                                            ),                                                
                                          ],
                                        ),
                                      ],
                                    ),

                                    Column(mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            Text(coursesAdmin_List[index].StartTime!,
                                            style: TextStyle(
                                              color:Color.fromARGB(255, 1, 1, 43),
                                              fontSize:16, fontWeight: FontWeight.bold
                                            ),),
                                            SizedBox(width:3,),
                                            Text("-",
                                            style: TextStyle(
                                              color:Color.fromARGB(255, 1, 1, 43),
                                              fontSize:16, fontWeight: FontWeight.bold
                                            ),),
                                            SizedBox(width:3,),
                                            Text(coursesAdmin_List[index].EndTime!,
                                            style: TextStyle(
                                              color:Color.fromARGB(255, 1, 1, 43),
                                              fontSize:16, fontWeight: FontWeight.bold
                                            ),
                                            ),                                                
                                          ],
                                        ),
                                      ],
                                    ),

                                    Column(mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            /*Icon(Icons.class_,
                                            color:Color.fromARGB(255, 11, 0, 49),size:27,),*/
                                            SizedBox(width:7,),
                                            Text(coursesAdmin_List[index].Material!,
                                            style: TextStyle(
                                              color:Color.fromARGB(255, 1, 1, 43),
                                              fontSize:16, fontWeight: FontWeight.bold
                                            ),),                                           
                                          ],
                                        ),
                                      ],
                                    ),

                                    Column(mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            Text(coursesAdmin_List[index].Teacher!,
                                            style: TextStyle(
                                              color:Color.fromARGB(255, 1, 1, 43),
                                              fontSize:16, fontWeight: FontWeight.bold
                                            ),),                                           
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ),

                  );
                }else {return Container(                 
                );}
              }
            ),
          ),*/
        ],
      ),
    );
  }
   _showSheet(BuildContext context, int id){
  print(id);
  return showDialog(
    context: context,
    builder: (context){
     return Center(
       child: Material(
        type: MaterialType.transparency,
         child: Container(
          padding: const EdgeInsets.only(top:4),
          width: MediaQuery.of(context).size.width*0.4,
          height:MediaQuery.of(context).size.height*0.24,
          decoration: BoxDecoration(
            color:Color.fromARGB(255, 244, 244, 248),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(
              blurRadius: 2, spreadRadius: 2
            )],
            border: Border.all(width:2,color:Color.fromARGB(255, 4, 4, 71),//Color.fromARGB(255, 233, 174, 221),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              GestureDetector(
                onTap: (){
                  setState(() {
                    print(id);
                    Navigator.of(context).pop(false);
                  }); 
                  //appointments_list.removeWhere((item) => item.id==id);
                },
                child: Container(
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.only(bottom: 15),
                  width: 320, height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color:Color.fromARGB(255, 209, 115, 115),
                    border: Border.all(width:2,color:Color.fromARGB(255, 209, 115, 115),//Color.fromARGB(255, 233, 174, 221),
                    ), 
                    /*boxShadow: [BoxShadow(
                    blurRadius: 2, spreadRadius: 2,
                    color: Color.fromARGB(255, 201, 100, 100),
                    )],*/
                  ),
                  child:Text(" حذف الحصة", 
                    textAlign: TextAlign.center,
                    style: TextStyle(
                    color:Color.fromARGB(255, 244, 244, 248),
                    fontSize: 20, fontWeight: FontWeight.bold,
                    ),),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.of(context).pop(false);
                },
                child: Container(
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.only(bottom: 1),
                  width: 320, height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color:Color.fromARGB(255, 244, 244, 248), 
                    //border: Border.all(width:2,//color: Color.fromARGB(255, 14, 1, 36),//Color.fromARGB(255, 233, 174, 221),
                    //),
                    boxShadow: [BoxShadow(
                    blurRadius: 2, spreadRadius: 2,
                    color: Colors.grey,
                    )],
                  ),
                  child:Text("اغلاق",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                    color:Color.fromARGB(255, 1, 7, 41),
                    fontSize: 20, fontWeight: FontWeight.bold,
                    ),),
                ),
              ),
              
            ],
          ),
           ),
       ),
     );}
  );

                            
 }
}
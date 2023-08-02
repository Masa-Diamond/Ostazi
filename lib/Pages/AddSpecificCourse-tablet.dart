// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:grad_project/Pages/AddCourses_Desktop.dart';
import 'package:grad_project/Pages/AddCourses_Tablet.dart';
import 'package:grad_project/Pages/Responsive_AddCourses_admin.dart';
import 'package:grad_project/Pages/add_appointments.dart';
import 'package:grad_project/Pages/side_bar_admin.dart';
import 'package:intl/intl.dart';

import '../model/courses_model.dart';
import 'AddCourses_Tablet.dart';
import 'Responsive_AddCourses_admin.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grad_project/Pages/inbox-student.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firestore = FirebaseFirestore.instance;
late User signedInUser;


class AddSpecificCourseTablet extends StatefulWidget {
  const AddSpecificCourseTablet({super.key});

  @override
  State<AddSpecificCourseTablet> createState() => _AddSpecificCourseTabletState();
}
DateTime _selectedDate = DateTime.now();
 String _startTime =DateFormat("hh:mm a").format(DateTime.now()).toString();
 String _endTime ="3:00";
 String _selectedTeacher = "أيمن صبوح";
 List <String> TeacherList=[
  "أيمن صبوح",
  "غسان الساحلي",
  "حمدي وهبة",
  "ماسة السيد",
  "فيحاء البحش",
  "عمار النابلسي",
 ];
class _AddSpecificCourseTabletState extends State<AddSpecificCourseTablet> {
  @override
  final _auth = FirebaseAuth.instance;
  final formkey = GlobalKey<FormState>();
  late String Tutor;
  late String Field;
  late String Date;
  late String StartTime;
  late String EndTime;
  late String Price;
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

      body: Container(
        padding: EdgeInsets.all(25),
        child: Column(crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios,
                  color:Color.fromARGB(255, 1, 1, 48),),
                    onPressed: (){
                      Navigator.pushReplacement(
                      context, 
                      MaterialPageRoute(builder: (context) => ResponsiveAddCourse(DesktopBody:AddCoursesDesktop(),TabletBody:AddCoursesTablet(),)));
                    },
                ),
                Text("اضافة وقت حصة",
                  textAlign: TextAlign.right,
                  style:TextStyle(
                    color: Color.fromARGB(255, 1, 1, 47),
                    fontSize:30, fontWeight: FontWeight.bold, 
                ),),
              ],
            ),
            ////////////////////////////////////////////
            Container(
              margin: EdgeInsets.only(top:15),
              width: MediaQuery.of(context).size.width*0.8,
              //height: 30,
              //color: Colors.amber[100],
              child: Column(crossAxisAlignment: CrossAxisAlignment.end,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Text('الأستاذ',
                //textAlign: TextAlign.right,
                style: TextStyle(
                  color: Color.fromARGB(255, 38, 38, 52),
                  fontSize:20, fontWeight: FontWeight.w600,  
                ),),
                Container(
                  padding: EdgeInsets.only(right: 14), 
                  height: 42,
                  margin: EdgeInsets.only(top:8),
                  decoration: BoxDecoration(
                    border: Border.all(
                    color: Color.fromARGB(255, 142, 142, 164),
                    width: 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          //readOnly: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ("يجب تعبئة اسم الأستاذ");
                            }
                            return null;
                          },
                          onChanged: (value){
                            Tutor = value;
                            print(Tutor);
                          },
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color:Color.fromARGB(255, 57, 57, 67),
                            fontSize: 20, fontWeight:FontWeight.w500,  
                          ),
                          decoration: InputDecoration(
                            hintText: "$_selectedTeacher",
                            hintStyle: TextStyle(
                              color:Color.fromARGB(255, 88, 88, 100),
                              fontSize: 20, fontWeight:FontWeight.w500,
                            ),
                            /*focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(width:0,
                              color:Color.fromARGB(255, 4, 4, 71),),
                            ),
                            enabledBorder:UnderlineInputBorder(
                              borderSide: BorderSide(width:0,
                              color:Color.fromARGB(255, 4, 4, 71),),
                            ),*/ 
                          ),
                        ),
                      ),

                      /*DropdownButton(
                        icon: Icon(Icons.keyboard_arrow_down,
                        color:Color.fromARGB(255, 88, 88, 100),),
                        //iconSize: 32,
                        elevation: 4,
                        underline: Container(height: 0,),
                        style: TextStyle(
                          color:Color.fromARGB(255, 57, 57, 67),
                          fontSize: 20, fontWeight:FontWeight.w500,
                        ),
                        onChanged: (String? newValue){
                          setState(() {
                            _selectedTeacher = newValue!;
                          });
                        },
                        items: TeacherList.map<DropdownMenuItem<String>>((String? value){
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value!,
                            style:TextStyle(
                              color:Color.fromARGB(255, 57, 57, 67),
                              fontSize: 20, fontWeight:FontWeight.w500,
                            ),),
                          );
                        }).toList(),
                      ),*/
                    ],
                  ),
                ),
              ],
              ),
            ),

            Container(
              margin: EdgeInsets.only(top:15),
              width: MediaQuery.of(context).size.width*0.8,
              // height: 30,
              // color: Colors.amber[100],
              child: Column(crossAxisAlignment: CrossAxisAlignment.end,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Text('المادة',
                //textAlign: TextAlign.right,
                style: TextStyle(
                  color: Color.fromARGB(255, 38, 38, 52),
                  fontSize:20, fontWeight: FontWeight.w600,  
                ),),
                Container(
                  padding: EdgeInsets.only(right: 14), 
                  height: 42,
                  margin: EdgeInsets.only(top:8),
                  decoration: BoxDecoration(
                    border: Border.all(
                    color: Color.fromARGB(255, 142, 142, 164),
                    width: 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          //readOnly: true,
                          validator: (value) {
                                    if (value!.isEmpty) {
                                      return ("يجب تعبئة المادة");
                                    }
                                    return null;
                                  },
                                  onChanged: (value){
                                    Field = value;
                                    print(Field);
                                  },
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color:Color.fromARGB(255, 57, 57, 67),
                            fontSize: 20, fontWeight:FontWeight.w500,  
                          ),
                          decoration: InputDecoration(
                            hintText: "فيزياء",
                            hintStyle: TextStyle(
                              color:Color.fromARGB(255, 88, 88, 100),
                              fontSize: 20, fontWeight:FontWeight.w500,
                            ),
                            /*focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(width:0,
                              color:Color.fromARGB(255, 4, 4, 71),),
                            ),
                            enabledBorder:UnderlineInputBorder(
                              borderSide: BorderSide(width:0,
                              color:Color.fromARGB(255, 4, 4, 71),),
                            ),*/ 
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
              ),
            ),

            Container(
                      margin: EdgeInsets.only(top:15),
                      width: MediaQuery.of(context).size.width*0.8,
                     // height: 30,
                     // color: Colors.amber[100],
                      child: Column(crossAxisAlignment: CrossAxisAlignment.end,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Text('سعر الحصة للطالب الواحد',
                        //textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Color.fromARGB(255, 38, 38, 52),
                          fontSize:20, fontWeight: FontWeight.w600,  
                        ),),
                        Container(
                          padding: EdgeInsets.only(right: 14), 
                          height: 42,
                          margin: EdgeInsets.only(top:8),
                          decoration: BoxDecoration(
                            border: Border.all(
                            color: Color.fromARGB(255, 142, 142, 164),
                            width: 1,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return ("يجب تعبئة السعر");
                                    }
                                    return null;
                                  },
                                  onChanged: (value){
                                    Price = value;
                                    print(Price);
                                  },
                                  //readOnly: true,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color:Color.fromARGB(255, 57, 57, 67),
                                    fontSize: 20, fontWeight:FontWeight.w500,  
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "20",
                                    hintStyle: TextStyle(
                                      color:Color.fromARGB(255, 88, 88, 100),
                                      fontSize: 20, fontWeight:FontWeight.w500,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                      ),
                    ),

            Container(
              margin: EdgeInsets.only(top:15),
              width: MediaQuery.of(context).size.width*0.8,
              child: Column(crossAxisAlignment: CrossAxisAlignment.end,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Text('التاريخ',
                //textAlign: TextAlign.right,
                style: TextStyle(
                  color: Color.fromARGB(255, 38, 38, 52),
                  fontSize:20, fontWeight: FontWeight.w600,  
                ),),
                Container(
                  padding: EdgeInsets.only(right: 14), 
                  height: 42,
                  margin: EdgeInsets.only(top:8),
                  decoration: BoxDecoration(
                    border: Border.all(
                    color: Color.fromARGB(255, 142, 142, 164),
                    width: 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          readOnly: true,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color:Color.fromARGB(255, 57, 57, 67),
                            fontSize: 20, fontWeight:FontWeight.w500,  
                          ),
                          decoration: InputDecoration(
                            hintText:DateFormat.yMd().format(_selectedDate),
                            hintStyle: TextStyle(
                              color:Color.fromARGB(255, 88, 88, 100),
                              fontSize: 20, fontWeight:FontWeight.w500,
                            ),
                            /*focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(width:0,
                              color:Color.fromARGB(255, 4, 4, 71),),
                            ),
                            enabledBorder:UnderlineInputBorder(
                              borderSide: BorderSide(width:0,
                              color:Color.fromARGB(255, 4, 4, 71),),
                            ),*/ 
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.calendar_today_outlined,
                        color:Color.fromARGB(255, 88, 88, 100),),
                          onPressed: (){
                            _getDateFromUser();
                          },
                      ),
                    ],
                  ),
                ),
              ],
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [ 
                Expanded(
                  child:Container(
                    margin: EdgeInsets.only(top:15),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.end,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Text('نهاية الحصة',
                        //textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Color.fromARGB(255, 38, 38, 52),
                          fontSize:20, fontWeight: FontWeight.w600,  
                        ),),
                        Container(
                          margin: EdgeInsets.only(top:8),
                          padding: EdgeInsets.only(right: 14),
                          height: 42,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color.fromARGB(255, 142, 142, 164),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  readOnly: true,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color:Color.fromARGB(255, 57, 57, 67),
                                    fontSize: 20, fontWeight:FontWeight.w500,  
                                  ),
                                  decoration: InputDecoration(
                                    hintText: _endTime,
                                    hintStyle: TextStyle(
                                      color:Color.fromARGB(255, 88, 88, 100),
                                      fontSize: 20, fontWeight:FontWeight.w500,
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(width:0,
                                      color:Color.fromARGB(255, 4, 4, 71),),
                                    ),
                                    enabledBorder:UnderlineInputBorder(
                                      borderSide: BorderSide(width:0,
                                      color:Color.fromARGB(255, 4, 4, 71),),
                                    ), 
                                  ),   
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.access_time_rounded,
                                color:Color.fromARGB(255, 88, 88, 100),),
                                  onPressed: (){
                                    _getTimeFromUser(isStartTime: false);
                                  },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                SizedBox(width: 20,),
                Expanded(
                  child:Container(
                    margin: EdgeInsets.only(top:15),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.end,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Text('بداية الحصة',
                        //textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Color.fromARGB(255, 38, 38, 52),
                          fontSize:20, fontWeight: FontWeight.w600,  
                        ),),
                        Container(
                          margin: EdgeInsets.only(top:8),
                          padding: EdgeInsets.only(right: 14),
                          height: 42,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color.fromARGB(255, 142, 142, 164),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  readOnly: true,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color:Color.fromARGB(255, 57, 57, 67),
                                    fontSize: 20, fontWeight:FontWeight.w500,  
                                  ),
                                  decoration: InputDecoration(
                                    hintText: _startTime,
                                    hintStyle: TextStyle(
                                      color:Color.fromARGB(255, 88, 88, 100),
                                      fontSize: 20, fontWeight:FontWeight.w500,
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(width:0,
                                      color:Color.fromARGB(255, 4, 4, 71),),
                                    ),
                                    enabledBorder:UnderlineInputBorder(
                                      borderSide: BorderSide(width:0,
                                      color:Color.fromARGB(255, 4, 4, 71),),
                                    ), 
                                  ),   
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.access_time_rounded,
                                color:Color.fromARGB(255, 88, 88, 100),),
                                  onPressed: (){
                                    _getTimeFromUser(isStartTime: true);
                                  },
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
            
            SizedBox(height:30,), 
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async{
                    insertData(Tutor, Field, Price, Date, StartTime, EndTime);
                    
                  },
                  child: Container(
                    padding: EdgeInsets.only(top:15),
                    width: 80, height:60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color:Color.fromARGB(255, 140, 14, 15),
                    ),
                    child: Text("انشاء",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color:Color.fromARGB(255, 244, 244, 248),
                      fontSize: 18, fontWeight: FontWeight.w600,
                    ),),
                  ),
                ),
              ],
            ),        
          ],
        ),
      ),
    );
  }
  _getDateFromUser() async{
    DateTime?  _pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate:DateTime(2019), lastDate:DateTime(2100),);
      if(_pickerDate != null){
       setState(() {
          _selectedDate = _pickerDate;
          //_selectedDate = DateFormat('yyyy-MM-dd').format(_pickerDate);
          print(_selectedDate);
          Date = DateFormat.yMd().format(_selectedDate).toString();
          print(Date);
       });
      }else{print("It's null or somrthing went wrong!");}
  }
  _getTimeFromUser({required bool isStartTime}) async{
    var pickedTime = await _showTimePicker();
    String _formatedTime = pickedTime.format(context);
    if(pickedTime == null){print("Time Cancled");}
    else if(isStartTime == true){
      setState(() {
        _startTime=_formatedTime;
        StartTime = _startTime.toString();
        print(_startTime);
        print("Start Time");
        print(StartTime);
      }); 
    }
    else if(isStartTime == false){
      setState((){
        _endTime=_formatedTime;
        EndTime = _endTime.toString();
        print(_endTime);
        print("End Time");
        print(EndTime);
      });
    }
  }
  _showTimePicker(){
    return showTimePicker(
      initialEntryMode:TimePickerEntryMode.input,
      context: context,
     initialTime: TimeOfDay
     (
      hour: int.parse(_startTime.split(":")[0]), 
      minute: int.parse(_startTime.split(":")[1].split(" ")[0])
      ));
  }

  void insertData(String Tutor, String Field, String Price, String Date, String StartTime, String EndTime){
    Tutor = Tutor; Price = Price;
    Field = Field; Date = Date; StartTime= StartTime; EndTime = EndTime;
    print(Tutor);
    print(Field); print(Price); print(Date); print(StartTime); print(EndTime);
    try {
                              
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      User? user = _auth.currentUser;
      CourseModel courseModel = CourseModel();
      courseModel.uid = user!.uid;
      courseModel.Tutor = Tutor;
      courseModel.Field = Field;
      courseModel.Price = Price;
      courseModel.Date = Date;
      courseModel.StartTime = StartTime;
      courseModel.EndTime = EndTime;
       firebaseFirestore.collection("courses")
      .add(courseModel.toMap());
      final snackBar = SnackBar( 
        content: Text("لقد تمت اضافة الحصة  ",
        style: const TextStyle(
          fontSize: 28, color: Color.fromARGB(255, 247, 240, 204)
        ),),
        backgroundColor: Color.fromARGB(255, 8, 1, 48),
        duration: const Duration(seconds: 5)
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.pushReplacement
        (context, MaterialPageRoute(
        builder: (context) => AddSpecificCourseTablet() ));
    } catch (e) {
      print(e);
      final snackBar = SnackBar(
        content: Text("لقد حصل خلل ما "+ e.toString(),
        style: const TextStyle(
          fontSize: 28, color: Color.fromARGB(255, 247, 204, 204)
        ),),
        backgroundColor: Color.fromARGB(255, 8, 1, 48),
        duration: const Duration(seconds: 5)
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
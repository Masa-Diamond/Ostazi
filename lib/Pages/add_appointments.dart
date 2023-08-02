// ignore_for_file: unused_import, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:grad_project/Pages/add_appoint_page.dart';
import 'package:intl/intl.dart';

import 'TutorNavBar.dart';
import 'appointments_class.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grad_project/Pages/inbox-student.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firestore = FirebaseFirestore.instance;
late User signedInUser;

class AddAppointments extends StatefulWidget {
  
  const AddAppointments({super.key});

   
  @override
  State<AddAppointments> createState() => _AddAppointmentsState();
}

class _AddAppointmentsState extends State<AddAppointments> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  DatePickerController? _datePickerController;
  //String lable = "";
  Function()? onTap;
  DateTime _selectedDate = DateTime.now() ;
  DateTime _StartDate = new DateTime(2023, 1, 1);
  DateTime _EndDate = new DateTime(2023, 6, 10);
  int interval = 7;
  //list of appointments this is just a help for the backend
  List selectedIndex = [];
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

  static List<Appointments> appointments =[
    Appointments(1,'مؤقت','2/21/2023','3:00 PM','4:00 PM',1,'يوميا'),
    Appointments(2,'مؤقت','2/24/2023','2:00 PM','3:00 PM',1,'اسبوعيا'),
    Appointments(3,'دائم','2/21/2023','1:00 PM','2:00 PM',2,'لا تكرار'),
    Appointments(4,'مؤقت','2/27/2023','7:00 PM','8:00 PM',0,'يوميا'),
    Appointments(5,'دائم','2/25/2023','5:00 PM','6:00 PM',1,'اسبوعيا'),
    Appointments(6,'مؤقت','2/22/2023','1:00 PM','2:00 PM',0,'لا تكرار'),
    Appointments(7,'دائم','2/22/2023','2:00 PM','4:00 PM',2,'يوميا'),
  ]; 
  List<Appointments> appointments_list = List.from(appointments);
  /*@override
  void initState(){
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }*/

  final _auth = FirebaseAuth.instance;
  late String Tutor;
  late String Field;
  late String Date;
  late String StartTime;
  late String EndTime;
  late String Type;
  late String Repeat;
  late String Colorr;
  @override
  void initState(){
     _tabController = TabController(length: 3, vsync: this);
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser()async{
    try {
      final user = _auth.currentUser;
      if (user != null){
      signedInUser = user;
      print(signedInUser.email);
      DocumentSnapshot ds = await FirebaseFirestore.instance.collection('tutors').doc(_auth.currentUser!.uid).get();
      Tutor = ds.get('Account');
      Field = ds.get('Field');
      }
    } catch (e) {
      print(e);
    }
  }
  DeleteData(id) async{
    await FirebaseFirestore.instance.collection('TutorsCourses').doc(id).delete();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 244, 244, 248),
      drawer: TutorNavBar(),
      appBar: AppBar(
        iconTheme: IconThemeData(size:30,color: Color.fromARGB(255, 192, 218, 240)),
        backgroundColor: Color.fromARGB(255, 4, 4, 71),
        title:
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap:(){
                    Navigator.pushReplacement(
                    context, 
                    MaterialPageRoute(builder: (context) => AddAppPage()));
                  },
                  child: Container(
                    //margin: const EdgeInsets.symmetric(horizontal:15),
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
                SizedBox(width:20,),
                Container( 
                  //margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
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

          Container(
            margin:const EdgeInsets.only(top:20, left: 20) ,
            child: DatePicker(
              controller: _datePickerController,
              DateTime.now(),
              height: 110, width: 80,
              initialSelectedDate:DateTime.now(),
              selectionColor:Color.fromARGB(255, 140, 14, 15),
              selectedTextColor:Color.fromARGB(255, 244, 244, 248),
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
          
          //List of classes
          SizedBox(height: 10,),
          StreamBuilder<QuerySnapshot>(
            stream: _firestore.collection('TutorsCourses').snapshots(),
            builder: (BuildContext context, snapshot){
              if(!snapshot.hasData){
                return Center(
                  child: Container(
                    child: Text("!لا يوجد أي حصص في هذا اليوم",
                    style: TextStyle(color: Color.fromARGB(255, 4, 1, 47), fontSize: 24, fontWeight: FontWeight.bold),),
                  ),
                );
              }
              else {
                var acc = FirebaseFirestore.instance.collection('tutors')
                .doc(FirebaseAuth.instance.currentUser!.uid).get()
                .then((value) => {
                  Tutor = value.get('Account'),});
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                      
                    itemBuilder: (context, index){
                      var data = snapshot.data!.docs[index].data() as Map<String , dynamic>;
                      if(data['Tutor'].toString() == Tutor){
                        if(data['Repeat'].toString() == 'يوميا'){
                          return AnimationConfiguration.staggeredList(
                          position: index,
                          child: SlideAnimation(
                            child: FadeInAnimation(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
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
                                            width: MediaQuery.of(context).size.width*0.9,
                                            height:MediaQuery.of(context).size.height*0.27,
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
                                                    child:Text(" الغاء الحجز ",
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
                                  }, 
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal:2,vertical: 20),
                                    margin: EdgeInsets.only(bottom: 12),
                                    width: MediaQuery.of(context).size.width*0.95,
                                    //height: MediaQuery.of(context).size.height*0.2,
                                    decoration: BoxDecoration(
                                      color: _getColor(data['Color'].toString()),
                                      borderRadius: BorderRadius.all(Radius.circular(15),),
                                      border: Border.all(width:2,color: Color.fromARGB(255, 14, 1, 36),//Color.fromARGB(255, 233, 174, 221),
                                      ),
                                      boxShadow: [BoxShadow(
                                      //color: Color.fromARGB(255, 222, 219, 242),
                                      spreadRadius: 2, blurRadius: 2,
                                      ),],

                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(Icons.access_time_rounded,
                                                color:Color.fromARGB(255, 11, 0, 49),size:27,), 
                                                SizedBox(width:7),
                                                Text(data['StartTime'],
                                                // textAlign: TextAlign.right,
                                                  style:TextStyle(
                                                  color:Color.fromARGB(255, 244, 244, 248),
                                                  fontWeight: FontWeight.w700, fontSize:16,
                                                  ) ,),
                                                SizedBox(width:2),
                                                Text('-',
                                                // textAlign: TextAlign.right,
                                                  style:TextStyle(
                                                  color:Color.fromARGB(255, 244, 244, 248),
                                                  fontWeight: FontWeight.w700, fontSize:17,
                                                  ) ,),
                                                  SizedBox(width:2),
                                                  Text(data['EndTime'],
                                                // textAlign: TextAlign.right,
                                                  style:TextStyle(
                                                  color:Color.fromARGB(255, 244, 244, 248),
                                                  fontWeight: FontWeight.w700, fontSize:16,
                                                  ) ,),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(width:7,),
                                        /*Row(
                                          children: [
                                            Icon(Icons.calendar_month,
                                            color:Color.fromARGB(255, 1, 7, 41),size:27,), 
                                            SizedBox(width:7),
                                            Text(appointments_list[index].date!,
                                            // textAlign: TextAlign.right,
                                            style:TextStyle(
                                            color:Color.fromARGB(255, 244, 244, 248),
                                            fontWeight: FontWeight.w700, fontSize:16,
                                            ) ,),
                                          ],
                                          ),*/
                                          SizedBox(width:5,),
                                          Row(
                                            children: [
                                              Text(data['Type'],
                                              style:TextStyle(
                                              color:Color.fromARGB(255, 244, 244, 248),
                                              fontWeight: FontWeight.w700, fontSize:24,
                                              )),
                                              SizedBox(width:7,),
                                              Icon(Icons.play_lesson_outlined,
                                              color:Color.fromARGB(255, 191, 194, 214),size:27,), 
                                              SizedBox(width:7),
                                            ],
                                          ),
                                      ],
                                    ),
                                  ),
                                )
                              ]),
                            ),
                            )
                          );
                        }
                        if(data['Date'] == DateFormat.yMd().format(_selectedDate).toString()){
                          return AnimationConfiguration.staggeredList(
                          position: index,
                          child: SlideAnimation(
                            child: FadeInAnimation(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                GestureDetector(
                                  onTap: ()async{
                                    showDialog(
                                      context: context,
                                      builder: (context){
                                      return Center(
                                        child: Material(
                                          type: MaterialType.transparency,
                                          child: Container(
                                            padding: const EdgeInsets.only(top:4),
                                            width: MediaQuery.of(context).size.width*0.9,
                                            height:MediaQuery.of(context).size.height*0.27,
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
                                                    child:Text(" الغاء الحجز ",
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
                                  }, 
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal:2,vertical: 20),
                                    margin: EdgeInsets.only(bottom: 12),
                                    width: MediaQuery.of(context).size.width*0.95,
                                    //height: MediaQuery.of(context).size.height*0.2,
                                    decoration: BoxDecoration(
                                      color: _getColor(data['Color'].toString()),
                                      borderRadius: BorderRadius.all(Radius.circular(15),),
                                      border: Border.all(width:2,color: Color.fromARGB(255, 14, 1, 36),//Color.fromARGB(255, 233, 174, 221),
                                      ),
                                      boxShadow: [BoxShadow(
                                      //color: Color.fromARGB(255, 222, 219, 242),
                                      spreadRadius: 2, blurRadius: 2,
                                      ),],

                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(Icons.access_time_rounded,
                                                color:Color.fromARGB(255, 11, 0, 49),size:27,), 
                                                SizedBox(width:7),
                                                Text(data['StartTime'],
                                                // textAlign: TextAlign.right,
                                                  style:TextStyle(
                                                  color:Color.fromARGB(255, 244, 244, 248),
                                                  fontWeight: FontWeight.w700, fontSize:16,
                                                  ) ,),
                                                SizedBox(width:2),
                                                Text('-',
                                                // textAlign: TextAlign.right,
                                                  style:TextStyle(
                                                  color:Color.fromARGB(255, 244, 244, 248),
                                                  fontWeight: FontWeight.w700, fontSize:17,
                                                  ) ,),
                                                  SizedBox(width:2),
                                                  Text(data['EndTime'],
                                                // textAlign: TextAlign.right,
                                                  style:TextStyle(
                                                  color:Color.fromARGB(255, 244, 244, 248),
                                                  fontWeight: FontWeight.w700, fontSize:16,
                                                  ) ,),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(width:7,),
                                          SizedBox(width:5,),
                                          Row(
                                            children: [
                                              Text(data['Type'],
                                              style:TextStyle(
                                              color:Color.fromARGB(255, 244, 244, 248),
                                              fontWeight: FontWeight.w700, fontSize:24,
                                              )),
                                              SizedBox(width:7,),
                                              Icon(Icons.play_lesson_outlined,
                                              color:Color.fromARGB(255, 191, 194, 214),size:27,), 
                                              SizedBox(width:7),

                                            ],
                                          ),
                                      ],
                                    ),
                                  ),
                                )
                              ]),
                            ),
                            )
                          );
                        }
                      }
                      return Container();
                    }
                  ),
                );
              }
            }
          ),
          /*Expanded( 
            flex: 1,
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.all(7),
              itemCount:appointments_list.length,
              itemBuilder: (_, index){
                
              /*if(appointments_list[index].Repeat=='يوميا'){
                return AnimationConfiguration.staggeredList(
                  position: index,
                   child: SlideAnimation(
                    child: FadeInAnimation(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                        GestureDetector(
                          onTap: (){
                            print(appointments_list[index].Repeat);
                             //int ID= appointments_list[index].id;
                            _showSheet(context,index);
                            /*Container(
                            //margin: const EdgeInsets.symmetric(vertical: 4),
                            padding: const EdgeInsets.only(top:4),
                            height:MediaQuery.of(context).size.height*0.24,
                            width: MediaQuery.of(context).size.width*0.9,
                            color:Color.fromARGB(255, 244, 244, 248),
                            child: Column(children: [
                              Container(
                                height: 6, width: 120,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color:Color.fromARGB(255, 209, 115, 115), 
                                ),
                                child: Row( mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                  Text("حذف",
                                  style: TextStyle(
                                    color:Color.fromARGB(255, 244, 244, 248),
                                    fontSize: 20, fontWeight: FontWeight.bold,
                                  ),),
                                ]),
                              ),
                              SizedBox(height: 10,),
                              Container(
                                height: 6, width: 120,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color:Color.fromARGB(255, 244, 244, 248),
                                  border: Border.all(width:2,color: Color.fromARGB(255, 14, 1, 36),//Color.fromARGB(255, 233, 174, 221),
                                  ), 
                                ),
                                child: Row( mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                  Text("اغلاق",
                                  style: TextStyle(
                                    color:Color.fromARGB(255, 1, 7, 41),
                                    fontSize: 20, fontWeight: FontWeight.bold,
                                  ),),
                                ]),
                              ),
                            ]),
                          );
                            print(index);*/
                          }, 
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal:2,vertical: 20),
                            margin: EdgeInsets.only(bottom: 12),
                            width: MediaQuery.of(context).size.width*0.95,
                            //height: MediaQuery.of(context).size.height*0.2,
                            decoration: BoxDecoration(
                              color: _getColor(appointments_list[index].Background),
                              borderRadius: BorderRadius.all(Radius.circular(15),),
                              border: Border.all(width:2,color: Color.fromARGB(255, 14, 1, 36),//Color.fromARGB(255, 233, 174, 221),
                              ),
                              boxShadow: [BoxShadow(
                              //color: Color.fromARGB(255, 222, 219, 242),
                              spreadRadius: 2, blurRadius: 2,
                              ),],

                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                 Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                   children: [
                                     Row(
                                       children: [
                                        Icon(Icons.access_time_rounded,
                                        color:Color.fromARGB(255, 11, 0, 49),size:27,), 
                                        SizedBox(width:7),
                                         Text(appointments_list[index].StartTime!,
                                         // textAlign: TextAlign.right,
                                          style:TextStyle(
                                          color:Color.fromARGB(255, 244, 244, 248),
                                          fontWeight: FontWeight.w700, fontSize:16,
                                          ) ,),
                                         SizedBox(width:2),
                                         Text('-',
                                         // textAlign: TextAlign.right,
                                          style:TextStyle(
                                          color:Color.fromARGB(255, 244, 244, 248),
                                          fontWeight: FontWeight.w700, fontSize:17,
                                          ) ,),
                                          SizedBox(width:2),
                                          Text(appointments_list[index].EndTime!,
                                         // textAlign: TextAlign.right,
                                          style:TextStyle(
                                          color:Color.fromARGB(255, 244, 244, 248),
                                          fontWeight: FontWeight.w700, fontSize:16,
                                          ) ,),
                                       ],
                                     ),
                                   ],
                                 ),
                                 SizedBox(width:7,),
                                 /*Row(
                                  children: [
                                    Icon(Icons.calendar_month,
                                    color:Color.fromARGB(255, 1, 7, 41),size:27,), 
                                    SizedBox(width:7),
                                    Text(appointments_list[index].date!,
                                    // textAlign: TextAlign.right,
                                    style:TextStyle(
                                    color:Color.fromARGB(255, 244, 244, 248),
                                    fontWeight: FontWeight.w700, fontSize:16,
                                    ) ,),
                                  ],
                                  ),*/
                                  SizedBox(width:5,),
                                  Row(
                                    children: [
                                      Text(appointments_list[index].Type!,
                                      style:TextStyle(
                                      color:Color.fromARGB(255, 244, 244, 248),
                                      fontWeight: FontWeight.w700, fontSize:24,
                                      )),
                                      SizedBox(width:7,),
                                      Icon(Icons.play_lesson_outlined,
                                      color:Color.fromARGB(255, 191, 194, 214),size:27,), 
                                      SizedBox(width:7),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                        )
                      ]),
                    ),
                    )
                  );}*/
              
                
                
                if(appointments_list[index].date==DateFormat.yMd().format(_selectedDate))
                {
                  return AnimationConfiguration.staggeredList(
                  position: index,
                   child: SlideAnimation(
                    child: FadeInAnimation(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                        GestureDetector(
                          onTap: (){
                            checkSelectedCard(index);
                            tapped_index = index;
                            selected(tapped_index);
                             //int ID= appointments_list[index].id;
                            _showSheet(context,index);}, 
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal:2,vertical: 20),
                            margin: EdgeInsets.only(bottom: 12),
                            width: MediaQuery.of(context).size.width*0.95,
                            //height: MediaQuery.of(context).size.height*0.2,
                            decoration: BoxDecoration(
                              color: _getColor(appointments_list[index].Background),
                              borderRadius: BorderRadius.all(Radius.circular(15),),
                              border: Border.all(width:2,color: Color.fromARGB(255, 14, 1, 36),//Color.fromARGB(255, 233, 174, 221),
                              ),
                              boxShadow: [BoxShadow(
                              //color: Color.fromARGB(255, 222, 219, 242),
                              spreadRadius: 2, blurRadius: 2,
                              ),],

                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                 Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                   children: [
                                     Row(
                                       children: [
                                        Icon(Icons.access_time_rounded,
                                        color:Color.fromARGB(255, 11, 0, 49),size:27,), 
                                        SizedBox(width:7),
                                         Text(appointments_list[index].StartTime!,
                                         // textAlign: TextAlign.right,
                                          style:TextStyle(
                                          color:Color.fromARGB(255, 244, 244, 248),
                                          fontWeight: FontWeight.w700, fontSize:16,
                                          ) ,),
                                         SizedBox(width:2),
                                         Text('-',
                                         // textAlign: TextAlign.right,
                                          style:TextStyle(
                                          color:Color.fromARGB(255, 244, 244, 248),
                                          fontWeight: FontWeight.w700, fontSize:17,
                                          ) ,),
                                          SizedBox(width:2),
                                          Text(appointments_list[index].EndTime!,
                                         // textAlign: TextAlign.right,
                                          style:TextStyle(
                                          color:Color.fromARGB(255, 244, 244, 248),
                                          fontWeight: FontWeight.w700, fontSize:16,
                                          ) ,),
                                       ],
                                     ),
                                   ],
                                 ),
                                 SizedBox(width:7,),
                                  SizedBox(width:5,),
                                  Row(
                                    children: [
                                      Text(appointments_list[index].Type!,
                                      style:TextStyle(
                                      color:Color.fromARGB(255, 244, 244, 248),
                                      fontWeight: FontWeight.w700, fontSize:24,
                                      )),
                                      SizedBox(width:7,),
                                      Icon(Icons.play_lesson_outlined,
                                      color:Color.fromARGB(255, 191, 194, 214),size:27,), 
                                      SizedBox(width:7),

                                    ],
                                  ),
                              ],
                            ),
                          ),
                        )
                      ]),
                    ),
                    )
                  );

                }else{return Container();}      
              },
            ),

          ),*/
        ],
      ),
    );
  }
  _getColor(String no){
    switch (no){
      case '0':
      return Color.fromARGB(255,140,14,15);
      case '1':
      return Color.fromARGB(255,219,168,88);
      case '2':
      return Color.fromARGB(255,71,73,115);
    }
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
          width: MediaQuery.of(context).size.width*0.9,
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
                    appointments_list.removeAt(id);
                    print(appointments_list.length);
                    //print(appointments_list[id].Repeat);
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
                  child:Text(" حذف الموعد",
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

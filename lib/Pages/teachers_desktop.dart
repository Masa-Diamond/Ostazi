// ignore_for_file: unused_import, prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:grad_project/Pages/side_bar_admin.dart';
import 'package:grad_project/Pages/students_class.dart';
import 'package:grad_project/Pages/teachers_class.dart';
import 'package:grad_project/Pages/tutor_account.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grad_project/Pages/inbox-student.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/teachers_model.dart';

final _firestore = FirebaseFirestore.instance;
late User signedInUser;


  
class TeachersDesktop extends StatefulWidget {
  const TeachersDesktop({super.key});

  @override
  State<TeachersDesktop> createState() => _TeachersDesktopState();
}

class _TeachersDesktopState extends State<TeachersDesktop> {
  List selectedIndex = [];
  DateTime _focusDate= DateTime.now();
  static List <Teachers> teachers=[
    Teachers("أيمن", "صبوح", "الفيزياء", 4.7, "0593201564", "الصلاحية", "ayman@gmail.com"),
    Teachers("حمدي", "وهبة", "الرياضيات", 3.5, "0595021430", "قدري طوقان", "hamdi@gmail.com"),
    Teachers("غسان", "الساحلي", "الكيمياء", 4.2, "0590271532", "الملك طلال", "ghasan@gmail.com"),
    Teachers("عمار", "النابلسي", "الرياضيات", 4.9, "0593201564", "سعد صايل", "ammar@gmail.com"),
    Teachers("ماسة ", "السيد", "الانجليزية", 4.3, "0560235128", "العائشية", "masa@gmail.com"),
    Teachers("ميرا ", "صايمة", "الرياضيات", 4.1, "0590532175", "كمال جنبلاط", "meera@gmail.com"),
    Teachers("فيحاء ", "البحش", "الاحياء", 3.9, "0562810326", "العائشية", "fayhaa@gmail.com"),
    Teachers("أيمن", "صبوح", "الفيزياء", 4.7, "0593201564", "الصلاحية", "ayman@gmail.com"),
    Teachers("حمدي", "وهبة", "الرياضيات", 3.5, "0595021430", "قدري طوقان", "hamdi@gmail.com"),
    Teachers("غسان", "الساحلي", "الكيمياء", 4.2, "0590271532", "الملك طلال", "ghasan@gmail.com"),
    Teachers("عمار", "النابلسي", "الرياضيات", 4.9, "0593201564", "سعد صايل", "ammar@gmail.com"),
    Teachers("ماسة ", "السيد", "الانجليزية", 4.3, "0560235128", "العائشية", "masa@gmail.com"),
    Teachers("ميرا ", "صايمة", "الرياضيات", 4.1, "0590532175", "كمال جنبلاط", "meera@gmail.com"),
    Teachers("فيحاء ", "البحش", "الاحياء", 3.9, "0562810326", "العائشية", "fayhaa@gmail.com"),
    Teachers("أيمن", "صبوح", "الفيزياء", 4.7, "0593201564", "الصلاحية", "ayman@gmail.com"),
    Teachers("حمدي", "وهبة", "الرياضيات", 3.5, "0595021430", "قدري طوقان", "hamdi@gmail.com"),
    Teachers("غسان", "الساحلي", "الكيمياء", 4.2, "0590271532", "الملك طلال", "ghasan@gmail.com"),
    Teachers("عمار", "النابلسي", "الرياضيات", 4.9, "0593201564", "سعد صايل", "ammar@gmail.com"),
    Teachers("ماسة ", "السيد", "الانجليزية", 4.3, "0560235128", "العائشية", "masa@gmail.com"),
    Teachers("ميرا ", "صايمة", "الرياضيات", 4.1, "0590532175", "كمال جنبلاط", "meera@gmail.com"),
    Teachers("فيحاء ", "البحش", "الاحياء", 3.9, "0562810326", "العائشية", "fayhaa@gmail.com"),
    Teachers("أيمن", "صبوح", "الفيزياء", 4.7, "0593201564", "الصلاحية", "ayman@gmail.com"),
    Teachers("حمدي", "وهبة", "الرياضيات", 3.5, "0595021430", "قدري طوقان", "hamdi@gmail.com"),
    Teachers("غسان", "الساحلي", "الكيمياء", 4.2, "0590271532", "الملك طلال", "ghasan@gmail.com"),
    Teachers("عمار", "النابلسي", "الرياضيات", 4.9, "0593201564", "سعد صايل", "ammar@gmail.com"),
    Teachers("ماسة ", "السيد", "الانجليزية", 4.3, "0560235128", "العائشية", "masa@gmail.com"),
    Teachers("ميرا ", "صايمة", "الرياضيات", 4.1, "0590532175", "كمال جنبلاط", "meera@gmail.com"),
    Teachers("فيحاء ", "البحش", "الاحياء", 3.9, "0562810326", "العائشية", "fayhaa@gmail.com"),
  ];
  
  List<Teachers> teachers_list = List.from(teachers);
  

  void updateList(String value){
    setState(() {
      teachers_list= teachers.where((element) => element.FirstName!.toLowerCase().contains(value.toLowerCase()
      )).toList();
      print(teachers_list.length);
      /*students= students.where((element) => element.Lastname!.toLowerCase().contains(value.toLowerCase()
      )).toList();
      students= students.where((element) => element.Account!.toLowerCase().contains(value.toLowerCase()
      )).toList();*/
    });
   }
  @override
  final _auth = FirebaseAuth.instance;
  
  //final TutorsCollection = _firestore.collection("tutors");
  final TutorsList = _firestore.collection("tutors").snapshots().map((snapshot) {
    return snapshot.docs.map((doc) => TutorrModel.fromMap(doc.data())).toList();
  });
  

   String TutorAccount='';
   Future<QuerySnapshot>? tutorDocumentList;
   SearchBar(String textEntered){
    tutorDocumentList = FirebaseFirestore.instance.collection('tutors')
    .where("Account",isGreaterThanOrEqualTo: textEntered)
    .get();
    setState(() {
      tutorDocumentList;
      //print();
    });
   }

String dataToChange= 'اخفاء';
int flag=0;
void changedata(int index){
  setState((){
    if (flag ==0){
      dataToChange ='الغاء';
      flag =1;
    }
    else {dataToChange= 'اخفاء'; flag=0;}
    
  });
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
  
   List <Object> _AllTutors = [];
  Widget build(BuildContext context) {
    final currentwidth=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor:Color.fromARGB(255, 244, 244, 248),
      /*appBar: AppBar(elevation:3,
        backgroundColor:Color.fromARGB(255, 218, 217, 179),
      ),*/
      // ignore: prefer_const_literals_to_create_immutables
      body:Row(children:[
        
        SideBar(),
        //Text(currentwidth.toString()),
        //rest of the body
        
        Expanded(flex:3,
          child:Container(
            margin: EdgeInsets.all(15),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                color:Color.fromARGB(255, 244, 244, 248),
                borderRadius: BorderRadius.circular(30),
                // ignore: prefer_const_literals_to_create_immutables
                boxShadow: [BoxShadow(
                color: Color.fromARGB(255, 219, 222, 245),
                spreadRadius: 1, blurRadius: 1,
                ),],
                ),
                
            child: Column(
            children: [
              
              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.all(7),
                width: MediaQuery.of(context).size.width*0.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: TextField(
                  onChanged: (textEntered) {
                    setState(() {
                      TutorAccount = textEntered;
                    });
                   // SearchBar(textEntered);
                  },
                  //onChanged: (value) => updateList(value),
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: "ابحث عن اسم أستاذ هنا",
                    hintStyle: TextStyle(color: Color.fromARGB(255, 93, 93, 123),),
                    filled: true,
                    fillColor: Color.fromARGB(255, 226, 226, 248),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(width: 4,color:Color.fromARGB(255, 4, 4, 71), ),
                    ),
                    prefixIcon: IconButton(
                    icon : Icon(Icons.search_rounded,size: 30,color:Color.fromARGB(255, 4, 4, 71),),
                     onPressed: (){
                      SearchBar(TutorAccount);
                      
                     },
                    ),
                  )
                ),
              ),
              SizedBox(height: 40,),
          
              StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('tutors').snapshots(),
                builder: (BuildContext context, snapshot){//AsyncSnapshot<QuerySnapshot> snapshot
                  if(!snapshot.hasData){
                    return Center(
                      child: Container(
                        child: Text("لا يوجد أي أساتذة ",
                        style: TextStyle(color: Color.fromARGB(255, 4, 1, 47), fontSize: 24, fontWeight: FontWeight.bold),),
                      ),
                    );
                  }
                  return Expanded(
                    child:
                     ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      
                      itemBuilder: (context, index) {
                        var data = snapshot.data!.docs[index].data() as Map<String , dynamic>;
                        if(TutorAccount.isEmpty){
                          /*return ListView(
                            shrinkWrap: true,
                            padding: EdgeInsets.all(10),
                            children: snapshot.data!.docs.map((document){
                              return Row(mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      setState(() { 
                                       _showSheet(context,index);
                                      });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.all(10),
                                      width: MediaQuery.of(context).size.width*0.5,
                                      padding: EdgeInsets.symmetric(horizontal:2,vertical:15),
                                      decoration:BoxDecoration(
                                        color: Color.fromARGB(255, 218, 217, 217),
                                        borderRadius:BorderRadius.circular(15)
                                      ),
                                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Column(mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(15),
                                                  color: Color.fromARGB(255, 18, 2, 61),
                                                ),
                                                child:Row(mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons.delete_forever_rounded,color:Color.fromARGB(255, 226, 226, 248),),
                                                    SizedBox(width: 2,),
                                                    Text("اخفاء",
                                                    style:TextStyle(
                                                      color:Color.fromARGB(255, 226, 226, 248),
                                                      fontWeight: FontWeight.bold 
                                                    ),),
                                                  ], 
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(width: 50,),
                                          Column(mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(document['School'],
                                                  style:TextStyle(
                                                    color:Color.fromARGB(255, 4, 4, 71),
                                                    fontSize:16, fontWeight: FontWeight.w500
                                                  ),),
                                                  SizedBox(width: 10,),
                                                  Text(":المدرسة",
                                                  style:TextStyle(
                                                    color:Color.fromARGB(255, 4, 4, 71),
                                                    fontSize:16, fontWeight: FontWeight.w500
                                                  ),),
                                                  SizedBox(height: 10,),
                                                  Row(
                                                    children: [
                                                      Text(document['Rating'],
                                                      style:TextStyle(
                                                        color:Color.fromARGB(255, 4, 4, 71),
                                                        fontSize:16, fontWeight: FontWeight.w500
                                                      ),),
                                                      SizedBox(width: 5,),
                                                      Icon(Icons.star,color: Colors.amber[400],),
                                                      Icon(Icons.star,color: Colors.amber[400],),
                                                      Icon(Icons.star,color: Colors.amber[400],),
                                                      Icon(Icons.star,color: Colors.amber[400],),
                                                      Icon(Icons.star,color: Colors.amber[400],),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(width: 50,),
                                          Column(mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(document['LastName'],
                                                  style:TextStyle(
                                                    color:Color.fromARGB(255, 4, 4, 71),
                                                    fontSize: 20, fontWeight: FontWeight.w700 
                                                  ),),
                                                  SizedBox(width: 3,),
                                                  Text(document['FirstName'],
                                                  style:TextStyle(
                                                    color:Color.fromARGB(255, 4, 4, 71),
                                                    fontSize: 20, fontWeight: FontWeight.w700  
                                                  ),),
                                                ],
                                              ),
                                              SizedBox(height: 5,),
                                                  Row(
                                                    children: [
                                                      Text(document['Field'],
                                                      style:TextStyle(
                                                        color:Color.fromARGB(255, 4, 4, 71),
                                                        fontSize:16, fontWeight: FontWeight.w500
                                                      ),),
                                                      SizedBox(width: 5,),
                                                      Icon(Icons.account_box,
                                                      color:Color.fromARGB(255, 4, 4, 71),
                                                      ),
                                                    ],
                                                  ),
                                              SizedBox(height: 5,),
                                              Row(
                                                children: [
                                                  Text(document['email'],
                                                  style:TextStyle(
                                                    color:Color.fromARGB(255, 4, 4, 71),
                                                    fontSize:16, fontWeight: FontWeight.w500
                                                  ),),
                                                  SizedBox(width: 5,),
                                                  Icon(Icons.email_outlined,
                                                  color:Color.fromARGB(255, 4, 4, 71),
                                                  ),
                                                ], 
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                          );*/
                          return Center(
                            child: Container(
                              margin: EdgeInsets.all(10),
                              width: MediaQuery.of(context).size.width*0.5,
                              padding: EdgeInsets.symmetric(horizontal:2,vertical:15),
                              decoration:BoxDecoration(
                                color: Color.fromARGB(255, 218, 217, 217),
                                borderRadius:BorderRadius.circular(15)
                              ),
                              child: ListTile(
                                trailing: Text(data['Account'],
                                style: TextStyle(color:Color.fromARGB(255, 9, 1, 44), fontSize:20, fontWeight:FontWeight.bold),),
                                title: Row(
                                  children: [
                                    SizedBox(width:50,),
                                    Row(
                                      children: [
                                        Text(data['Field'],
                                        style:TextStyle(
                                          color:Color.fromARGB(255, 4, 4, 71),
                                          fontSize:16, fontWeight: FontWeight.w500
                                        ),),
                                        SizedBox(width: 5,),
                                        Icon(Icons.account_box,
                                        color:Color.fromARGB(255, 4, 4, 71),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width:100,),
                                    Row(
                                      children: [
                                        Text(data['email'],
                                        style: TextStyle(color:Color.fromARGB(255, 9, 1, 44), fontSize:16, fontWeight:FontWeight.w500)),
                                        SizedBox(width: 10,),
                                        Icon(Icons.email_outlined,
                                        color:Color.fromARGB(255, 4, 4, 71),
                                        ),
                                      ],
                                    ),
                                    
                                  ],
                                ),
                                subtitle: Row(
                                  children: [
                                    SizedBox(width:50,),
                                    Text(data['School'],
                                    style:TextStyle(
                                      color:Color.fromARGB(255, 4, 4, 71),
                                      fontSize:16, fontWeight: FontWeight.w500
                                    ),),
                                    SizedBox(width: 10,),
                                    Text(":المدرسة",
                                    style:TextStyle(
                                      color:Color.fromARGB(255, 4, 4, 71),
                                      fontSize:16, fontWeight: FontWeight.w500
                                    ),),
                                    SizedBox(width: 100,),
                                    Row(
                                      children: [
                                        Text(data['Rating'],
                                        style:TextStyle(
                                          color:Color.fromARGB(255, 4, 4, 71),
                                          fontSize:16, fontWeight: FontWeight.w500
                                        ),),
                                        SizedBox(width: 5,),
                                        Icon(Icons.star,color: Colors.amber[400],),
                                        Icon(Icons.star,color: Colors.amber[400],),
                                        Icon(Icons.star,color: Colors.amber[400],),
                                        Icon(Icons.star,color: Colors.amber[400],),
                                        Icon(Icons.star,color: Colors.amber[400],),
                                      ]
                                    ),     
                                    
                                  ],
                                ),
                                
                                leading: GestureDetector(
                                  onTap: (){
                                    print(index);
                                     _showSheet(context,index);
                                    //selected(index);                                
                                  },
                                  child: Container(
                                      width:90, height: 70,
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color:selectedIndex.contains(index) ?Color.fromARGB(255, 194, 16, 3):Color.fromARGB(255, 18, 2, 61),
                                      ),
                                      child:Row(mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          selectedIndex.contains(index) ?
                                          Icon(Icons.close_rounded,color:Color.fromARGB(255, 226, 226, 248),):
                                          Icon(Icons.hide_source_rounded,color:Color.fromARGB(255, 226, 226, 248),),
                                          SizedBox(width: 2,),
                                          Text(selectedIndex.contains(index) ?'الغاء':'اخفاء',
                                          style:TextStyle(
                                            color:Color.fromARGB(255, 226, 226, 248),
                                            fontWeight: FontWeight.bold 
                                          ),),
                                        ], 
                                      ),
                                  ),
                                ) ,
                              ),
                            ),
                          );
                        }
                        if(data['Account'].toString().toLowerCase().startsWith(TutorAccount.toLowerCase())){
                          
                          return Center(
                            child: Container(
                              margin: EdgeInsets.all(10),
                              width: MediaQuery.of(context).size.width*0.5,
                              padding: EdgeInsets.symmetric(horizontal:2,vertical:15),
                              decoration:BoxDecoration(
                                color: Color.fromARGB(255, 218, 217, 217),
                                borderRadius:BorderRadius.circular(15)
                              ),
                              child: ListTile(
                                trailing: Text(data['Account'],
                                style: TextStyle(color:Color.fromARGB(255, 9, 1, 44), fontSize:20, fontWeight:FontWeight.bold),),
                                title: Row(
                                  children: [
                                    SizedBox(width:50,),
                                    Row(
                                      children: [
                                        Text(data['Field'],
                                        style:TextStyle(
                                          color:Color.fromARGB(255, 4, 4, 71),
                                          fontSize:16, fontWeight: FontWeight.w500
                                        ),),
                                        SizedBox(width: 5,),
                                        Icon(Icons.account_box,
                                        color:Color.fromARGB(255, 4, 4, 71),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width:100,),
                                    Row(
                                      children: [
                                        Text(data['email'],
                                        style: TextStyle(color:Color.fromARGB(255, 9, 1, 44), fontSize:16, fontWeight:FontWeight.w500)),
                                        SizedBox(width: 10,),
                                        Icon(Icons.email_outlined,
                                        color:Color.fromARGB(255, 4, 4, 71),
                                        ),
                                      ],
                                    ),
                                    
                                  ],
                                ),
                                subtitle: Row(
                                  children: [
                                    SizedBox(width:50,),
                                    Text(data['School'],
                                    style:TextStyle(
                                      color:Color.fromARGB(255, 4, 4, 71),
                                      fontSize:16, fontWeight: FontWeight.w500
                                    ),),
                                    SizedBox(width: 10,),
                                    Text(":المدرسة",
                                    style:TextStyle(
                                      color:Color.fromARGB(255, 4, 4, 71),
                                      fontSize:16, fontWeight: FontWeight.w500
                                    ),),
                                    SizedBox(width: 100,),
                                    Row(
                                      children: [
                                        Text(data['Rating'],
                                        style:TextStyle(
                                          color:Color.fromARGB(255, 4, 4, 71),
                                          fontSize:16, fontWeight: FontWeight.w500
                                        ),),
                                        SizedBox(width: 5,),
                                        Icon(Icons.star,color: Colors.amber[400],),
                                        Icon(Icons.star,color: Colors.amber[400],),
                                        Icon(Icons.star,color: Colors.amber[400],),
                                        Icon(Icons.star,color: Colors.amber[400],),
                                        Icon(Icons.star,color: Colors.amber[400],),
                                      ]
                                    ),     
                                    
                                  ],
                                ),
                                
                                leading: GestureDetector(
                                  onTap: (){
                                    print(index);
                                    _showSheet(context,index);
                                    //selected(index);
                                  },
                                  child: Container(
                                      width:90, height: 70,
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color:selectedIndex.contains(index) ?Color.fromARGB(255, 194, 16, 3):Color.fromARGB(255, 18, 2, 61),
                                      ),
                                      child:Row(mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          selectedIndex.contains(index) ?
                                          Icon(Icons.close_rounded,color:Color.fromARGB(255, 226, 226, 248),):
                                          Icon(Icons.hide_source_rounded,color:Color.fromARGB(255, 226, 226, 248),),
                                          SizedBox(width: 2,),
                                          Text(selectedIndex.contains(index) ?'الغاء':'اخفاء',
                                          style:TextStyle(
                                            color:Color.fromARGB(255, 226, 226, 248),
                                            fontWeight: FontWeight.bold 
                                          ),),
                                        ], 
                                      ),
                                  ),
                                ) ,
                              ),
                            ),
                          );
                          
                        }
                       return Container();
                      },
          
                     ),
                  );
                }
              ),
              
              //List
              
            ],
                  ),
          )),
        
        Expanded(
          child:Container(
            //color: Colors.amber[100],
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  //color: Color.fromARGB(255,140, 14, 15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("${DateFormat("MMM, yyy").format(_focusDate)}",
                          style:TextStyle(
                          color: Color.fromARGB(255, 1, 24, 43),
                          fontSize:20, fontWeight: FontWeight.bold
                        ),),
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
              )
            ],
        ),
          ))
      ]),
    );
  }

  Future GetTutorsInfo () async{
    var data = await FirebaseFirestore.instance
    .collection('tutors').doc().get();
   /* setState(() {
      _AllTutors = List.from(
        data.docs.map((document) => TutorrModel.fromSnapshot(document) ));
    });*/
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
                    /*teachers_list.removeAt(id);
                    print(teachers_list.length);*/
                    //print(appointments_list[id].Repeat);
                    selected(id); 
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
                  child:Text("اخفاء الأستاذ ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                    color:Color.fromARGB(255, 244, 244, 248),
                    fontSize: 20, fontWeight: FontWeight.bold,
                    ),),
                ),
              ),
              GestureDetector(
                onTap: (){
                  selected(id);
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

/*class TutorsListStream extends StatefulWidget {
  const TutorsListStream({super.key});

  @override
  State<TutorsListStream> createState() => _TutorsListStreamState();
}

class _TutorsListStreamState extends State<TutorsListStream> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('tutors').snapshots(),
      builder: (context,snapshot){}
    );
  }
}*/

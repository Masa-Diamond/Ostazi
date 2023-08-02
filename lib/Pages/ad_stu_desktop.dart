// ignore_for_file: unused_import, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:grad_project/Pages/side_bar_admin.dart';
import 'package:grad_project/Pages/students_class.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grad_project/Pages/inbox-student.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/teachers_model.dart';


final _firestore = FirebaseFirestore.instance;
late User signedInUser;
class StuDesktop extends StatefulWidget {
  const StuDesktop({super.key});

  @override
  State<StuDesktop> createState() => _StuDesktopState();
}

class _StuDesktopState extends State<StuDesktop> {
  List selectedIndex = [];
  DateTime _focusDate= DateTime.now();
  static List <Students> students=[
    Students("أمل", "جهاد", "امل_جهاد", "التوجيهي", "العائشيه", "amal@gmail.com"),
    Students("محمد", "نابلسي", "محمدزنابلسي", "العاشر", "الاسلاميه", "mhmd@gmail.com"),
    Students("عمر", "أغبر", "عمر_أغبر", "الاول ثانوي", "الصلاحية", "omar@gmail.com"),
    Students("اياد", "جاموس", "جاموس-اياد", "التوجيهي", "العائشيه", "eyaad@gmail.com"),
    Students("علا", "سايح", "علا^سايح", "الاول ثانوي", "العائشيه", "ola@gmail.com"),
    Students("ولاء","خباص", "خباص*ولاء", "العاشر", "كمال جنبلاط", "walaa@gmail.com"),
    Students("رمز", "بسطامي", "رمز بسطامي", "التوجيهي", "الطلائع", "ramz@gmail.com"),
    Students("مازن", "عبد القادر", "مازن_عبد","الاول ثانوي", "اكادمية القران", "mazn@gmail.com"),
    Students("احمد", "قادري", "احمد قادري", "التوجيهي", "الصلاحية", "ahmd@gmail.com"),
    Students("جنى", "هاني", "جنى_هاني", "التوجيهي", "كمال جنبلاط", "jana@gmail.com"),
    Students("أسعد", "كمال", "كمال-اسعد","الاول ثانوي", "الاسلاميه", "asaad@gmail.com"),
    Students("لمى", "أحمد", "لمى أحمد", "التوجيهي", "جمال عبد الناصر", "lama@gmail.com"),
    Students("أمل", "جهاد", "امل_جهاد", "التوجيهي", "العائشيه", "amal@gmail.com"),
    Students("محمد", "نابلسي", "محمدزنابلسي", "العاشر", "الاسلاميه", "mhmd@gmail.com"),
    Students("عمر", "أغبر", "عمر_أغبر", "الاول ثانوي", "الصلاحية", "omar@gmail.com"),
    Students("اياد", "جاموس", "جاموس-اياد", "التوجيهي", "العائشيه", "eyaad@gmail.com"),
    Students("علا", "سايح", "علا^سايح", "الاول ثانوي", "العائشيه", "ola@gmail.com"),
    Students("ولاء","خباص", "خباص*ولاء", "العاشر", "كمال جنبلاط", "walaa@gmail.com"),
    Students("رمز", "بسطامي", "رمز بسطامي", "التوجيهي", "الطلائع", "ramz@gmail.com"),
    Students("مازن", "عبد القادر", "مازن_عبد","الاول ثانوي", "اكادمية القران", "mazn@gmail.com"),
    Students("احمد", "قادري", "احمد قادري", "التوجيهي", "الصلاحية", "ahmd@gmail.com"),
    Students("جنى", "هاني", "جنى_هاني", "التوجيهي", "كمال جنبلاط", "jana@gmail.com"),
    Students("أسعد", "كمال", "كمال-اسعد","الاول ثانوي", "الاسلاميه", "asaad@gmail.com"),
    Students("لمى", "أحمد", "لمى أحمد", "التوجيهي", "جمال عبد الناصر", "lama@gmail.com"),
    Students("أمل", "جهاد", "امل_جهاد", "التوجيهي", "العائشيه", "amal@gmail.com"),
    Students("محمد", "نابلسي", "محمدزنابلسي", "العاشر", "الاسلاميه", "mhmd@gmail.com"),
    Students("عمر", "أغبر", "عمر_أغبر", "الاول ثانوي", "الصلاحية", "omar@gmail.com"),
    Students("اياد", "جاموس", "جاموس-اياد", "التوجيهي", "العائشيه", "eyaad@gmail.com"),
    Students("علا", "سايح", "علا^سايح", "الاول ثانوي", "العائشيه", "ola@gmail.com"),
    Students("ولاء","خباص", "خباص*ولاء", "العاشر", "كمال جنبلاط", "walaa@gmail.com"),
    Students("رمز", "بسطامي", "رمز بسطامي", "التوجيهي", "الطلائع", "ramz@gmail.com"),
    Students("مازن", "عبد القادر", "مازن_عبد","الاول ثانوي", "اكادمية القران", "mazn@gmail.com"),
    Students("احمد", "قادري", "احمد قادري", "التوجيهي", "الصلاحية", "ahmd@gmail.com"),
    Students("جنى", "هاني", "جنى_هاني", "التوجيهي", "كمال جنبلاط", "jana@gmail.com"),
    Students("أسعد", "كمال", "كمال-اسعد","الاول ثانوي", "الاسلاميه", "asaad@gmail.com"),
    Students("لمى", "أحمد", "لمى أحمد", "التوجيهي", "جمال عبد الناصر", "lama@gmail.com"),
  ];
  
  List<Students> students_list = List.from(students);
  void updateList(String value){
    setState(() {
      students_list= students.where((element) => element.Firstname!.toLowerCase().contains(value.toLowerCase()
      )).toList();
      /*students= students.where((element) => element.Lastname!.toLowerCase().contains(value.toLowerCase()
      )).toList();
      students= students.where((element) => element.Account!.toLowerCase().contains(value.toLowerCase()
      )).toList();*/
    });
   }
   
  @override
  final _auth = FirebaseAuth.instance;
   String StudentAccount='';
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
  Widget build(BuildContext context) {
    final currentwidth=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor:Color.fromARGB(255, 244, 244, 248),
      /*appBar: AppBar(elevation:3,
        backgroundColor:Color.fromARGB(255, 218, 217, 179),
      ),*/
      // ignore: prefer_const_literals_to_create_immutables
      body:Row(children:[
        //open Drawer
        
        SideBar(),
        //Text(currentwidth.toString()),
        //rest of the body
        
        Expanded(flex:3,
          child:Column(
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
                    StudentAccount = textEntered;
                  });
                 // SearchBar(textEntered);
                },
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  hintText: "ابحث عن اسم طالب هنا",
                  hintStyle: TextStyle(color: Color.fromARGB(255, 93, 93, 123),),
                  filled: true,
                  fillColor: Color.fromARGB(255, 226, 226, 248),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(width: 4,color:Color.fromARGB(255, 4, 4, 71), ),
                  ),
                  prefixIcon: Icon(Icons.search_rounded,size: 30,color:Color.fromARGB(255, 4, 4, 71),),
                )
              ),
            ),
            SizedBox(height: 40,),
            //List
            StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('users').snapshots(),
              builder:(BuildContext context, snapshot){
                if(!snapshot.hasData){
                  return Center(
                    child: Container(
                      child: Text("لا يوجد أي أساتذة ",
                      style: TextStyle(color: Color.fromARGB(255, 4, 1, 47), fontSize: 24, fontWeight: FontWeight.bold),),
                    ),
                  );
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    
                    itemBuilder: (context, index){
                      var data = snapshot.data!.docs[index].data() as Map<String , dynamic>;
                      if(StudentAccount.isEmpty){
                        return Center(
                          child: Container(
                            margin: EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width*0.55,
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
                                      Text(data['School'],
                                      style:TextStyle(
                                        color:Color.fromARGB(255, 4, 4, 71),
                                        fontSize:16, fontWeight: FontWeight.w500
                                      ),),
                                      SizedBox(width: 5,),
                                      Text(":المدرسة",
                                      style:TextStyle(
                                        color:Color.fromARGB(255, 4, 4, 71),
                                        fontSize:16, fontWeight: FontWeight.w500
                                      ),),
                                    ],
                                  ),
                                  SizedBox(width:150,),
                                  Row(
                                    children: [
                                      Text(data['Grade'],
                                      style:TextStyle(
                                        color:Color.fromARGB(255, 4, 4, 71),
                                        fontSize:16, fontWeight: FontWeight.w500
                                      ),),
                                      SizedBox(width: 5,),
                                      Text(":الصف",
                                      style:TextStyle(
                                        color:Color.fromARGB(255, 4, 4, 71),
                                        fontSize:16, fontWeight: FontWeight.w500
                                      ),),
                                    ],
                                  ),                                  
                                ],
                              ),
                              subtitle: Row(
                                children: [
                                  SizedBox(width:50,),
                                  Row(
                                    children: [
                                      Text(data['LastName'],
                                      style:TextStyle(
                                        color:Color.fromARGB(255, 4, 4, 71),
                                        fontSize: 16, fontWeight: FontWeight.w500 
                                      ),),
                                      SizedBox(width: 3,),
                                      Text(":الاسم الثاني",
                                      style:TextStyle(
                                        color:Color.fromARGB(255, 4, 4, 71),
                                        fontSize:16, fontWeight: FontWeight.w500
                                      ),),
                                    ],
                                  ),
                                  SizedBox(width:10,),
                                  Row(
                                    children: [
                                      Text(data['FirstName'],
                                      style:TextStyle(
                                        color:Color.fromARGB(255, 4, 4, 71),
                                        fontSize: 16, fontWeight: FontWeight.w500  
                                      ),),
                                      SizedBox(width: 3,),
                                      Text(":الاسم الأول",
                                      style:TextStyle(
                                        color:Color.fromARGB(255, 4, 4, 71),
                                        fontSize:16, fontWeight: FontWeight.w500
                                      ),),
                                    ]
                                  ),
                                  SizedBox(width:50,),
                                  Row(
                                    children: [
                                      Text(data['email'],
                                      style:TextStyle(
                                        color:Color.fromARGB(255, 4, 4, 71),
                                        fontSize:16, fontWeight: FontWeight.w500
                                      ),),
                                      SizedBox(width: 5,),
                                      Icon(Icons.email_outlined,
                                      color:Color.fromARGB(255, 4, 4, 71),
                                      ),
                                    ]
                                  ),  
                                ],
                              ),
                              leading: GestureDetector(
                                onTap: (){
                                  print(index);
                                  selected(index);
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
                      if(data['Account'].toString().toLowerCase().startsWith(StudentAccount.toLowerCase())){
                        return Center(
                          child: Container(
                            margin: EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width*0.55,
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
                                      Text(data['School'],
                                      style:TextStyle(
                                        color:Color.fromARGB(255, 4, 4, 71),
                                        fontSize:16, fontWeight: FontWeight.w500
                                      ),),
                                      SizedBox(width: 5,),
                                      Text(":المدرسة",
                                      style:TextStyle(
                                        color:Color.fromARGB(255, 4, 4, 71),
                                        fontSize:16, fontWeight: FontWeight.w500
                                      ),),
                                    ],
                                  ),
                                  SizedBox(width:150,),
                                  Row(
                                    children: [
                                      Text(data['Grade'],
                                      style:TextStyle(
                                        color:Color.fromARGB(255, 4, 4, 71),
                                        fontSize:16, fontWeight: FontWeight.w500
                                      ),),
                                      SizedBox(width: 5,),
                                      Text(":الصف",
                                      style:TextStyle(
                                        color:Color.fromARGB(255, 4, 4, 71),
                                        fontSize:16, fontWeight: FontWeight.w500
                                      ),),
                                    ],
                                  ),                                  
                                ],
                              ),
                              subtitle: Row(
                                children: [
                                  SizedBox(width:50,),
                                  Row(
                                    children: [
                                      Text(data['LastName'],
                                      style:TextStyle(
                                        color:Color.fromARGB(255, 4, 4, 71),
                                        fontSize: 16, fontWeight: FontWeight.w500 
                                      ),),
                                      SizedBox(width: 3,),
                                      Text(":الاسم الثاني",
                                      style:TextStyle(
                                        color:Color.fromARGB(255, 4, 4, 71),
                                        fontSize:16, fontWeight: FontWeight.w500
                                      ),),
                                    ],
                                  ),
                                  SizedBox(width:10,),
                                  Row(
                                    children: [
                                      Text(data['FirstName'],
                                      style:TextStyle(
                                        color:Color.fromARGB(255, 4, 4, 71),
                                        fontSize: 16, fontWeight: FontWeight.w500  
                                      ),),
                                      SizedBox(width: 3,),
                                      Text(":الاسم الأول",
                                      style:TextStyle(
                                        color:Color.fromARGB(255, 4, 4, 71),
                                        fontSize:16, fontWeight: FontWeight.w500
                                      ),),
                                    ]
                                  ),
                                  SizedBox(width:50,),
                                  Row(
                                    children: [
                                      Text(data['email'],
                                      style:TextStyle(
                                        color:Color.fromARGB(255, 4, 4, 71),
                                        fontSize:16, fontWeight: FontWeight.w500
                                      ),),
                                      SizedBox(width: 5,),
                                      Icon(Icons.email_outlined,
                                      color:Color.fromARGB(255, 4, 4, 71),
                                      ),
                                    ]
                                  ),  
                                ],
                              ),
                              leading: GestureDetector(
                                onTap: (){
                                  print(index);
                                  selected(index);
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
                    }
                  ),
                );
                
              } ,
            ),        
          ],
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
                    students_list.removeAt(id);
                    print(students_list.length);
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
                  child:Text("حظر الطالب ",
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

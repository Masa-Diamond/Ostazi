// ignore_for_file: unused_import, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:grad_project/Pages/side_bar_admin.dart';
import 'package:grad_project/Pages/students_class.dart';
import 'package:grad_project/Pages/teachers_class.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grad_project/Pages/inbox-student.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/teachers_model.dart';


final _firestore = FirebaseFirestore.instance;
late User signedInUser;

class TeachersTablet extends StatefulWidget {
  const TeachersTablet({super.key});

  @override
  State<TeachersTablet> createState() => _TeachersTabletState();
}

class _TeachersTabletState extends State<TeachersTablet> {
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
    });
   }
  @override
  final _auth = FirebaseAuth.instance;
  
  //final TutorsCollection = _firestore.collection("tutors");
  final TutorsList = _firestore.collection("tutors").snapshots().map((snapshot) {
    return snapshot.docs.map((doc) => TutorrModel.fromMap(doc.data())).toList();
  });
  
  String? messageText;
  String TutorAccount='';
   // this will give us the message that was sent
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
          //SizedBox(width:300,),
          Text(DateFormat.yMd().format(_focusDate),
          style:TextStyle(
            color:Color.fromARGB(255, 247, 227, 74),
            fontWeight: FontWeight.bold 
          ),)           
          ],),
      ),
      body:Column(
        children: [Container(
          padding: EdgeInsets.all(7),
          width: MediaQuery.of(context).size.width*0.8,
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
            prefixIcon: Icon(Icons.search_rounded,size: 30,color:Color.fromARGB(255, 4, 4, 71),),
            )
          ),
        ),
        SizedBox(height: 10,),
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
                        return Center(
                          child: Container(
                            margin: EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width*0.9,
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
                      if(data['Account'].toString().toLowerCase().startsWith(TutorAccount.toLowerCase())){
                        /*return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder:(context, index) {
                            print(snapshot.data!.docs.length);
                            return Container(
                              child: Text(data['LastName']),
                            );
                          }
                        );*/
                        return Center(
                          child: Container(
                            margin: EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width*0.9,
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
                                  SizedBox(width:100,),
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
                                  SizedBox(width:200,),
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
                                  SizedBox(width:100,),
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
                                  SizedBox(width: 200,),
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
                    },

                   ),
                );
              }
            ),
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
                    teachers_list.removeAt(id);
                    print(teachers_list.length);
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
                  child:Text("حظر المعلم ",
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
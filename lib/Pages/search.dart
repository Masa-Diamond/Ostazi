// ignore_for_file: unused_import, camel_case_types, prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:grad_project/Pages/NavBar.dart';
import 'package:grad_project/Pages/acoount.dart';
import 'package:grad_project/Pages/home.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:grad_project/Pages/student_reg_atutor.dart';
import 'package:grad_project/Pages/tutors_class.dart';
import 'package:searchable_listview/searchable_listview.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grad_project/Pages/inbox-student.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firestore = FirebaseFirestore.instance;
late User signedInUser;

class searchStu extends StatefulWidget {
  const searchStu({super.key});

  @override
  State<searchStu> createState() => _searchStuState();
}

class _searchStuState extends State<searchStu> {
  //int index=1;
  List selectedIndex = [];
  static List<TutorModel> tutors = [
    TutorModel( 'أيمن','صبوح','فيزياء', 30,10.0),
    TutorModel( 'عمار','النابلسي','رياضيات', 30,10.0),
    TutorModel( 'غسان','الساحلي','كيمياء', 30,8.2),
    TutorModel( 'ماسة ', 'السيد','الانجليزيه', 30,9.1),
    TutorModel( 'فيحاء','البحش','احياء', 30,8.1),
    TutorModel( 'ميرا','صايمه','رياضيات', 30,9.5),
    TutorModel( 'حمدي','وهبة','رياضيات', 30,7.5),
  ];
   List<TutorModel> display_list = List.from(tutors);

   void updateList(String value){
    setState(() {
      display_list= tutors.where((element) => element.major!.toLowerCase().contains(value.toLowerCase()
      )).toList();
    });
   }
  String TutorAccount='';
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
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 244, 244, 248),
      drawer: NavBar(),
      appBar: AppBar(
        iconTheme: IconThemeData(size:30,color: Color.fromARGB(255, 192, 218, 240)),
        elevation: 8,
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
          ],),
      ),

      body: 
          
       //SingleChildScrollView(
          //child:
          Padding(
            padding: EdgeInsets.all(7),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
              children:[
                Text('',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 4, 4, 71),
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),),


                SizedBox(height: 20,),

                TextField(
                  onChanged: (textEntered) {
                    setState(() {
                      TutorAccount = textEntered;
                    });
                   // SearchBar(textEntered);
                  },
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: "ابحث عن المادة هنا",
                    hintStyle: TextStyle(
                      color: Color.fromARGB(255, 93, 93, 123),
                    ) ,
                    filled: true,
                    fillColor: Color.fromARGB(255, 226, 226, 248),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(width: 4,color:Color.fromARGB(255, 4, 4, 71), ),
                    ),
                    prefixIcon: Icon(Icons.search_rounded,size: 30,color:Color.fromARGB(255, 4, 4, 71),),
                  ),
                ),
              
                SizedBox(height: 10,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.2,
                  decoration: BoxDecoration(
                  image: DecorationImage(
                  image: AssetImage("assets/images/bubble-gum-searching.gif"),
                  ),
                  ),
                ),
                
                SizedBox(height: 40,),

                StreamBuilder<QuerySnapshot>(
                  stream: _firestore.collection('tutors').snapshots(),
                  builder: (BuildContext context, snapshot){
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
                      
                        itemBuilder: (context, index){
                          var data = snapshot.data!.docs[index].data() as Map<String , dynamic>;
                          if(TutorAccount.isEmpty){
                            return Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                color:Color.fromARGB(255, 4, 4, 71),
                                child: Card(
                                  color:Color.fromARGB(255, 4, 4, 71),
                                  child: Padding(
                                    padding: const EdgeInsets.all(3),
                                    child: Container(
                                      margin: EdgeInsets.only(bottom: 5),
                                      width: MediaQuery.of(context).size.width,
                                      height: MediaQuery.of(context).size.height*0.20,
                                      decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 4, 4, 71),
                                        border: Border(bottom:BorderSide(
                                          width: 2,color: Color.fromARGB(255, 249, 222, 87),)),
                                      ),
                                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          FloatingActionButton.extended(
                                          heroTag: "btn$index",
                                          label: Text('المزيد',
                                          style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color:Color.fromARGB(255, 4, 4, 71),),),
                                          backgroundColor:Color.fromARGB(255, 249, 210, 236),
                                          icon: Icon(Icons.more_horiz, size: 20,
                                          color:Color.fromARGB(255, 4, 4, 71),),
                                          onPressed: (){
                                            Navigator.pushReplacement(
                                            context, 
                                            MaterialPageRoute(builder: (context) => tutorPageforStudent()));
                                          },
                                        ),
                                        Column(mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              // ignore: prefer_const_literals_to_create_immutables
                                              children:[
                                              Text(data['Price'],//سعر الساعه
                                              style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 20,
                                              color:Color.fromARGB(255, 244, 244, 248),),),
                                              SizedBox(width:5),
                                              Text('₪/ساعة',
                                              style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 20,
                                              color:Color.fromARGB(255, 244, 244, 248),),), 
                                            ],
                                            ),
                                            Row(
                                              children:[
                                              Icon(Icons.star_rate, size:25,color:Color.fromARGB(255, 254, 207, 51),),
                                              SizedBox(width:5),
                                              Text(data['Rating'],//تقييم الأستاذ
                                              style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 20,
                                              color:Color.fromARGB(255, 244, 244, 248),),),  
                                            ],),
                                          ],
                                        ),
                                        Column(mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(data['Account'],///اسم الأستاذ
                                            style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 22,
                                            color:Color.fromARGB(255, 244, 244, 248),),),
                                            Text(data['Field'],//الماده الي بدرسها
                                            style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 22,
                                            color:Color.fromARGB(255, 244, 244, 248),),),
                                          ],
                                        ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }

                          if(data['Field'].toString().toLowerCase().startsWith(TutorAccount.toLowerCase())
                          || data['Account'].toString().toLowerCase().startsWith(TutorAccount.toLowerCase())){
                            return Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                color:Color.fromARGB(255, 4, 4, 71),
                                child: Card(
                                  color:Color.fromARGB(255, 4, 4, 71),
                                  child: Padding(
                                    padding: const EdgeInsets.all(3),
                                    child: Container(
                                      margin: EdgeInsets.only(bottom: 5),
                                      width: MediaQuery.of(context).size.width,
                                      height: MediaQuery.of(context).size.height*0.20,
                                      decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 4, 4, 71),
                                        border: Border(bottom:BorderSide(
                                          width: 2,color: Color.fromARGB(255, 249, 222, 87),)),
                                      ),
                                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          FloatingActionButton.extended(
                                          heroTag: "btn$index",
                                          label: Text('المزيد',
                                          style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color:Color.fromARGB(255, 4, 4, 71),),),
                                          backgroundColor:Color.fromARGB(255, 249, 210, 236),
                                          icon: Icon(Icons.more_horiz, size: 20,
                                          color:Color.fromARGB(255, 4, 4, 71),),
                                          onPressed: (){
                                            Navigator.pushReplacement(
                                            context, 
                                            MaterialPageRoute(builder: (context) => tutorPageforStudent()));
                                          },
                                        ),
                                        Column(mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              // ignore: prefer_const_literals_to_create_immutables
                                              children:[
                                              Text(data['Price'],//سعر الساعه
                                              style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 20,
                                              color:Color.fromARGB(255, 244, 244, 248),),),
                                              SizedBox(width:5),
                                              Text('₪/ساعة',
                                              style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 20,
                                              color:Color.fromARGB(255, 244, 244, 248),),), 
                                            ],
                                            ),
                                            Row(
                                              children:[
                                              Icon(Icons.star_rate, size:25,color:Color.fromARGB(255, 254, 207, 51),),
                                              SizedBox(width:5),
                                              Text(data['Rating'],//تقييم الأستاذ
                                              style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 20,
                                              color:Color.fromARGB(255, 244, 244, 248),),),  
                                            ],),
                                          ],
                                        ),
                                        Column(mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(data['Account'],///اسم الأستاذ
                                            style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 22,
                                            color:Color.fromARGB(255, 244, 244, 248),),),
                                            Text(data['Field'],//الماده الي بدرسها
                                            style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 22,
                                            color:Color.fromARGB(255, 244, 244, 248),),),
                                          ],
                                        ),
                                        ],
                                      ),
                                    ),
                                  ),
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
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    color:Color.fromARGB(255, 4, 4, 71),
                    child: Card(
                      color:Color.fromARGB(255, 4, 4, 71),
                      child: Padding(
                        padding: const EdgeInsets.all(3),
                        child:
                        display_list.length==0?
                        Center(
                          child: Text("لا يوجد نتائج",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          )),
                        )
                         :ListView.builder(
                          padding: EdgeInsets.all(10),
                          shrinkWrap: true,
                          itemCount: display_list.length,
                          itemBuilder: (context, index){
                            return Container( 
                              margin: EdgeInsets.only(bottom: 5),
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height*0.20,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 4, 4, 71),
                                //borderRadius: BorderRadius.all(Radius.circular(20),),
                                border: Border(bottom:BorderSide(
                                  width: 2,color: Color.fromARGB(255, 249, 222, 87),)),
                                /*boxShadow: [BoxShadow(
                                 color: Color.fromARGB(255, 223, 212, 159),
                                 spreadRadius: 2, blurRadius: 2,),],*/
                               ),
                               child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children:[
                                  /*GestureDetector(
                                    onTap:(){
                                      Navigator.pushReplacement(
                                      context, 
                                      MaterialPageRoute(builder: (context) => tutorPageforStudent()));
                                    },
                                    child:Container(),
                                  ),*/
                                  FloatingActionButton.extended(
                                    heroTag: "btn$index",
                                    label: Text('المزيد',
                                    style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color:Color.fromARGB(255, 4, 4, 71),),),
                                    backgroundColor:Color.fromARGB(255, 249, 210, 236),
                                    icon: Icon(Icons.more_sharp,size: 20,
                                    color:Color.fromARGB(255, 4, 4, 71),),
                                    onPressed: (){
                                      Navigator.pushReplacement(
                                      context, 
                                      MaterialPageRoute(builder: (context) => tutorPageforStudent()));
                                    },
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:[
                                      Row(
                                       // ignore: prefer_const_literals_to_create_immutables
                                       children:[
                                       Text("${display_list[index].price}",//سعر الساعه
                                       style: TextStyle(
                                       fontWeight: FontWeight.w700,
                                       fontSize: 20,
                                       color:Color.fromARGB(255, 244, 244, 248),),),
                                       SizedBox(width:5),
                                       Text('₪/ساعة',
                                       style: TextStyle(
                                       fontWeight: FontWeight.w700,
                                       fontSize: 20,
                                       color:Color.fromARGB(255, 244, 244, 248),),), 
                                     ],
                                    ),

                                    Row(
                                      children:[
                                       Icon(Icons.star_rate, size:25,color:Color.fromARGB(255, 255, 230, 7),),
                                       SizedBox(width:5),
                                       Text("${display_list[index].rating}",//تقييم الأستاذ
                                       style: TextStyle(
                                       fontWeight: FontWeight.w700,
                                       fontSize: 20,
                                       color:Color.fromARGB(255, 244, 244, 248),),), 
                                      ],),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:[
                                      Row(
                                        children:[
                                          Text(display_list[index].Lastname!,///اسم الأستاذ
                                          style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 22,
                                          color:Color.fromARGB(255, 244, 244, 248),),),
                                          SizedBox(width: 3,),
                                          Text(display_list[index].Firstname!,///اسم الأستاذ
                                          style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 22,
                                          color:Color.fromARGB(255, 244, 244, 248),),),
                                        ],
                                      ), 
                                      Text(display_list[index].major!,//الماده الي بدرسها
                                      style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 22,
                                      color:Color.fromARGB(255, 244, 244, 248),),),
                                   ],
                                  ),
                                ],
                               ),
                            );
                            
                          },
                      
                        ),
                        
                      ),
                    ),
                  ),
                ),*/
                SizedBox(height:15,),
              ],
            ),
          ),
       //),
        
      //),*/

        bottomNavigationBar:       
           Theme(
            data: Theme.of(context).copyWith(
              iconTheme: IconThemeData(color:Color.fromARGB(255, 208, 208, 208))
            ),
             child: CurvedNavigationBar(
              index: 1,
              height: 60,
              items:<Widget> [
                //CurvedNavigationBarState(),
                GestureDetector(
                  onTap: (){
                      Navigator.pushReplacement(context, 
                      MaterialPageRoute(builder: (context) => homePage() ));
                    },
                  child: Icon(Icons.home_filled, size: 30, 
                       color:Color.fromARGB(255, 244, 244, 248) ,),
                ),
                     
                Icon(Icons.explore_rounded, size: 30, 
                       color:Color.fromARGB(255, 235, 238, 231)),
                

                GestureDetector(
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => StuProfile() ));
                    },
                  child: Icon(Icons.perm_identity_sharp, size: 30, 
                       color:Color.fromARGB(255, 235, 238, 231),),
                )
               
          ],
              //index: index,
              buttonBackgroundColor: Color.fromARGB(255, 4, 4, 71),
              backgroundColor: Colors.transparent,
              color: Color.fromARGB(255, 4, 4, 71),
              animationDuration: Duration(milliseconds: 300),
              animationCurve: Curves.easeInOut,
              /*onTap: (index){
                setState(() {
                 // _page = index;
                });
              },*/
                   ),
           ),
      
         
    );
  }
}



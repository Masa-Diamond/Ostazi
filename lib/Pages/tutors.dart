// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:grad_project/Pages/NavBar.dart';
import 'package:grad_project/Pages/home.dart';
import 'package:grad_project/Pages/student_reg_atutor.dart';
import 'package:grad_project/Pages/tutors_class.dart';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grad_project/Pages/inbox-student.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firestore = FirebaseFirestore.instance;
late User signedInUser;

class tutors extends StatefulWidget {
  const tutors({super.key});

  @override
  State<tutors> createState() => _tutorsState();
}

class _tutorsState extends State<tutors> with SingleTickerProviderStateMixin {
  //TabController controller;
  List selectedIndex = [];
  static List<TutorModel> tutors = [
    TutorModel( 'أيمن','صبوح', 'فيزياء', 30,10.0),
    TutorModel( 'عمار ','النابلسي', 'رياضيات', 30,10.0),
    TutorModel( 'غسان ','الساحلي', 'كيمياء', 30,8.2),
    TutorModel( 'ماسة ', 'السيد', 'الانجليزيه', 30,9.1),
    TutorModel( 'فيحاء','البحش', 'احياء', 30,8.1),
    TutorModel( 'ميرا ','صايمه', 'رياضيات', 30,9.5),
    TutorModel( 'حمدي ','وهبة', 'رياضيات', 30,7.5),
  ];
   List<TutorModel> display_list = List.from(tutors);
 
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
            //colorFilter: new ColorFilter.mode(Color.fromARGB(255, 4, 4, 71).withOpacity(0.5), BlendMode.dstATop),
               //fit: BoxFit.cover,
           ),
          ),
            ),            
          ],
        ),
      ),

      body: 
       //SingleChildScrollView(
           // child: 
            Column(
              children: [
                SizedBox(height: 15,),
                Text(':أساتذتي ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 4, 4, 71),
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),),
                SizedBox(height: 15,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.25,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/clip-solving-math-problem.gif"),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
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
                          
                            return Center(
                              child: Container(
                                margin: EdgeInsets.only(bottom: 11), 
                                width: MediaQuery.of(context).size.width*0.95,
                                height: MediaQuery.of(context).size.height*0.20,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 4, 4, 71),
                                  borderRadius: BorderRadius.all(Radius.circular(20),),
                                  border: Border.all(width: 2.5,color: Color.fromARGB(255, 249, 222, 87),//Color.fromARGB(255, 170, 207, 173),
                                  ),
                                  boxShadow: [BoxShadow(
                                    //color: Color.fromARGB(255, 222, 219, 242),
                                    spreadRadius: 2, blurRadius: 2,
                                  ),],),
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
                            );
                          
                        }
                      ),
                    );
                  }
                ),
                /*Expanded(
                  //Color.fromARGB(255, 170, 207, 173),
                  child: ListView.builder(            
                    padding: EdgeInsets.all(16),
                    shrinkWrap: true,
                    itemCount: display_list.length, 
                    itemBuilder: (context, index){
                      return Container(
                        margin: EdgeInsets.only(bottom: 11), 
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height*0.20,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 4, 4, 71),
                          borderRadius: BorderRadius.all(Radius.circular(20),),
                          border: Border.all(width: 2.5,color: Color.fromARGB(255, 249, 222, 87),//Color.fromARGB(255, 170, 207, 173),
                          ),
                          boxShadow: [BoxShadow(
                            //color: Color.fromARGB(255, 222, 219, 242),
                            spreadRadius: 2, blurRadius: 2,
                          ),],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            FloatingActionButton.extended(
                              heroTag: "btn$index",
                              label: Text('المزيد',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color:Color.fromARGB(255, 4, 4, 71), 
                              ),),
                              backgroundColor:Color.fromARGB(255, 217, 248, 220),
                              icon: Icon(Icons.more_sharp,size: 20,
                              color:Color.fromARGB(255, 4, 4, 71),),
                              onPressed: (){
                                Navigator.pushReplacement(
                                context, 
                                MaterialPageRoute(builder: (context) 
                                => tutorPageforStudent()));
                              },
                            ),
                            Column(
                              //padding: EdgeInsets.all(10),
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: <Widget>[
                                    Text("${display_list[index].price}",
                                    style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                    color:Color.fromARGB(255, 244, 244, 248), 
                                    ),),
                                    SizedBox(width:5),
                                    Text('₪/ساعة',
                                    style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                    color:Color.fromARGB(255, 244, 244, 248), 
                                    ),), 
                                  ],),
                                 
                                 Row(
                                  children: [
                                    Icon(Icons.star_rate, size:25,color:Color.fromARGB(255, 255, 230, 7),),
                                    SizedBox(width:5),
                                    Text("${display_list[index].rating}",//التقييم
                                    style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                    color:Color.fromARGB(255, 244, 244, 248), 
                                    ),), 
                                  ],),                              
                              ],),

                            Column(
                              //padding: EdgeInsets.all(10),
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
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
                                color:Color.fromARGB(255, 244, 244, 248), 
                              ),),
                              ],
                            ),
                          ],
                        ),
                      );
                    }
                    /*children: [
                      

                      Container( 
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height*0.20,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 4, 4, 71),
                          borderRadius: BorderRadius.all(Radius.circular(15),),
                          border: Border.all(width: 4,color: Color.fromARGB(255, 170, 207, 173),),
                          boxShadow: [BoxShadow(
                            color: Color.fromARGB(255, 222, 219, 242),
                            spreadRadius: 5, blurRadius: 5,
                          ),],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            FloatingActionButton.extended(
                              label: Text('المزيد',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color:Color.fromARGB(255, 4, 4, 71), 
                              ),),
                              backgroundColor:Color.fromARGB(255, 217, 248, 220),
                              icon: Icon(Icons.more_sharp,size: 20,
                              color:Color.fromARGB(255, 4, 4, 71),),
                              onPressed: (){
                                Navigator.pushReplacement(
                                context, 
                                MaterialPageRoute(builder: (context) => tutorPageforStudent()));
                              },
                            ),
                            Column(
                              //padding: EdgeInsets.all(10),
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text('40',
                                    style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                    color:Color.fromARGB(255, 244, 244, 248), 
                                    ),),
                                    SizedBox(width:5),
                                    Text('₪/ساعة',
                                    style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                    color:Color.fromARGB(255, 244, 244, 248), 
                                    ),), 
                                  ],
                                ),
                                 
                                 Row(
                                  children: <Widget>[
                                    Icon(Icons.star_rate, size:25,color:Color.fromARGB(255, 250, 255, 105),),
                                    SizedBox(width:5),
                                    Text('3.9',
                                    style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                    color:Color.fromARGB(255, 244, 244, 248), 
                                    ),), 
                                  ],
                                ),
                              ],
                            ),

                            Column(
                              //padding: EdgeInsets.all(10),
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text('غسان الساحلي',
                                style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 22,
                                color:Color.fromARGB(255, 244, 244, 248), 
                              ),), 
                              Text('كيمياء',
                                style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 22,
                                color:Color.fromARGB(255, 244, 244, 248), 
                              ),),
                              ],
                            ),
                          ],
                        ),
                      ),

                      Container( 
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height*0.20,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 4, 4, 71),
                          borderRadius: BorderRadius.all(Radius.circular(15),),
                          border: Border.all(width: 4,color: Color.fromARGB(255, 170, 207, 173),),
                          boxShadow: [BoxShadow(
                            color: Color.fromARGB(255, 222, 219, 242),
                            spreadRadius: 5, blurRadius: 5,
                          ),],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            FloatingActionButton.extended(
                              label: Text('المزيد',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color:Color.fromARGB(255, 4, 4, 71), 
                              ),),
                              backgroundColor:Color.fromARGB(255, 217, 248, 220),
                              icon: Icon(Icons.more_sharp,size: 20,
                              color:Color.fromARGB(255, 4, 4, 71),),
                              onPressed: (){
                                Navigator.pushReplacement(
                                context, 
                                MaterialPageRoute(builder: (context) => tutorPageforStudent()));
                              },
                            ),
                            Column(
                              //padding: EdgeInsets.all(10),
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text('25',
                                    style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                    color:Color.fromARGB(255, 244, 244, 248), 
                                    ),),
                                    SizedBox(width:5),
                                    Text('₪/ساعة',
                                    style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                    color:Color.fromARGB(255, 244, 244, 248), 
                                    ),), 
                                  ],
                                ),
                                 
                                 Row(
                                  children: <Widget>[
                                    Icon(Icons.star_rate, size:25,color:Color.fromARGB(255, 250, 255, 105),),
                                    SizedBox(width:5),
                                    Text('4.0',
                                    style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                    color:Color.fromARGB(255, 244, 244, 248), 
                                    ),), 
                                  ],
                                ),
                              ],
                            ),

                            Column(
                              //padding: EdgeInsets.all(10),
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text('حمدي وهبة',
                                style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 22,
                                color:Color.fromARGB(255, 244, 244, 248), 
                              ),), 
                              Text('رياضيات',
                                style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 22,
                                color:Color.fromARGB(255, 244, 244, 248), 
                              ),),
                              ],
                            ),
                          ],
                        ),
                      ),

                      Container( 
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height*0.20,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 4, 4, 71),
                          borderRadius: BorderRadius.all(Radius.circular(15),),
                          border: Border.all(width: 4,color: Color.fromARGB(255, 170, 207, 173),),
                          boxShadow: [BoxShadow(
                            color: Color.fromARGB(255, 222, 219, 242),
                            spreadRadius: 5, blurRadius: 5,
                          ),],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            FloatingActionButton.extended(
                              label: Text('المزيد',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color:Color.fromARGB(255, 4, 4, 71), 
                              ),),
                              backgroundColor:Color.fromARGB(255, 217, 248, 220),
                              icon: Icon(Icons.more_sharp,size: 20,
                              color:Color.fromARGB(255, 4, 4, 71),),
                              onPressed: (){
                                Navigator.pushReplacement(
                                context, 
                                MaterialPageRoute(builder: (context) => tutorPageforStudent()));
                              },
                            ),
                            Column(
                              //padding: EdgeInsets.all(10),
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text('35',
                                    style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                    color:Color.fromARGB(255, 244, 244, 248), 
                                    ),),
                                    SizedBox(width:5),
                                    Text('₪/ساعة',
                                    style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                    color:Color.fromARGB(255, 244, 244, 248), 
                                    ),), 
                                  ],
                                ),
                                 
                                 Row(
                                  children: <Widget>[
                                    Icon(Icons.star_rate, size:25,color:Color.fromARGB(255, 250, 255, 105),),
                                    SizedBox(width:5),
                                    Text('4.5',
                                    style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                    color:Color.fromARGB(255, 244, 244, 248), 
                                    ),), 
                                  ],
                                ),
                              ],
                            ),

                            Column(
                              //padding: EdgeInsets.all(10),
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text('ماسه السيد',
                                style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 22,
                                color:Color.fromARGB(255, 244, 244, 248), 
                              ),), 
                              Text('الانجليزية',
                                style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 22,
                                color:Color.fromARGB(255, 244, 244, 248), 
                              ),),
                              ],
                            ),
                          ],
                        ),
                      ),

                      Container( 
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height*0.20,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 4, 4, 71),
                          borderRadius: BorderRadius.all(Radius.circular(15),),
                          border: Border.all(width: 4,color: Color.fromARGB(255, 170, 207, 173),),
                          boxShadow: [BoxShadow(
                            color: Color.fromARGB(255, 222, 219, 242),
                            spreadRadius: 5, blurRadius: 5,
                          ),],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            FloatingActionButton.extended(
                              label: Text('المزيد',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color:Color.fromARGB(255, 4, 4, 71), 
                              ),),
                              backgroundColor:Color.fromARGB(255, 217, 248, 220),
                              icon: Icon(Icons.more_sharp,size: 20,
                              color:Color.fromARGB(255, 4, 4, 71),),
                              onPressed: (){
                                Navigator.pushReplacement(
                                context, 
                                MaterialPageRoute(builder: (context) => tutorPageforStudent()));
                              },
                            ),
                            Column(
                              //padding: EdgeInsets.all(10),
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text('30',
                                    style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                    color:Color.fromARGB(255, 244, 244, 248), 
                                    ),),
                                    SizedBox(width:5),
                                    Text('₪/ساعة',
                                    style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                    color:Color.fromARGB(255, 244, 244, 248), 
                                    ),), 
                                  ],
                                ),
                                 
                                 Row(
                                  children: <Widget>[
                                    Icon(Icons.star_rate, size:25,color:Color.fromARGB(255, 250, 255, 105),),
                                    SizedBox(width:5),
                                    Text('3.7',
                                    style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                    color:Color.fromARGB(255, 244, 244, 248), 
                                    ),), 
                                  ],
                                ),
                              ],
                            ),

                            Column(
                              //padding: EdgeInsets.all(10),
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text('ميرا صايمة',
                                style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 22,
                                color:Color.fromARGB(255, 244, 244, 248), 
                              ),), 
                              Text('رياضيات',
                                style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 22,
                                color:Color.fromARGB(255, 244, 244, 248), 
                              ),),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],*/
                  ),
                ),*/               
              ],
            ),
          //),
      
    );
  }
}
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:grad_project/Pages/NavBar.dart';
import 'package:grad_project/Pages/home.dart';
import 'package:grad_project/Pages/coursesInfo_class.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grad_project/Pages/inbox-student.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/bookings_model.dart';

final _firestore = FirebaseFirestore.instance;
late User signedInUser;

class courses extends StatefulWidget {
  const courses({super.key});

  @override
  State<courses> createState() => _coursesState();
}

class _coursesState extends State<courses> {
  var colors = [
    // ignore: empty_constructor_bodies
    Color.fromARGB(255, 222, 186, 129),
    Color.fromARGB(255, 218, 165, 172),
    Color.fromARGB(255, 231, 195, 168),
    Color.fromARGB(255, 204, 214, 157),
    Color.fromARGB(255, 175, 199, 211), 
    Color.fromARGB(255, 222, 186, 129),
    Color.fromARGB(255,192,129,137),
    Color.fromARGB(255, 231, 195, 168),
    Color.fromARGB(255,136,139,122),
    Color.fromARGB(255, 188, 204, 202), 
    Color.fromARGB(255, 222, 186, 129),
    Color.fromARGB(255,192,129,137),
    Color.fromARGB(255, 231, 195, 168),
    Color.fromARGB(255,136,139,122),
    Color.fromARGB(255, 188, 204, 202), 
    Color.fromARGB(255, 222, 186, 129),
    Color.fromARGB(255,192,129,137),
    Color.fromARGB(255, 231, 195, 168),
    Color.fromARGB(255,136,139,122),
    Color.fromARGB(255, 188, 204, 202),
    Color.fromARGB(255, 222, 186, 129),
    Color.fromARGB(255,192,129,137),
    Color.fromARGB(255, 231, 195, 168),
    Color.fromARGB(255,136,139,122),
    Color.fromARGB(255, 188, 204, 202), 
  ];
  List selectedIndex = [];
  static List<CourseModel> courses = [
    CourseModel( 'أيمن','صبوح', 'فيزياء', 20,'خميس','2:00 PM','3:00 PM','10/27/2022',true),
    CourseModel( 'حمدي ','وهبة', 'رياضيات', 20,'سبت','4:00 PM','5:00 PM','10/29/2022',true),
    CourseModel( 'غسان ','الساحلي', 'كيمياء', 20,'خميس','3:00 PM','4:00 PM','11/3/2022',true),
    CourseModel( 'ماسة ', 'السيد','الانجليزية', 25,'سبت','11:00 PM','12:00 PM','11/5/2022',true),
    CourseModel( 'ميرا','صايمه', 'رياضيات', 20,'خميس','1:00 PM','2:00 PM','11/10/2022',true),
  ];
   List<CourseModel> courses_list = List.from(courses);
  int flag=0;
  String dataToChange= 'تسجيل';
  void changedata(){
    setState((){
      if (flag ==0){
        dataToChange ='الغاء';
        flag =1;
      }
      else {dataToChange= 'تسجيل'; flag=0;}
      
    });
  }
  int tapped_index =-1;
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
  late String StudentAccount;
  late String UserID;
  @override
  final _auth = FirebaseAuth.instance;
  @override
  void initState(){
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async{
    try {
      final user = _auth.currentUser;
      if (user != null){
      signedInUser = user; 
      print(signedInUser.email);
     var UserData = FirebaseFirestore.instance
      .collection("users").where('uid', isEqualTo: _auth.currentUser!.uid).snapshots();
      print(_auth.currentUser!.uid);
      //String UserAccount = UserData['Account'];
      /*var UserAccount = FirebaseFirestore.instance
      .collection("users").doc(_auth.currentUser!.uid).get().then((value) => {
        StudentAccount = value.get('Account').toString()
        
      });*/
      
      DocumentSnapshot ds = await FirebaseFirestore.instance.collection('users').doc(_auth.currentUser!.uid).get();
      StudentAccount = ds.get('Account');
      UserID = ds.get('uid');
      print(StudentAccount);
      print(UserID);
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
               decoration: BoxDecoration(
               image: DecorationImage(
               image: AssetImage("assets/images/logo2.png"),
               fit: BoxFit.fitWidth
           ),),
            ),
          ],),
      ),

      body: 
       //SingleChildScrollView(
           // child: 
            Column(
              children:<Widget> [
                SizedBox(height: 15,),
                Text(':حصص المعهد',
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
                      image: AssetImage("assets/images/clip-math-teacher-near-the-blackboard.gif"),
                    ),
                  ),
                ),
                SizedBox(height: 20,),

                StreamBuilder<QuerySnapshot>(
                  stream: _firestore.collection('courses').snapshots(),
                  builder: (BuildContext context, snapshot){
                    if(!snapshot.hasData){
                      return Center(
                        child: Container(
                          child: Text("!لا يوجد أي حصص ",
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
                              padding: EdgeInsets.symmetric(horizontal:2,vertical: 20),
                              margin: const EdgeInsets.only(bottom: 8),
                              width: MediaQuery.of(context).size.width*0.95,
                              height: MediaQuery.of(context).size.height*0.20,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 4, 4, 71),
                                borderRadius: BorderRadius.all(Radius.circular(15),),
                                border: Border.all(width:2,color: Color.fromARGB(255, 243, 189, 27),//Color.fromARGB(255, 233, 174, 221),
                                ),
                                boxShadow: [BoxShadow(
                                //color: Color.fromARGB(255, 222, 219, 242),
                                spreadRadius: 2, blurRadius: 2,
                                ),],
                              ),
                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  selectedIndex.contains(index) ?
                                  FloatingActionButton.extended(
                                  heroTag: "btn$index",
                                  label: Text( 'الغاء',    //'$dataToChange',
                                  style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize:15,
                                  color:Color.fromARGB(255, 4, 4, 71), 
                                  ),),
                                  backgroundColor: Color.fromARGB(255, 215, 99, 99),
                            
                                  onPressed: () async{
                                  /*checkSelectedCard(index+1);
                                  tapped_index = index;
                                  selected(tapped_index);*/
                                  
                                  //changedata ();
                                  },     
                                ):
                                FloatingActionButton.extended(
                                  heroTag: "btn$index",
                                  label: Text(  'تسجيل',    //'$dataToChange',
                                  style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize:15,
                                  color:Color.fromARGB(255, 4, 4, 71), 
                                  ),),
                                  backgroundColor:
                                  Color.fromARGB(255, 217, 248, 220),
                            
                                  onPressed: () async{
                                  checkSelectedCard(index+1);
                                  tapped_index = index;
                                  selected(tapped_index);
                                  setState(() {
                                    insertData(data['Tutor'], data['Field'], data['Price'], data['Date'],
                                     data['StartTimr'], data['EndTime'],StudentAccount, UserID);
                                  });
                                  //changedata ();
                                  },     
                                ),
                                Column(
                                  //padding: EdgeInsets.all(10),
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        ////سعر ساعة الحصة
                                        Text(data['Price'],
                                        style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize:16,
                                        color:Color.fromARGB(255, 244, 244, 248), 
                                        ),),
                                        SizedBox(width:5),
                                        Text('₪/ساعة',
                                        style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                        color:Color.fromARGB(255, 244, 244, 248), 
                                        ),), 
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Icon(Icons.calendar_month, size:20,color:Color.fromARGB(255, 250, 5, 156),),
                                        SizedBox(width:5),
                                        ///يوم الحصة
                                        Text(data['Date'],//the day
                                        style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                        color:Color.fromARGB(255, 244, 244, 248), 
                                        ),), 
                                      ],
                                    ), 
                                    Row(
                                      children: <Widget>[
                                        Icon(Icons.punch_clock_rounded, size:20,color:Color.fromARGB(255, 107, 242, 201),),
                                        SizedBox(width:5),
                                        ///الوقت من أي ساعة لأي ساعة
                                        Text(data['StartTimr'],// the begin hour
                                        style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize:16,
                                        color:Color.fromARGB(255, 244, 244, 248),),),
                                        SizedBox(width: 5,),
                                        Text('-',
                                        style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                        color:Color.fromARGB(255, 244, 244, 248),),),
                                        SizedBox(width: 5,),
                                        Text(data['EndTime'],//the end of the hour 
                                        style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize:16,
                                        color:Color.fromARGB(255, 244, 244, 248),),),
                                      ],
                                    ),

                                  ],
                                ),
                                Column(
                                  //padding: EdgeInsets.all(10),
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(data['Tutor'],// tutor name
                                    style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize:20,
                                    color:Color.fromARGB(255, 244, 244, 248),                                    
                                    ),), 
                                  Text(data['Field'], //tutor major
                                    style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize:18,
                                    color:Color.fromARGB(255, 244, 244, 248), 
                                  ),),
                                  ],
                                ),
                                ],
                              ),
                              /*child: ListTile(
                                leading:
                                FloatingActionButton.extended(
                                  heroTag: "btn$index",
                                  label: Text( selectedIndex.contains(index) ? 'الغاء': 'تسجيل',    //'$dataToChange',
                                  style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize:15,
                                  color:Color.fromARGB(255, 4, 4, 71), 
                                  ),),
                                  backgroundColor:selectedIndex.contains(index) ? Color.fromARGB(255, 215, 99, 99):
                                  Color.fromARGB(255, 217, 248, 220),
                            
                                  onPressed: (){
                                  checkSelectedCard(index+1);
                                  tapped_index = index;
                                  selected(tapped_index);
                                  //changedata ();
                                  },     
                                ),
                                
                                title: Container(
                                  child: Column(mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Text(data['Price'],
                                          style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize:16,
                                          color:Color.fromARGB(255, 244, 244, 248), 
                                          ),),
                                          SizedBox(width:5),
                                          Text('₪/ساعة',
                                          style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                          color:Color.fromARGB(255, 244, 244, 248), 
                                          ),), 
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Icon(Icons.dashboard, size:20,color:Color.fromARGB(255, 250, 5, 156),),
                                          SizedBox(width:5),
                                          ///يوم الحصة
                                          Text(data['Date'],//the day
                                          style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                          color:Color.fromARGB(255, 244, 244, 248), 
                                          ),), 
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                subtitle: Container(
                                  child: Row(
                                    children: [
                                      Icon(Icons.timer_outlined, size:20,color:Color.fromARGB(255, 107, 242, 201),),
                                      SizedBox(width:2),
                                      ///الوقت من أي ساعة لأي ساعة
                                      Text(data['StartTimr'],// the begin hour
                                      style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize:16,
                                      color:Color.fromARGB(255, 244, 244, 248),),),
                                      SizedBox(width: 1,),
                                      Text('-',
                                      style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color:Color.fromARGB(255, 244, 244, 248),),),
                                      SizedBox(width: 1,),
                                      Text(data['EndTime'],//the end of the hour 
                                      style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize:16,
                                      color:Color.fromARGB(255, 244, 244, 248),),),
                                    ],
                                  ),
                                ),

                                trailing: Container(
                                  child: Column(
                                    children: [
                                      Text(data['Tutor'],// tutor name
                                      style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize:20,
                                      color:Color.fromARGB(255, 244, 244, 248),                                    
                                      ),),
                                      //SizedBox(height: 10,),
                                      Text(data['Field'], //tutor major
                                        style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize:18,
                                        color:Color.fromARGB(255, 244, 244, 248), 
                                      ),),
                                    ],
                                  ),
                                ),
                              ),*/
                            ),
                          );
                        }
                      ),
                    );
                  }
                ),
               /* Expanded(
                  
                  child: ListView.builder(            
                    padding: EdgeInsets.all(7),
                    shrinkWrap: true,
                    itemCount: courses_list.length,
                    itemBuilder: (context, index){
                      return AnimationConfiguration.staggeredList(
                        position: index, 
                        child: SlideAnimation(
                          child: FadeInAnimation(
                            child:Row( mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container( 
                                padding: EdgeInsets.symmetric(horizontal:2,vertical: 20),
                                margin: const EdgeInsets.only(bottom: 8),
                                width: MediaQuery.of(context).size.width*0.95,
                                height: MediaQuery.of(context).size.height*0.20,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 4, 4, 71),
                                  borderRadius: BorderRadius.all(Radius.circular(15),),
                                  border: Border.all(width:2,color: Color.fromARGB(255, 243, 189, 27),//Color.fromARGB(255, 233, 174, 221),
                                  ),
                                  boxShadow: [BoxShadow(
                                  //color: Color.fromARGB(255, 222, 219, 242),
                                  spreadRadius: 2, blurRadius: 2,
                                  ),],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                  FloatingActionButton.extended(
                                    heroTag: "btn$index",
                                    label: Text( selectedIndex.contains(index) ? 'الغاء': 'تسجيل',    //'$dataToChange',
                                    style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize:15,
                                    color:Color.fromARGB(255, 4, 4, 71), 
                                    ),),
                                    backgroundColor:selectedIndex.contains(index) ? Color.fromARGB(255, 215, 99, 99):
                                    Color.fromARGB(255, 217, 248, 220),
                              
                                    onPressed: (){
                                    checkSelectedCard(index+1);
                                    tapped_index = index;
                                    selected(tapped_index);
                                    //changedata ();
                                    },     
                                  ),
                            
                            Column(
                              //padding: EdgeInsets.all(10),
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    ////سعر ساعة الحصة
                                    Text("${courses_list[index].price}",
                                    style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize:16,
                                    color:Color.fromARGB(255, 244, 244, 248), 
                                    ),),
                                    SizedBox(width:5),
                                    Text('₪/ساعة',
                                    style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    color:Color.fromARGB(255, 244, 244, 248), 
                                    ),), 
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Icon(Icons.dashboard, size:20,color:Color.fromARGB(255, 250, 5, 156),),
                                    SizedBox(width:5),
                                    ///يوم الحصة
                                    Text("${courses_list[index].day}",//the day
                                    style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    color:Color.fromARGB(255, 244, 244, 248), 
                                    ),), 
                                  ],
                                ), 
                                Row(
                                  children: <Widget>[
                                    Icon(Icons.punch_clock_rounded, size:20,color:Color.fromARGB(255, 107, 242, 201),),
                                    SizedBox(width:5),
                                    ///الوقت من أي ساعة لأي ساعة
                                    Text(courses_list[index].initTime!,// the begin hour
                                    style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize:16,
                                    color:Color.fromARGB(255, 244, 244, 248),),),
                                    SizedBox(width: 5,),
                                    Text('-',
                                    style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    color:Color.fromARGB(255, 244, 244, 248),),),
                                    SizedBox(width: 5,),
                                    Text(courses_list[index].endTime!,//the end of the hour 
                                    style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize:16,
                                    color:Color.fromARGB(255, 244, 244, 248),),),
                                  ],
                                ),

                                Row(
                                  children: <Widget>[
                                    Icon(Icons.date_range, size:20,color:Color.fromARGB(255, 252, 245, 147),),
                                    SizedBox(width:5),
                                    ///اتاريخ
                                    Text(courses_list[index].date!,//date day
                                    style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize:16,
                                    color:Color.fromARGB(255, 244, 244, 248),),),
                                    SizedBox(width: 5,),
                                    
                                  ],
                                ),
                              ],
                            ),

                            Column(
                              //padding: EdgeInsets.all(10),
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  children: [
                                    Text(courses_list[index].Lastname!,// tutor name
                                    style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize:20,
                                    color:Color.fromARGB(255, 244, 244, 248),                                    
                                    ),),
                                    SizedBox(width: 3,),
                                    Text(courses_list[index].Firstname!,// tutor name
                                    style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize:20,
                                    color:Color.fromARGB(255, 244, 244, 248),                                    
                                    ),),
                                  ],
                                ), 
                              Text(courses_list[index].major!, //tutor major
                                style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize:18,
                                color:Color.fromARGB(255, 244, 244, 248), 
                              ),),
                              ],
                            ),
                          ],
                        ),
                      ),
                    
                              ],
                            ), 
                          ),
                        ),
                      );
                      
                    }
                    
                  ),
                ),*/               
              ],
            ),
          //),
      
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
                    courses_list.removeAt(id);
                    print(courses_list.length);
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

 void insertData(String Tutor, String Field, String Price, 
 String Date, String StartTime, String EndTime, String StudentAccount, String UserID){
    Tutor = Tutor; Price = Price;
    Field = Field; Date = Date; StartTime= StartTime; EndTime = EndTime;
    StudentAccount = StudentAccount;
    UserID = UserID;
    print(Tutor);
    print(Field); print(Price); print(Date); print(StartTime); print(EndTime);
    print(StudentAccount); print(UserID);
    try {
                              
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      User? user = _auth.currentUser;
      BookingsModel bookingsModel = BookingsModel();
      bookingsModel.uid = user!.uid;
      bookingsModel.Tutor = Tutor;
      bookingsModel.Field = Field;
      bookingsModel.Price = Price;
      bookingsModel.Date = Date;
      bookingsModel.StartTime = StartTime;
      bookingsModel.EndTime = EndTime;
      bookingsModel.StuAccount = StudentAccount;
      bookingsModel.stuID = UserID;
       firebaseFirestore.collection("bookings")
      .add(bookingsModel.toMap());
      final snackBar = SnackBar( 
        content: Text("لقد تم حجز الحصة  ",
        style: const TextStyle(
          fontSize: 20, color: Color.fromARGB(255, 247, 240, 204)
        ),),
        backgroundColor: Color.fromARGB(255, 8, 1, 48),
        duration: const Duration(seconds: 5)
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      /*Navigator.pushReplacement
        (context, MaterialPageRoute(
        builder: (context) => AddSpecificCourseDesktop() ));*/
    } catch (e) {
      print(e);
      final snackBar = SnackBar(
        content: Text("لقد حصل خلل ما ",
        style: const TextStyle(
          fontSize: 20, color: Color.fromARGB(255, 247, 204, 204)
        ),),
        backgroundColor: Color.fromARGB(255, 8, 1, 48),
        duration: const Duration(seconds: 5)
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }


}
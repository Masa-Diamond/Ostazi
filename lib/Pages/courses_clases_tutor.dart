// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables


import 'package:flutter/material.dart';
import 'package:grad_project/Pages/TutorNavBar.dart';

import 'course_class.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grad_project/Pages/inbox-student.dart';
import 'package:firebase_auth/firebase_auth.dart';



final _firestore = FirebaseFirestore.instance;
late User signedInUser;

class ClassesPage extends StatefulWidget {
  const ClassesPage({super.key});

  @override
  State<ClassesPage> createState() => _ClassesPageState();
}

class _ClassesPageState extends State<ClassesPage> {
  List<Course> courses =[
    Course('1:00 PM','2:00 PM','10/23/2022','سبت',35,20),
    Course('11:00 PM','12:00 PM','10/27/2022','خميس',20,20),
    Course('2:00 PM','3:00 PM','10/29/2022','سبت',21,20),
    Course('3:00 PM','4:00 PM','11/3/2022','خميس',25,20),
    Course('1:00 PM','2:00 PM','11/5/2022','سبت',40,20),
    Course('10:00 PM','11:00 PM','11/10/2022','خميس',15,20),
    Course('12:00 PM','1:00 PM','1/12/2022','سبت',23,20),
  ];
  int sum=0;
  //courses.forEach((Course) => print();
  int _summation(int price, int num){
    sum = num*price;
    print(sum);
    return sum;
  }
  int mult=0;
  List selectedIndex = [];
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
  final info = FirebaseFirestore.instance
                        .collection("courses")
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .get()
                        .then((value) => value)
                        .then((value) => value.data());
  @override
  late String TutorrAccount;
  late String TutorrID;
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
      .collection("tutors").where('uid', isEqualTo: _auth.currentUser!.uid).snapshots();
      print(_auth.currentUser!.uid);
      DocumentSnapshot ds = await FirebaseFirestore.instance.collection('tutors').doc(_auth.currentUser!.uid).get();
      TutorrAccount = ds.get('Account');
      TutorrID = ds.get('uid');
      print(TutorrAccount);
      print(TutorrID);
      }
    } catch (e) {
      print(e);
    }
  }
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: TutorNavBar(),
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(size:30,color: Color.fromARGB(255, 192, 218, 240)),
        backgroundColor: Color.fromARGB(255, 4, 4, 71),
        /*leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new,size:20),
          onPressed: ),*/
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
    
      body: //SingleChildScrollView(
        //child: 
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*0.1,
              padding: const EdgeInsets.all(15),
              //margin: const EdgeInsets.only(top: 13, right:20,),
              color: Color.fromARGB(255, 4, 4, 71),
              child: Text('حصص المعهد',
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Colors.grey[300],
                fontSize:27, fontWeight: FontWeight.bold,
              ),),
            ),
            Divider(),
            StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('courses').snapshots(),
              builder: (BuildContext context, snapshot){
                if(!snapshot.hasData){
                  return Center(
                    child: Container(
                      child: Text("",
                      style: TextStyle(color: Color.fromARGB(255, 4, 1, 47), fontSize: 24, fontWeight: FontWeight.bold),),
                    ),
                  );
                }
                else{
                  var acc = FirebaseFirestore.instance.collection('tutors')
                  .doc(FirebaseAuth.instance.currentUser!.uid).get()
                  .then((value) => {
                    TutorrAccount = value.get('Account'),                                        
                  });
                  var num = FirebaseFirestore.instance.collection('bookings')
                  .doc(FirebaseAuth.instance.currentUser!.uid).get()
                  .then((value) => {
                    //number = value.get('Account'),                                        
                  });
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      
                      itemBuilder: (context, index){
                        var data = snapshot.data!.docs[index].data() as Map<String , dynamic>;
                        if(data['Tutor'].toString() == TutorrAccount){
                          return Container(
                            padding: const EdgeInsets.only(top:35),
                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  margin:const EdgeInsets.only(top:0),
                                  width:MediaQuery.of(context).size.width*0.673,
                                  height:MediaQuery.of(context).size.height*0.2,
                                  decoration: BoxDecoration(
                                    borderRadius:BorderRadius.only(
                                      topRight: Radius.circular(15),bottomRight:Radius.circular(15)),
                                      color:Color.fromARGB(255, 238, 216, 182),//Color.fromARGB(255, 250, 213, 218),
                                      //border:Border(left:BorderSide(width:1,color:Color.fromARGB(255, 4, 4, 71),)),
                                  ),
                                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          SizedBox(height: 15,),
                                          Row(mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              SizedBox(width:70,),
                                              Text(data['StartTimr'],
                                              style: TextStyle(
                                              fontSize:14, fontWeight: FontWeight.w700,
                                              color:Color.fromARGB(255, 4, 4, 71),
                                              ),),
                                              SizedBox(width: 2,),
                                              Text('-',
                                              style: TextStyle(
                                              fontSize:14, fontWeight: FontWeight.w700,
                                              color:Color.fromARGB(255, 4, 4, 71),
                                              ),),
                                              SizedBox(width: 2,),
                                              Text(data['EndTime'],
                                              style: TextStyle(
                                              fontSize:14, fontWeight: FontWeight.w700,
                                              color:Color.fromARGB(255, 4, 4, 71),
                                              ),), 
                                              SizedBox(width: 2,),
                                              Text("|",
                                              style: TextStyle(
                                              fontSize:17, fontWeight: FontWeight.bold,
                                              color:Color.fromARGB(255, 4, 4, 71),
                                              ),),
                                              SizedBox(width: 2,),
                                              Text(data['Day'],
                                              style: TextStyle(
                                              fontSize:16, fontWeight: FontWeight.w800,
                                              color:Color.fromARGB(255, 4, 4, 71),
                                              ),), 
                                            ],
                                          ),
                                          SizedBox(height:7,),
                                          Row(
                                            children: [
                                              Text(data['Date'],
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                              fontSize:18, fontWeight: FontWeight.w700,
                                              color:Color.fromARGB(255, 4, 4, 71),
                                              ),),
                                              SizedBox(width:10,),
                                              Icon(Icons.calendar_month_sharp,size:20,
                                              color:Color.fromARGB(255, 4, 4, 71),),
                                            ],
                                          ),
                                          SizedBox(height:7,),
                                          Row(
                                            children: [
                                              SizedBox(width: 7,),
                                              Text(data['Price'],
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                              fontSize:16, fontWeight: FontWeight.w700,
                                              color:Color.fromARGB(255, 4, 4, 71),
                                              ),),
                                              Text(" :سعر الحصة",
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                              fontSize:16, fontWeight: FontWeight.w700,
                                              color:Color.fromARGB(255, 4, 4, 71),
                                              ),),
                                            ],
                                          ),
                                          SizedBox(height:7,),
                                          /*Row(
                                            children: [
                                              Text("${_summation(courses[index].Price,courses[index].num)}",
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                              fontSize:16, fontWeight: FontWeight.w700,
                                              color:Color.fromARGB(255, 4, 4, 71),
                                              ),),
                                              SizedBox(width: 3,),
                                              
                                              Text(" :المجموع",
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                              fontSize:16, fontWeight: FontWeight.w700,
                                              color:Color.fromARGB(255, 4, 4, 71),
                                              ),),
                                            ],
                                          ), */                               
                                        ],
                                      ),     
                                      Container(width:5,
                                      height:MediaQuery.of(context).size.height*0.17,
                                      color:Color.fromARGB(255, 4, 4, 71),),                                     
                                    ],
                                  ),
                                ),
                                SizedBox(width: 30,),
                                Container(
                                  margin: const EdgeInsets.only(right:25),
                                  child: Column( 
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        child: Text(data['StartTimr'],
                                        style: TextStyle(
                                          fontSize: 16, fontWeight: FontWeight.w500,
                                          color: Color.fromARGB(255,136,139,122),
                                        ),),
                                      ),
                                      SizedBox(height: 20,),
                                      Container(
                                        width: 10, height: 2,
                                        color: Color.fromARGB(255, 218, 165, 172),
                                      ),
                                      SizedBox(height:20),
                                      Container(
                                        width: 40, height: 2,
                                        color: Color.fromARGB(255, 218, 165, 172),
                                      ),
                                      SizedBox(height: 20,),
                                      Container(
                                        width: 10, height: 2,
                                        color: Color.fromARGB(255, 218, 165, 172),
                                      ),
                                      SizedBox(height: 20,),
                                      Container(
                                        width: 40, height: 2,
                                        color: Color.fromARGB(255, 218, 165, 172),
                                      ),
                                      SizedBox(height: 20,), 
                                      Container(
                                        child: Text(data['EndTime'],
                                        style: TextStyle(
                                          fontSize: 16, fontWeight: FontWeight.w500,
                                          color: Color.fromARGB(255,136,139,122),
                                        ),),
                                      ),
                                      SizedBox(height: 20,),
                                      Container(
                                        width: 10, height: 2,
                                        color: Color.fromARGB(255, 218, 165, 172),
                                      ),
                                      SizedBox(height:20,),
                                      Container(
                                        width: 40, height: 2,
                                        color: Color.fromARGB(255, 218, 165, 172),
                                      ),
                                      SizedBox(height: 20,),
                                      Container(
                                        width: 10, height: 2,
                                        color: Color.fromARGB(255, 218, 165, 172),
                                      ),
                                      SizedBox(height: 20,),
                                      Container(
                                        width: 40, height: 2,
                                        color: Color.fromARGB(255, 218, 165, 172),
                                      ),
                                      SizedBox(height:20,),
                                      Container(
                                      width: 60, height:3,
                                      color: Color.fromARGB(255, 56, 36, 38),
                                      ),
                                
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        return Container();
                      }
                    ),
                  );
                }
              }
            ),
            /*Expanded(
              child: ListView.builder(
                itemCount:courses.length,
                itemBuilder: (context,index){
                  return Container(
                    padding: const EdgeInsets.only(top:35),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          margin:const EdgeInsets.only(top:0),
                          width:MediaQuery.of(context).size.width*0.673,
                          height:MediaQuery.of(context).size.height*0.2,
                          decoration: BoxDecoration(
                            borderRadius:BorderRadius.only(
                              topRight: Radius.circular(15),bottomRight:Radius.circular(15)),
                              color:Color.fromARGB(255, 238, 216, 182),//Color.fromARGB(255, 250, 213, 218),
                              //border:Border(left:BorderSide(width:1,color:Color.fromARGB(255, 4, 4, 71),)),
                          ),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      SizedBox(width:30,),
                                      Text(courses[index].StartTime!,
                                      style: TextStyle(
                                      fontSize:14, fontWeight: FontWeight.w700,
                                      color:Color.fromARGB(255, 4, 4, 71),
                                      ),),
                                      SizedBox(width: 2,),
                                      Text('-',
                                      style: TextStyle(
                                      fontSize:14, fontWeight: FontWeight.w700,
                                      color:Color.fromARGB(255, 4, 4, 71),
                                      ),),
                                      SizedBox(width: 2,),
                                      Text(courses[index].LastTime!,
                                      style: TextStyle(
                                      fontSize:14, fontWeight: FontWeight.w700,
                                      color:Color.fromARGB(255, 4, 4, 71),
                                      ),),
                                      SizedBox(width: 2,),
                                      Text("|",
                                      style: TextStyle(
                                      fontSize:17, fontWeight: FontWeight.bold,
                                      color:Color.fromARGB(255, 4, 4, 71),
                                      ),),
                                      SizedBox(width: 2,),
                                      Text(courses[index].Date!,
                                      style: TextStyle(
                                      fontSize:14, fontWeight: FontWeight.w700,
                                      color:Color.fromARGB(255, 4, 4, 71),
                                      ),),   
                                    ],
                                  ),
                                  SizedBox(height:7,),
                                  Row(
                                    children: [
                                      Text(courses[index].Day!,
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                      fontSize:25, fontWeight: FontWeight.w700,
                                      color:Color.fromARGB(255, 4, 4, 71),
                                      ),),
                                      SizedBox(width:10,),
                                      Icon(Icons.calendar_today_sharp,size:20,
                                      color:Color.fromARGB(255, 4, 4, 71),),
                                    ],
                                  ),
                                  SizedBox(height:7,),
                                  Row(
                                    children: [
                                      Text("${courses[index].num}",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                      fontSize:16, fontWeight: FontWeight.w700,
                                      color:Color.fromARGB(255, 4, 4, 71),
                                      ),),
                                      Text(" :عدد الطلاب",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                      fontSize:16, fontWeight: FontWeight.w700,
                                      color:Color.fromARGB(255, 4, 4, 71),
                                      ),),
                                      SizedBox(width: 7,),
                                      Text("|",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                      fontSize:16, fontWeight: FontWeight.w700,
                                      color:Color.fromARGB(255, 4, 4, 71),
                                      ),),
                                      SizedBox(width: 7,),
                                      Text("${courses[index].Price}",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                      fontSize:16, fontWeight: FontWeight.w700,
                                      color:Color.fromARGB(255, 4, 4, 71),
                                      ),),
                                      Text(" :سعر الحصة",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                      fontSize:16, fontWeight: FontWeight.w700,
                                      color:Color.fromARGB(255, 4, 4, 71),
                                      ),),
                                    ],
                                  ),
                                  SizedBox(height:7,),
                                  Row(
                                    children: [
                                      Text("${_summation(courses[index].Price,courses[index].num)}",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                      fontSize:16, fontWeight: FontWeight.w700,
                                      color:Color.fromARGB(255, 4, 4, 71),
                                      ),),
                                      SizedBox(width: 3,),
                                      /*GestureDetector(
                                        onTap: (){
                                          setState(() {
                                            checkSelectedCard(index);
                                            tapped_index = index;
                                            selected(tapped_index);
                                            print(index);
                                            
                                            int price = courses[index].Price;
                                            int number =courses[index].num;
                                            mult=price*number;
                                           print(mult);
                                          });
                                          
                                        },
                                        child: Container(
                                          //color:selectedIndex.contains(index)?Color.fromARGB(255, 218, 171, 178):Color.fromARGB(255, 250, 213, 218),
                                        //height:30,width:130,
                                        child: Text(':اضغط لايجاد المجموع',
                                        style: TextStyle(
                                          fontSize:16, fontWeight: FontWeight.w700,
                                          color:selectedIndex.contains(index)?Color.fromARGB(255, 82, 82, 118):Colors.red[900],
                                        ),),
                                        ),
                                      ),*/
                                      
                                      Text(" :المجموع",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                      fontSize:16, fontWeight: FontWeight.w700,
                                      color:Color.fromARGB(255, 4, 4, 71),
                                      ),),
                                    ],
                                  ),                                
                                ],
                              ),     
                              Container(width:5,
                              height:MediaQuery.of(context).size.height*0.17,
                              color:Color.fromARGB(255, 4, 4, 71),),
                              
                          ],),
                        ),
                        SizedBox(width: 40,),
                        Container(
                          margin: const EdgeInsets.only(right:25),
                          child: Column( 
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                child: Text(courses[index].StartTime!,
                                style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500,
                                  color: Color.fromARGB(255,136,139,122),
                                ),),
                              ),
                               SizedBox(height: 20,),
                              Container(
                                width: 10, height: 2,
                                color: Color.fromARGB(255, 218, 165, 172),
                              ),
                              SizedBox(height:20),
                              Container(
                                width: 40, height: 2,
                                color: Color.fromARGB(255, 218, 165, 172),
                              ),
                              SizedBox(height: 20,),
                              Container(
                                width: 10, height: 2,
                                color: Color.fromARGB(255, 218, 165, 172),
                              ),
                              SizedBox(height: 20,),
                              Container(
                                width: 40, height: 2,
                                color: Color.fromARGB(255, 218, 165, 172),
                              ),
                              SizedBox(height: 20,), 
                              Container(
                                child: Text(courses[index].LastTime!,
                                style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500,
                                  color: Color.fromARGB(255,136,139,122),
                                ),),
                              ),
                               SizedBox(height: 20,),
                              Container(
                                width: 10, height: 2,
                                color: Color.fromARGB(255, 218, 165, 172),
                              ),
                              SizedBox(height:20,),
                              Container(
                                width: 40, height: 2,
                                color: Color.fromARGB(255, 218, 165, 172),
                              ),
                              SizedBox(height: 20,),
                              Container(
                                width: 10, height: 2,
                                color: Color.fromARGB(255, 218, 165, 172),
                              ),
                              SizedBox(height: 20,),
                              Container(
                                width: 40, height: 2,
                                color: Color.fromARGB(255, 218, 165, 172),
                              ),
                              SizedBox(height:20,),
                              Container(
                              width: 60, height:3,
                              color: Color.fromARGB(255, 56, 36, 38),
                              ),
                        
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),*/
          ],
        ),
      //),
      
    );
  }
}
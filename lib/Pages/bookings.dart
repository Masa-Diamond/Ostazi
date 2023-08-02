// ignore_for_file: camel_case_types, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:grad_project/Pages/NavBar.dart';
import 'package:grad_project/Pages/home.dart';
import 'package:grad_project/Pages/bookings_class.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grad_project/Pages/inbox-student.dart';
import 'package:firebase_auth/firebase_auth.dart';



final _firestore = FirebaseFirestore.instance;
late User signedInUser;

class bookings extends StatefulWidget {
  const bookings({super.key});

  @override
  State<bookings> createState() => _bookingsState();
}

class _bookingsState extends State<bookings> {
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
 /* static List<BookingsModel> bookings = [
    BookingsModel( 'أيمن','صبوح', 'فيزياء', 20,'اربعاء','10/27/2022','1:00 PM','2:00 PM'),
    BookingsModel( 'حمدي ','وهبة', 'رياضيات', 20,'تلاتاء','10/28/2022','2:00 PM','3:00 PM'),
    BookingsModel( 'غسان ','الساحلي', 'كيمياء', 20,'خميس','10/30/2022','3:00 PM','4:00 PM'),
    BookingsModel( 'ماسة ', 'السيد','الانجليزية', 25,'سبت','10/31/2022','11:00 AM','12:00 AM'),
    BookingsModel( 'ميرا','صايمه', 'رياضيات', 20,'سبت','11/5/2022','2:00 PM','3:00 PM'),
  ];
   List<BookingsModel> bookings_list = List.from(bookings);*/
   final info = FirebaseFirestore.instance
                        .collection("bookings")
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .get()
                        .then((value) => value)
                        .then((value) => value.data());
  @override
  late String StudentAccount;
  late String StudentID;
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
      DocumentSnapshot ds = await FirebaseFirestore.instance.collection('users').doc(_auth.currentUser!.uid).get();
      StudentAccount = ds.get('Account');
      StudentID = ds.get('uid');
      print(StudentAccount);
      print(StudentID);
      }
    } catch (e) {
      print(e);
    }
  }
  DeleteData(id) async{
    await FirebaseFirestore.instance.collection('bookings').doc(id).delete();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        iconTheme: IconThemeData(size:30,color: Color.fromARGB(255, 192, 218, 240)),
        elevation: 8,
        // ignore: prefer_const_constructors
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
          ],
        ),
      ),

      body: 
       //SingleChildScrollView(
           // child: 
            Column(
              children:<Widget> [
                SizedBox(height: 15,),
                Text(':حجوزاتي ',
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
                      image: AssetImage("assets/images/cyborg-117.gif"),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                StreamBuilder<QuerySnapshot>(
                  stream: _firestore.collection('bookings').snapshots(),
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
                      var acc = FirebaseFirestore.instance.collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid).get()
                        .then((value) => {
                          StudentID = value.get('uid'),
                          
                          
                        });
                    return Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                      
                        itemBuilder: (context, index){
                          var data = snapshot.data!.docs[index].data() as Map<String , dynamic>;
                          if(data['stuID'].toString() == StudentID){
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
                                    /*checkSelectedCard(index+1);
                                    tapped_index = index;
                                    selected(tapped_index);*/
                                    
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
                                          Text(data['StartTime'],// the begin hour
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
                            ),
                          );
                          }
                          return Container();
                        }
                      ),
                    );}
                  }
                ),
                /*Expanded(
                  //Color.fromARGB(255, 170, 207, 173),
                  child: ListView.builder(            
                    padding: EdgeInsets.all(7),
                    shrinkWrap: true,
                    itemCount: bookings_list.length,
                    itemBuilder: (context, index){
                      return AnimationConfiguration.staggeredList(position: index,
                       child: SlideAnimation(
                        child: FadeInAnimation(
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container( 
                                padding: EdgeInsets.symmetric(horizontal:2,vertical: 20),
                                margin: EdgeInsets.only(bottom: 11),
                                width: MediaQuery.of(context).size.width*0.95,
                                height: MediaQuery.of(context).size.height*0.20,
                                decoration: BoxDecoration(
                                color: colors[index],
                                borderRadius: BorderRadius.all(Radius.circular(20),),
                                border: Border.all(width:2,color:Color.fromARGB(255, 14, 1, 36),//Color.fromARGB(255, 249, 222, 87),
                                ),
                                boxShadow: [BoxShadow(
                                //color: Color.fromARGB(255, 222, 219, 242),
                                spreadRadius:1, blurRadius: 2,
                                ),],
                                ),
                                child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children:[
                            GestureDetector(
                              onTap: (){
                                _showSheet(context,index);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                width:70,height:45,
                                decoration: BoxDecoration(
                                  color:Color.fromARGB(255, 1, 34, 60),//Color.fromARGB(255, 117, 54, 49),
                                  borderRadius:BorderRadius.all(Radius.circular(15)) 
                                ),
                                child: Text('الغاء',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,fontSize:22,
                                  color:Colors.white, 
                                ),),
                              ),
                            ),
                           /* FloatingActionButton.extended(
                              label: Text('الغاء',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color:Color.fromARGB(255, 4, 4, 71), 
                              ),),
                              backgroundColor:Color.fromARGB(255, 216, 65, 65),
                              icon: Icon(Icons.cancel,size: 20,
                              color:Color.fromARGB(255, 4, 4, 71),),
                              onPressed: (){

                                },
                            ),*/
                            Column(
                              //padding: EdgeInsets.all(10),
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:[
                                Row(
                                  children:[
                                    Text("${bookings_list[index].price}",
                                    style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
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
                                  children:[
                                    Icon(Icons.dashboard, size:25,color:Color.fromARGB(255, 187, 93, 128),//Color.fromARGB(255, 179, 141, 127)//Color.fromARGB(255, 250, 5, 156),
                                    ),
                                    SizedBox(width:5),
                                    Text("${bookings_list[index].Day}",
                                    style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize:16,
                                    color:Color.fromARGB(255, 244, 244, 248), 
                                    ),), 
                                  ],
                                ),
                                Row(
                                  children: [ 
                                    Icon(Icons.access_time, size:25,color:Color.fromARGB(255, 2, 40, 88),//Color.fromARGB(255, 149, 107, 92)//Color.fromARGB(255, 107, 242, 201),
                                    ),
                                    SizedBox(width:5),
                                    ///الوقت من أي ساعة لأي ساعة
                                    Text(bookings_list[index].initTime!,// the begin hour
                                    style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize:16,
                                    color:Color.fromARGB(255, 244, 244, 248),),),
                                    SizedBox(width: 5,),
                                    Text('-',
                                    style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize:16,
                                    color:Color.fromARGB(255, 244, 244, 248),),),
                                    SizedBox(width: 5,),
                                    Text(bookings_list[index].endTime!,//the end of the hour
                                    style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize:16,
                                    color:Color.fromARGB(255, 244, 244, 248),),),
                                  ],
                                ),
                                Row(
                                  children:[
                                    Icon(Icons.date_range, size:25,color:Color.fromARGB(255, 114, 76, 62),//Color.fromARGB(255, 252, 245, 147),
                                    ),
                                    SizedBox(width:5),
                                    ///اتاريخ
                                    Text(bookings_list[index].date!,//date day
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
                              children: [
                                Row(
                                  children: [
                                    Text(bookings_list[index].Lastname!,// tutor name
                                    style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize:22,
                                    color:Color.fromARGB(255, 244, 244, 248),                                    
                                    ),),
                                    SizedBox(width: 3,),
                                    Text(bookings_list[index].Firstname!,// tutor name
                                    style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize:22,
                                    color:Color.fromARGB(255, 244, 244, 248),                                    
                                    ),),
                                  ],
                                ), 
                              Text(bookings_list[index].major!,
                                style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize:19, 
                                color:Color.fromARGB(255, 244, 244, 248), 
                              ),),
                              ],
                            ),
                          ],
                        ),
                      ), 

                            ],
                          ) 
                          ),
                       ),
                       ); 
                    }
                    //children: <Widget>[
                     /* 
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
                              label: Text('الغاء',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color:Color.fromARGB(255, 4, 4, 71), 
                              ),),
                              backgroundColor:Color.fromARGB(255, 216, 65, 65),
                              icon: Icon(Icons.cancel,size: 20,
                              color:Color.fromARGB(255, 4, 4, 71),),
                              onPressed: (){

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
                                    Icon(Icons.dashboard, size:25,color:Color.fromARGB(255, 250, 5, 156),),
                                    SizedBox(width:5),
                                    Text('الأحد',
                                    style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                    color:Color.fromARGB(255, 244, 244, 248), 
                                    ),), 
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Icon(Icons.punch_clock_rounded, size:25,color:Color.fromARGB(255, 107, 242, 201),),
                                    SizedBox(width:5),
                                    Text('3:00',
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
                          border: Border.all(width: 4,color: Color.fromARGB(255, 233, 174, 221),),
                          boxShadow: [BoxShadow(
                            color: Color.fromARGB(255, 222, 219, 242),
                            spreadRadius: 5, blurRadius: 5,
                          ),],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            
                            FloatingActionButton.extended(
                              label: Text('الغاء',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color:Color.fromARGB(255, 4, 4, 71), 
                              ),),
                              backgroundColor:Color.fromARGB(255, 216, 65, 65),
                              icon: Icon(Icons.cancel,size: 20,
                              color:Color.fromARGB(255, 4, 4, 71),),
                              onPressed: (){

                                },
                            ),
                            Column(
                              //padding: EdgeInsets.all(10),
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text('20',
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
                                    Icon(Icons.dashboard, size:25,color:Color.fromARGB(255, 250, 5, 156),),
                                    SizedBox(width:5),
                                    Text('السبت',
                                    style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                    color:Color.fromARGB(255, 244, 244, 248), 
                                    ),), 
                                  ],
                                ), 
                                Row(
                                  children: <Widget>[
                                    Icon(Icons.punch_clock_rounded, size:25,color:Color.fromARGB(255, 107, 242, 201),),
                                    SizedBox(width:5),
                                    Text('1:00',
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
                ),  */             
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
                    //bookings_list.removeAt(id);
                    //print(bookings_list.length);
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
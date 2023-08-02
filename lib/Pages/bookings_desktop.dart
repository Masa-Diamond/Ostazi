// ignore_for_file: unused_import, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:grad_project/Pages/bookings_admin_class.dart';
import 'package:grad_project/Pages/side_bar_admin.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grad_project/Pages/inbox-student.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firestore = FirebaseFirestore.instance;
late User signedInUser;

class BookingsDesktop extends StatefulWidget {
  const BookingsDesktop({super.key});

  @override
  State<BookingsDesktop> createState() => _BookingsDesktopState();
}

class _BookingsDesktopState extends State<BookingsDesktop> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusDate = DateTime.now();
  DateTime _selectedDate =DateTime.now();
  

  List selectedIndex = [];
  List <BookingsAdmin> bookings =[
    BookingsAdmin("فيزياء", "أيمن", "صبوح", "أحمد", "طلال",20,"1:00 PM","2:00 PM","11/7/2022","أيمن صبوح"),
    BookingsAdmin("كيمياء", "غسان", "الساحلي", "بانا", "عبد",25,"2:00 PM","3:00 PM","10/27/2022","غسان الساحلي"),
    BookingsAdmin("رياضيات", "حمدي", "وهبة", "سعد", "أيمن",30,"3:00 PM","4:00 PM","11/3/2022","حمدي وهبة"),
     BookingsAdmin("الانجليزية", "ماسة", "السيد", "هلا", "رياض",20,"4:00 PM","5:00 PM","11/3/2022","ماسة السيد"),
    BookingsAdmin("فيزياء", "أيمن", "صبوح", "زيد", "ياسين",20,"1:00 PM","2:00 PM","11/3/2022","أيمن صبوح"),
    BookingsAdmin("كيمياء", "غسان", "الساحلي", "خولة", "بريك",25,"2:00 PM","3:00 PM","11/3/2022","غسان الساحلي"),
     BookingsAdmin("رياضيات", "حمدي", "وهبة", "فرح", "أيمن",30,"3:00 PM","4:00 PM","11/3/2022","حمدي وهبة"),
     BookingsAdmin("الانجليزية", "ماسة", "السيد", "حسين", "هارون",20,"4:00 PM","5:00 PM","11/3/2022","ماسة السيد"),
    BookingsAdmin("فيزياء", "أيمن", "صبوح", "انس", "سعد الدين",20,"1:00 PM","2:00 PM","11/3/2022","أيمن صبوح"),
    BookingsAdmin("كيمياء", "غسان", "الساحلي", "هاشم", "خريم",25,"2:00 PM","3:00 PM","11/3/2022","غسان الساحلي"),
     BookingsAdmin("رياضيات", "حمدي", "وهبة", "جاد", "أيمن",30,"3:00 PM","4:00 PM","11/3/2022","حمدي وهبة"),
     BookingsAdmin("الانجليزية", "ماسة", "السيد", "فاروق", "محمد",20,"4:00 PM","5:00 PM","10/27/2022","ماسة السيد"),
    BookingsAdmin("فيزياء", "أيمن", "صبوح", "لانا", "السقة",20,"1:00 PM","2:00 PM","11/7/2022","أيمن صبوح"),
    BookingsAdmin("كيمياء", "غسان", "الساحلي", "محمد", "شكعة",25,"2:00 PM","3:00 PM","11/7/2022","غسان الساحلي"),
     BookingsAdmin("رياضيات", "حمدي", "وهبة", "رنا", "أيمن",30,"3:00 PM","4:00 PM","11/7/2022","حمدي وهبة"),
     BookingsAdmin("الانجليزية", "ماسة", "السيد", "هالة", "زيدان",20,"4:00 PM","5:00 PM","11/7/2022","ماسة السيد"),
    BookingsAdmin("فيزياء", "أيمن", "صبوح", "باسل", "كيلاني",20,"1:00 PM","2:00 PM","11/7/2022","أيمن صبوح"),
    BookingsAdmin("كيمياء", "غسان", "الساحلي", "عاصم", "قادري",25,"2:00 PM","3:00 PM","11/7/2022","غسان الساحلي"),
     BookingsAdmin("رياضيات", "حمدي", "وهبة", "جهان", "أيمن",30,"3:00 PM","4:00 PM","11/7/2022","حمدي وهبة"),
     BookingsAdmin("الانجليزية", "ماسة", "السيد", "سمير", "محمد",20,"4:00 PM","5:00 PM","11/7/2022","ماسة السيد"),
    BookingsAdmin("فيزياء", "أيمن", "صبوح", "ميس", "علي",20,"1:00 PM","2:00 PM","11/7/2022","أيمن صبوح"),
    BookingsAdmin("كيمياء", "غسان", "الساحلي", "ديانا", "رائد",25,"2:00 PM","3:00 PM","11/7/2022","غسان الساحلي"),
     BookingsAdmin("رياضيات", "حمدي", "وهبة", "كرم", "أيمن",30,"3:00 PM","4:00 PM","11/7/2022","حمدي وهبة"),
     BookingsAdmin("الانجليزية", "ماسة", "السيد", "غدير", "سايح",20,"4:00 PM","5:00 PM","11/3/2022","ماسة السيد"),
     BookingsAdmin("فيزياء", "أيمن", "صبوح", "ملك", "هليان",20,"1:00 PM","2:00 PM","11/3/2022","أيمن صبوح"),
    BookingsAdmin("كيمياء", "غسان", "الساحلي", "لين", "رائد",25,"2:00 PM","3:00 PM","11/3/2022","غسان الساحلي"),
     BookingsAdmin("رياضيات", "حمدي", "وهبة", "سلام", "أحمد",30,"3:00 PM","4:00 PM","11/3/2022","حمدي وهبة"),
     BookingsAdmin("الانجليزية", "ماسة", "السيد", "خالد", "عمر",20,"4:00 PM","5:00 PM","11/3/2022","ماسة السيد"),
  ];
  
  List filteredBookings =[];
  String _selected = "";
  List <String> dropDown =["أيمن صبوح","غسان الساحلي","حمدي وهبة","ماسة السيد"];
  String _selected2 = "";
  List <String> dropDown2 =["فيزياء","كيمياء","رياضيات","الانجليزية"];
  int count =0;
  int money=0;
  int ClassPrice =0;
  String _all ="جميع الحجوزات";
   
 
   int counter=0;
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
  String Moneyy ='';
  /*int SumeData(id) async{
     Money = await FirebaseFirestore.instance.collection('courses').doc(id).toString();
  }*/
  
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color.fromARGB(255, 4, 4, 71),

      body: SafeArea(
        child: Row(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Expanded(
              child: SideBar()
            ),

            Expanded(
              flex: 4,
              child: Container(
                margin: EdgeInsets.all(15),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color:Color.fromARGB(255, 244, 244, 248),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Row( crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 4,
                            child: Container( 
                              child: Column( 
                                children: [
                                  SizedBox(width: MediaQuery.of(context).size.width*0.75,),
                                  /////////////////////////////////////////////SELECTRING
                                  SizedBox(height:30,),
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
                                          counter =0; money=0;
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
                                  SizedBox(width: 10,),
                                  Container(
                                    child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              print("here");
                                              print(counter);
                                              print(money);
                                            });
                                          }, 
                                          behavior: HitTestBehavior.opaque,
                                          child: Container(
                                            padding: EdgeInsets.all(8),
                                            margin: EdgeInsets.all(8),
                                            width: MediaQuery.of(context).size.width*0.1,
                                            height: MediaQuery.of(context).size.height*0.1,
                                            decoration: BoxDecoration(
                                              color: Color.fromARGB(255, 244, 244, 248),
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                            child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text("اوجد",
                                                style: TextStyle(
                                                  fontSize: 16, color: Color.fromARGB(255, 12, 1, 58),
                                                ),),
                                                SizedBox(width: 4,),
                                                Icon(Icons.calculate,color: Color.fromARGB(255, 159, 36, 28),
                                                size: 40,),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(width:55,),
                                        Text("₪",
                                         style:TextStyle(
                                          color: Color.fromARGB(255, 6, 1, 46),
                                          fontWeight: FontWeight.w600, fontSize: 18
                                        ),),
                                        SizedBox(width: 1,),
                                        Text("${money/2}"),
                                        SizedBox(width: 5,),
                                        Text(" :المبلغ المالي",
                                          style: TextStyle(
                                            color: Color.fromARGB(255, 6, 1, 46),
                                            fontWeight: FontWeight.w600, fontSize: 18
                                        ),),
                                        SizedBox(width:35,),
                                        Text(":عدد الطلاب",
                                         style:TextStyle(
                                          color: Color.fromARGB(255, 6, 1, 46),
                                          fontWeight: FontWeight.w600, fontSize: 18
                                        ),),
                                        SizedBox(width: 5,),
                                        Text("${counter/2}"),
                                      ],
                                    ),
                                  ),
                                  /*Container(
                                    width: MediaQuery.of(context).size.width,
                                    height:50,
                                    margin: EdgeInsets.all(8),
                                    child: Row(mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        /*Container(
                                            padding: EdgeInsets.all(5),
                                            margin: EdgeInsets.only(right: 5),
                                            width:15, 
                                            height:35,
                                            decoration:BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(20),
                                            border: Border.all(width: 1, color: Color.fromARGB(255, 219, 217, 217)),
                                            boxShadow:[BoxShadow(blurRadius: 3, spreadRadius: 3,color:Color.fromARGB(255, 219, 217, 217) )]
                                          ),
                                          child: Text("${counter}",
                                          textAlign: TextAlign.center,
                                          style:TextStyle(
                                            color: Color.fromARGB(255, 10, 1, 46),
                                            fontWeight: FontWeight.bold, fontSize:15
                                          ),),
                                          ),*/
                                        GestureDetector(

                                          onTap: (){
                                            setState(() {
                                              _selected = _all;
                                              _selected2 = _all;
                                              counter =0;
                                              money=0;
                                              for(int i=0; i<bookings.length; i++){
                                                if(bookings[i].dates == DateFormat.yMd().format(_selectedDate)){
                                                  counter++;
                                                  ClassPrice=bookings[i].price;
                                                  money=money+ClassPrice;
                                                }
                                              }
                                            });
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(5),
                                            margin: EdgeInsets.only(right:35),
                                            width:130, 
                                            height:35,
                                            decoration:BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(20),
                                            border: Border.all(width: 1, color: Color.fromARGB(255, 219, 217, 217)),
                                            boxShadow:[BoxShadow(blurRadius: 3, spreadRadius: 3,color:Color.fromARGB(255, 219, 217, 217) )]
                                          ),
                                          child: Text(_all,
                                          textAlign: TextAlign.center,
                                          style:TextStyle(
                                            color: Color.fromARGB(255, 10, 1, 46),
                                            fontWeight: FontWeight.bold, fontSize:15
                                          ),),
                                          ),
                                        ),

                                        Container(
                                          width:220, 
                                          height: 50,
                                          decoration:BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(20),
                                            border: Border.all(width: 1, color: Color.fromARGB(255, 219, 217, 217)),
                                            boxShadow:[BoxShadow(blurRadius: 3, spreadRadius: 3,color:Color.fromARGB(255, 219, 217, 217) )]
                                          ),
                                          margin: EdgeInsets.all(8),
                                          child: Row(mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Text(_selected,
                                                style:TextStyle(
                                                  color: Color.fromARGB(255, 10, 1, 46),
                                                  fontWeight: FontWeight.bold, fontSize: 17
                                                ),),
                                              ),
                                              DropdownButton(
                                                icon: Icon(Icons.keyboard_arrow_down,
                                                color:Color.fromARGB(255, 88, 88, 100),),
                                                iconSize:20, 
                                                elevation: 4,
                                                underline: Container(height: 0,),
                                                style: TextStyle(
                                                  color:Color.fromARGB(255, 57, 57, 67),
                                                  fontSize: 17, fontWeight:FontWeight.w500,
                                                ),
                                                onChanged: (String? newValue){
                                                setState(() {
                                                  counter =0;
                                                  money=0;
                                                  _selected = newValue!;
                                                  _selected2=" ";
                                                  for(int i=0; i<bookings.length; i++){
                                                    if(bookings[i].dates == DateFormat.yMd().format(_selectedDate)){
                                                      if(bookings[i].Account! == _selected){
                                                        counter++;
                                                        ClassPrice = bookings[i].price;
                                                      }
                                                    }
                                                  }
                                                  money = ClassPrice*counter;
                                                  print("counter: ");
                                                  print(counter);
                                                }); 
                                                },
                                                items: dropDown.map<DropdownMenuItem<String>>((String? value){
                                                  return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value!,
                                                  style:TextStyle(
                                                  color:Color.fromARGB(255, 57, 57, 67),
                                                  fontSize: 17, fontWeight:FontWeight.w500,
                                                  ),),
                                                );
                                                }).toList(),
                                              ),                                             
                                            ],
                                          ),
                                        ),
                                        SizedBox(width:5,),
                                        Text("الأستاذ",
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 10, 1, 46),
                                          fontWeight: FontWeight.bold, fontSize:17
                                        ),),

                                        SizedBox(width:15,),
                                        
                                        Container(
                                          width:220, 
                                          height: 50,
                                          decoration:BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(20),
                                            border: Border.all(width: 1, color: Color.fromARGB(255, 219, 217, 217)),
                                            boxShadow:[BoxShadow(blurRadius: 3, spreadRadius: 3,color:Color.fromARGB(255, 219, 217, 217) )]
                                          ),
                                          //color: Colors.pink[200],
                                          margin: EdgeInsets.all(8),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Text(_selected2,
                                                style:TextStyle(
                                                  color: Color.fromARGB(255, 10, 1, 46),
                                                  fontWeight: FontWeight.bold, fontSize:17
                                                ),),
                                              ),
                                              DropdownButton(
                                                icon: Icon(Icons.keyboard_arrow_down,
                                                color:Color.fromARGB(255, 88, 88, 100),),
                                                iconSize:20, 
                                                elevation: 4,
                                                underline: Container(height: 0,),
                                                style: TextStyle(
                                                  color:Color.fromARGB(255, 57, 57, 67),
                                                  fontSize: 17, fontWeight:FontWeight.w500,
                                                ),
                                                onChanged: (String? newValue){
                                                setState(() {
                                                  _selected2 = newValue!;
                                                  _selected=" ";
                                                  counter=0;
                                                  money=0;
                                                  for(int i=0; i<bookings.length; i++){
                                                    if(bookings[i].dates == DateFormat.yMd().format(_selectedDate)){
                                                      if(bookings[i].major! == _selected2){
                                                        counter++;
                                                      }
                                                    }
                                                  }
                                                  //print(_selected);
                                                }); 
                                                },
                                                items: dropDown2.map<DropdownMenuItem<String>>((String? value){
                                                  return DropdownMenuItem<String>(
                                                    onTap: (){},
                                                  value: value,
                                                  child: Text(value!,
                                                  style:TextStyle(
                                                  color:Color.fromARGB(255, 57, 57, 67),
                                                  fontSize:17, fontWeight:FontWeight.w500,
                                                  ),),
                                                );
                                                }).toList(),
                                              ),
                                              
                                            ],
                                          ),
                                        ),
                                        SizedBox(width:5,),
                                        Text("المادة",
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 10, 1, 46),
                                          fontWeight: FontWeight.bold, fontSize:17
                                        ),),
                                      ],
                                    ),
                                  ),*/
                                  
                                  SizedBox(height: 20,),
                                  Container(
                                    margin:const EdgeInsets.only(top:20, left: 20) ,
                                    child: DatePicker(
                                      DateTime.now(),
                                      height: 100, width: 80,
                                      initialSelectedDate:DateTime.now(),
                                      selectionColor:Color.fromARGB(255, 100, 100, 145),
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
                                          money = 0;
                                          counter =0;
                                          print(DateFormat.yMd().format(_selectedDate));
                                        }); 
                                      },
                                    ),
                                  ),
                                  SizedBox(height:70,),

                                  StreamBuilder<QuerySnapshot>(
                                    stream: _firestore.collection('bookings').snapshots(),
                                    builder: (BuildContext context, snapshot){
                                      if(!snapshot.hasData){
                                        return Center(
                                          child: Container(
                                            child: Text("!لا يوجد أي حصص في هذا اليوم",
                                            style: TextStyle(color: Color.fromARGB(255, 4, 1, 47), fontSize: 24, fontWeight: FontWeight.bold),),
                                          ),
                                        );
                                      }
                                      return Expanded(
                                        child: ListView.builder(
                                          itemCount: snapshot.data!.docs.length,
                                          itemBuilder: (context, index){
                                            //print(snapshot.data!.docs.length);
                                            var data = snapshot.data!.docs[index].data() as Map<String , dynamic>;
                                            if(data['Date'] == DateFormat.yMd().format(_selectedDate).toString()   && data['Type'] == 'normi'
                                            && TutorAccount.isEmpty){
                                              //money = int.parse(data['Price'])+ 1;
                                              //print(snapshot.data!.docs.length);
                                              //print(index);
                                              counter ++;
                                              print("counter:");print(counter);
                                              money += int.parse(data['Price']);
                                              print("money:"); print(money);
                                              return Center(
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(horizontal:7,vertical: 20),
                                                  margin: EdgeInsets.all(10),
                                                  width: MediaQuery.of(context).size.width*0.65,
                                                  height: MediaQuery.of(context).size.height*0.15,
                                                  decoration: BoxDecoration(
                                                    color: Color.fromARGB(255, 202, 192, 207),
                                                    borderRadius: BorderRadius.all(Radius.circular(15),),
                                                    border: Border.all(width:1,color: Color.fromARGB(255, 14, 1, 36),//Color.fromARGB(255, 233, 174, 221),
                                                      ),
                                                    // ignore: prefer_const_literals_to_create_immutables
                                                    boxShadow: [BoxShadow(
                                                      color: Color.fromARGB(255, 215, 215, 215),
                                                    spreadRadius: 1, blurRadius: 1,
                                                    ),],
                                                  ),
                                                  child: ListTile(
                                                    leading:Text(data['StartTime']+" - "+data['EndTime'],
                                                            style:TextStyle(
                                                              fontWeight: FontWeight.w400, fontSize:16,
                                                              color: Color.fromARGB(255, 11, 1, 59),
                                                            ),),

                                                    title: Row(mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        SizedBox(width: 150,),
                                                        Text(data['StuAccount'],
                                                        style:TextStyle(
                                                          fontWeight: FontWeight.w600, fontSize:20,
                                                          color: Color.fromARGB(255, 11, 1, 59),
                                                        ),),
                                                        SizedBox(width: 10,),
                                                        Text(":الطالب",
                                                        style:TextStyle(
                                                          fontWeight: FontWeight.w400, fontSize:16,
                                                          color: Color.fromARGB(255, 120, 120, 136),
                                                        ),),
                                                        SizedBox(width: 150,),
                                                      ],
                                                    ),

                                                    subtitle: Row( mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                      Row(
                                                        children: [
                                                          SizedBox(width: 150,),
                                                          Text("ساعة/₪",
                                                          style:TextStyle(
                                                            fontWeight: FontWeight.w600, fontSize:20,
                                                            color: Color.fromARGB(255, 11, 1, 59),
                                                          ),),
                                                          SizedBox(width: 5,),
                                                          Text(data['Price'],
                                                            style:TextStyle(
                                                              fontWeight: FontWeight.w600, fontSize:20,
                                                              color: Color.fromARGB(255, 11, 1, 59),
                                                          ),),
                                                        ],
                                                      ),  
                                                      SizedBox(width: 40,),
                                                      Text(data['Tutor'],
                                                      style:TextStyle(
                                                      fontWeight: FontWeight.w600, fontSize:20,
                                                      color: Color.fromARGB(255, 11, 1, 59),
                                                      ),),
                                                      SizedBox(width: 10,),
                                                      Text(":الأستاذ",
                                                      style:TextStyle(
                                                      fontWeight: FontWeight.w400, fontSize:16,
                                                      color: Color.fromARGB(255, 120, 120, 136),
                                                      ),),
                                                      SizedBox(width: 150,),
                                                      ],
                                                    ),

                                                    trailing:Text(data['Field'],
                                                            style:TextStyle(
                                                              fontWeight: FontWeight.bold, fontSize:25,
                                                              color: Color.fromARGB(255, 11, 1, 59),
                                                            ),),
                                                  ),
                                                ),
                                              );
                                            }
                                            if(data['Date'] == DateFormat.yMd().format(_selectedDate).toString()  && data['Type'] == 'normi'
                                            && 
                                            data['Tutor'].toString().toLowerCase().startsWith(TutorAccount.toLowerCase())){
                                              counter ++;
                                              print("counter:");print(counter);
                                              money += int.parse(data['Price']);
                                              print("money:"); print(money);
                                              return Center(
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(horizontal:7,vertical: 20),
                                                  margin: EdgeInsets.all(10),
                                                  width: MediaQuery.of(context).size.width*0.65,
                                                  height: MediaQuery.of(context).size.height*0.15,
                                                  decoration: BoxDecoration(
                                                    color: Color.fromARGB(255, 202, 192, 207),
                                                    borderRadius: BorderRadius.all(Radius.circular(15),),
                                                    border: Border.all(width:1,color: Color.fromARGB(255, 14, 1, 36),//Color.fromARGB(255, 233, 174, 221),
                                                      ),
                                                    // ignore: prefer_const_literals_to_create_immutables
                                                    boxShadow: [BoxShadow(
                                                      color: Color.fromARGB(255, 215, 215, 215),
                                                    spreadRadius: 1, blurRadius: 1,
                                                    ),],
                                                  ),
                                                  child: ListTile(
                                                    leading:Text(data['StartTime']+" - "+data['EndTime'],
                                                            style:TextStyle(
                                                              fontWeight: FontWeight.w400, fontSize:16,
                                                              color: Color.fromARGB(255, 11, 1, 59),
                                                            ),),

                                                    title: Row(mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        SizedBox(width: 150,),
                                                        Text(data['StuAccount'],
                                                        style:TextStyle(
                                                          fontWeight: FontWeight.w600, fontSize:20,
                                                          color: Color.fromARGB(255, 11, 1, 59),
                                                        ),),
                                                        SizedBox(width: 10,),
                                                        Text(":الطالب",
                                                        style:TextStyle(
                                                          fontWeight: FontWeight.w400, fontSize:16,
                                                          color: Color.fromARGB(255, 120, 120, 136),
                                                        ),),
                                                        SizedBox(width: 150,),
                                                      ],
                                                    ),

                                                    subtitle: Row( mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                      Row(
                                                        children: [
                                                          SizedBox(width: 150,),
                                                          Text("ساعة/₪",
                                                          style:TextStyle(
                                                            fontWeight: FontWeight.w600, fontSize:20,
                                                            color: Color.fromARGB(255, 11, 1, 59),
                                                          ),),
                                                          SizedBox(width: 5,),
                                                          Text(data['Price'],
                                                            style:TextStyle(
                                                              fontWeight: FontWeight.w600, fontSize:20,
                                                              color: Color.fromARGB(255, 11, 1, 59),
                                                          ),),
                                                        ],
                                                      ),  
                                                      SizedBox(width: 40,),
                                                      Text(data['Tutor'],
                                                      style:TextStyle(
                                                      fontWeight: FontWeight.w600, fontSize:20,
                                                      color: Color.fromARGB(255, 11, 1, 59),
                                                      ),),
                                                      SizedBox(width: 10,),
                                                      Text(":الأستاذ",
                                                      style:TextStyle(
                                                      fontWeight: FontWeight.w400, fontSize:16,
                                                      color: Color.fromARGB(255, 120, 120, 136),
                                                      ),),
                                                      SizedBox(width: 150,),
                                                      ],
                                                    ),

                                                    trailing:Text(data['Field'],
                                                            style:TextStyle(
                                                              fontWeight: FontWeight.bold, fontSize:25,
                                                              color: Color.fromARGB(255, 11, 1, 59),
                                                            ),),
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

                                  /*Expanded(//flex: 3,
                                    child:ListView.builder( //crossAxisCount: 3,
                                      shrinkWrap: true,
                                      padding: EdgeInsets.all(7),
                                      itemCount:bookings.length, 
                                      //gridDelegate: SliverGridDelegateWithFixedCrossAxisCount
                                      //(crossAxisCount: 3, mainAxisSpacing:5, crossAxisSpacing:3),
                                       itemBuilder:(context, index){
                                        if((bookings[index].dates == DateFormat.yMd().format(_selectedDate)&&bookings[index].Account == _selected)
                                        ||(bookings[index].dates == DateFormat.yMd().format(_selectedDate)&&bookings[index].major == _selected2)){
                                          print(_selected);
                                          return AnimationConfiguration.staggeredList(position:index, //columnCount: 3,
                                            child: SlideAnimation(
                                              child: FadeInAnimation(
                                                child: Row( mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Padding(padding:EdgeInsets.all(8.0),
                                                    child: Container(
                                                      width: MediaQuery.of(context).size.width*0.5,
                                                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                                      decoration:BoxDecoration(
                                                      borderRadius: BorderRadius.circular(20),
                                                        border: Border.all(width: 1, color:Color.fromARGB(255, 219, 218, 218)),
                                                        color:Color.fromARGB(255, 215, 232, 251),
                                                      ),
                                                    child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        //SizedBox(width:50,),
                                                        Row(mainAxisAlignment: MainAxisAlignment.end,
                                                          children: [
                                                            Text(bookings[index].StartTime!,
                                                            style:TextStyle(
                                                              fontWeight: FontWeight.w400, fontSize:16,
                                                              color: Color.fromARGB(255, 11, 1, 59),
                                                            ),),
                                                            SizedBox(width: 3,),
                                                            Text("-",
                                                            style:TextStyle(
                                                              fontWeight: FontWeight.bold, fontSize:16,
                                                              color: Color.fromARGB(255, 11, 1, 59),
                                                            ),),
                                                            Text(bookings[index].EndTime!,
                                                            style:TextStyle(
                                                              fontWeight: FontWeight.w400, fontSize:16,
                                                              color: Color.fromARGB(255, 11, 1, 59),
                                                            ),),
                                                          ],
                                                        ),
                                                        //SizedBox(width:50,),
                                                        Column( crossAxisAlignment: CrossAxisAlignment.end,
                                                          children: [
                                                            SizedBox(height: 20,),
                                                            Row(mainAxisAlignment: MainAxisAlignment.end,
                                                              children: [
                                                                Text(bookings[index].StudentLN!,
                                                                style:TextStyle(
                                                                  fontWeight: FontWeight.w600, fontSize:20,
                                                                  color: Color.fromARGB(255, 11, 1, 59),
                                                                ),),
                                                                SizedBox(width: 3,),
                                                                Text(bookings[index].StudentFN!,
                                                                style:TextStyle(
                                                                  fontWeight: FontWeight.w600, fontSize:20,
                                                                  color: Color.fromARGB(255, 11, 1, 59),
                                                                ),),
                                                                SizedBox(width: 4,),
                                                                Text(":الطالب",
                                                                style:TextStyle(
                                                                  fontWeight: FontWeight.w400, fontSize:16,
                                                                  color: Color.fromARGB(255, 169, 169, 170),
                                                                ),),
                                                              ],
                                                            ),
                                                            SizedBox(height: 20,),
                                                            Row(
                                                              children: [
                                                                Text("ساعة/₪",
                                                                style:TextStyle(
                                                                  fontWeight: FontWeight.w600, fontSize:20,
                                                                  color: Color.fromARGB(255, 11, 1, 59),
                                                                ),),
                                                                SizedBox(width: 5,),
                                                                Text("${bookings[index].price}",
                                                                  style:TextStyle(
                                                                    fontWeight: FontWeight.w600, fontSize:20,
                                                                    color: Color.fromARGB(255, 11, 1, 59),
                                                                ),),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        //SizedBox(width: 30,),
                                                        Column(crossAxisAlignment: CrossAxisAlignment.end,
                                                          children: [
                                                            Text(bookings[index].major!,
                                                            style:TextStyle(
                                                              fontWeight: FontWeight.bold, fontSize:25,
                                                              color: Color.fromARGB(255, 11, 1, 59),
                                                            ),),
                                                            SizedBox(height:20,),
                                                            Row( mainAxisAlignment: MainAxisAlignment.end,
                                                              children: [
                                                              Text(bookings[index].TeacherLN!,
                                                              style:TextStyle(
                                                              fontWeight: FontWeight.w600, fontSize:20,
                                                              color: Color.fromARGB(255, 11, 1, 59),
                                                              ),),
                                                              SizedBox(width: 3,),
                                                              Text(bookings[index].TeacherFN!,
                                                              style:TextStyle(
                                                              fontWeight: FontWeight.w600, fontSize:20,
                                                              color: Color.fromARGB(255, 11, 1, 59),
                                                              ),),
                                                              SizedBox(width: 4,),
                                                              Text(":الأستاذ",
                                                              style:TextStyle(
                                                              fontWeight: FontWeight.w400, fontSize:16,
                                                              color: Color.fromARGB(255, 169, 169, 170),
                                                              ),),
                                                             ],
                                                            ),
                                                          ],
                                                        ),
                                                        //SizedBox(height:20,),
                                                      ],
                                                    ),
                                                  ),
                                                  ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        }else if((bookings[index].dates == DateFormat.yMd().format(_selectedDate)&& _selected == _all)
                                        ||(bookings[index].dates == DateFormat.yMd().format(_selectedDate)&&_selected2 == _all)){
                                          return AnimationConfiguration.staggeredList(position:index, //columnCount: 3,
                                            child: SlideAnimation(
                                              child: FadeInAnimation(
                                                child: Row( mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Padding(padding:EdgeInsets.all(8.0),
                                                    child: Container(
                                                      width: MediaQuery.of(context).size.width*0.5,
                                                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                                      decoration:BoxDecoration(
                                                      borderRadius: BorderRadius.circular(20),
                                                        border: Border.all(width: 1, color:Color.fromARGB(255, 219, 218, 218)),
                                                        color:Color.fromARGB(255, 215, 232, 251),
                                                      ),
                                                    child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        //SizedBox(width:50,),
                                                        Row(mainAxisAlignment: MainAxisAlignment.end,
                                                          children: [
                                                            Text(bookings[index].StartTime!,
                                                            style:TextStyle(
                                                              fontWeight: FontWeight.w400, fontSize:16,
                                                              color: Color.fromARGB(255, 11, 1, 59),
                                                            ),),
                                                            SizedBox(width: 3,),
                                                            Text("-",
                                                            style:TextStyle(
                                                              fontWeight: FontWeight.bold, fontSize:16,
                                                              color: Color.fromARGB(255, 11, 1, 59),
                                                            ),),
                                                            Text(bookings[index].EndTime!,
                                                            style:TextStyle(
                                                              fontWeight: FontWeight.w400, fontSize:16,
                                                              color: Color.fromARGB(255, 11, 1, 59),
                                                            ),),
                                                          ],
                                                        ),
                                                        //SizedBox(width:50,),
                                                        Column( crossAxisAlignment: CrossAxisAlignment.end,
                                                          children: [
                                                            SizedBox(height: 20,),
                                                            Row(mainAxisAlignment: MainAxisAlignment.end,
                                                              children: [
                                                                Text(bookings[index].StudentLN!,
                                                                style:TextStyle(
                                                                  fontWeight: FontWeight.w600, fontSize:20,
                                                                  color: Color.fromARGB(255, 11, 1, 59),
                                                                ),),
                                                                SizedBox(width: 3,),
                                                                Text(bookings[index].StudentFN!,
                                                                style:TextStyle(
                                                                  fontWeight: FontWeight.w600, fontSize:20,
                                                                  color: Color.fromARGB(255, 11, 1, 59),
                                                                ),),
                                                                SizedBox(width: 4,),
                                                                Text(":الطالب",
                                                                style:TextStyle(
                                                                  fontWeight: FontWeight.w400, fontSize:16,
                                                                  color: Color.fromARGB(255, 169, 169, 170),
                                                                ),),
                                                              ],
                                                            ),
                                                            SizedBox(height: 20,),
                                                            Row(
                                                              children: [
                                                                Text("ساعة/₪",
                                                                style:TextStyle(
                                                                  fontWeight: FontWeight.w600, fontSize:20,
                                                                  color: Color.fromARGB(255, 11, 1, 59),
                                                                ),),
                                                                SizedBox(width: 5,),
                                                                Text("${bookings[index].price}",
                                                                  style:TextStyle(
                                                                    fontWeight: FontWeight.w600, fontSize:20,
                                                                    color: Color.fromARGB(255, 11, 1, 59),
                                                                ),),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        //SizedBox(width: 30,),
                                                        Column(crossAxisAlignment: CrossAxisAlignment.end,
                                                          children: [
                                                            Text(bookings[index].major!,
                                                            style:TextStyle(
                                                              fontWeight: FontWeight.bold, fontSize:25,
                                                              color: Color.fromARGB(255, 11, 1, 59),
                                                            ),),
                                                            SizedBox(height:20,),
                                                            Row( mainAxisAlignment: MainAxisAlignment.end,
                                                              children: [
                                                              Text(bookings[index].TeacherLN!,
                                                              style:TextStyle(
                                                              fontWeight: FontWeight.w600, fontSize:20,
                                                              color: Color.fromARGB(255, 11, 1, 59),
                                                              ),),
                                                              SizedBox(width: 3,),
                                                              Text(bookings[index].TeacherFN!,
                                                              style:TextStyle(
                                                              fontWeight: FontWeight.w600, fontSize:20,
                                                              color: Color.fromARGB(255, 11, 1, 59),
                                                              ),),
                                                              SizedBox(width: 4,),
                                                              Text(":الأستاذ",
                                                              style:TextStyle(
                                                              fontWeight: FontWeight.w400, fontSize:16,
                                                              color: Color.fromARGB(255, 169, 169, 170),
                                                              ),),
                                                             ],
                                                            ),
                                                          ],
                                                        ),
                                                        //SizedBox(height:20,),
                                                      ],
                                                    ),
                                                  ),
                                                  ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                        else{return Container();} 
                                      }
                                    ),
                                  ),*/
                                ],
                              ),
                            ),
                          ),

                          /*Expanded(
                          child: Container(
                            child: Column( mainAxisAlignment: MainAxisAlignment.center,
                              children: [  
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color:Color.fromARGB(255,230, 230, 230),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: CalendarDatePicker(
                                    initialDate: _focusDate, 
                                    firstDate: DateTime(2000), 
                                    lastDate: DateTime(2111), 
                                    onDateChanged: (date){
                                      setState(() {
                                       _selectedDate=date;
                                       _selected =""; _selected2="";
                                       counter=0;
                                      print(DateFormat.yMd().format(_selectedDate));
                                      });
                                    }            
                                  ),
                                ),
                                SizedBox(height: 30,),
                                Container(
                                  padding: EdgeInsets.all(8),
                                  margin: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color:Color.fromARGB(255, 196, 214, 218),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    children: [
                                      Text(" :عدد المسجلين لدى",
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 6, 1, 46),
                                          fontWeight: FontWeight.w600, fontSize: 18
                                      ),),
                                      SizedBox(height: 10,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Text("${counter}",
                                          style: TextStyle(
                                            color: Color.fromARGB(255, 6, 1, 46),
                                            fontWeight: FontWeight.w600, fontSize: 18
                                          ),),
                                          SizedBox(width: 8,),
                                          Text(":",
                                          style: TextStyle(
                                            color: Color.fromARGB(255, 6, 1, 46),
                                            fontWeight: FontWeight.w600, fontSize: 18
                                          ),),
                                          SizedBox(width: 3,),
                                          Text(_selected,
                                          style: TextStyle(
                                            color: Color.fromARGB(255, 6, 1, 46),
                                            fontWeight: FontWeight.w600, fontSize: 18
                                          ),),
                                        ],
                                      ),
                                      SizedBox(height: 10,),
                                      Row(mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Text("₪",
                                          style:TextStyle(
                                            color: Color.fromARGB(255, 6, 1, 46),
                                            fontWeight: FontWeight.w600, fontSize: 18
                                          ),),
                                          SizedBox(width:1,),
                                          Text("${money}",
                                            style: TextStyle(
                                              color: Color.fromARGB(255, 6, 1, 46),
                                              fontWeight: FontWeight.w600, fontSize: 18
                                          ),),
                                          SizedBox(width: 3,),
                                          Text(" :المبلغ المالي",
                                            style: TextStyle(
                                              color: Color.fromARGB(255, 6, 1, 46),
                                              fontWeight: FontWeight.w600, fontSize: 18
                                          ),),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ),*/
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
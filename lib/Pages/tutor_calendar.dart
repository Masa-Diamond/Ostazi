// ignore_for_file: prefer_const_constructors, unused_field, prefer_final_fields, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:math';
import 'TutorNavBar.dart';
import 'events_class.dart';

class TutorCalendar extends StatefulWidget {
  const TutorCalendar({super.key});

  @override
  State<TutorCalendar> createState() => _TutorCalendarState();
}

class _TutorCalendarState extends State<TutorCalendar> {
  var colors = [
    // ignore: empty_constructor_bodies
    Color.fromARGB(255, 222, 186, 129),
    Color.fromARGB(255, 218, 165, 172),
    Color.fromARGB(255, 231, 195, 168),
    Color.fromARGB(255, 204, 214, 157),
    Color.fromARGB(255, 203, 225, 236), 
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

  var currentColor; 
  setRandomColor(){
    var rnd = Random().nextInt(colors.length);
   // setState(() {
      currentColor=colors[rnd];
   // });
  }

  List <Events> Eventss=[
  Events('حجز دائم','احمد','محمد','10/25/2022','1:00 PM','2:00 PM',0),
  Events('حجز مؤقت','زهير','حلمي','10/25/2022','2:00 PM','3:00 PM',1),
  Events('حجز دائم','ميس','القاضي','10/27/2022','3:00 PM','4:00 PM',2),
  Events('حجز مؤقت','نايا','رمضان','10/28/2022','5:00 PM','6:00 PM',3),
  Events('حجز دائم','لبنى','صايمه','10/25/2022','1:00 PM','2:00 PM',0),
  Events('حجز مؤقت','ترتيل','الناي','10/28/2022','3:00 PM','4:00 PM',1),
  Events('حجز دائم','جاد','قناديلو','10/30/2022','2:00 PM','3:00 PM',2),
  Events('حجز مؤقت','فادي','ساري','10/31/2022','2:00 PM','3:00 PM',3),
 ];
 

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusDate = DateTime.now();
  DateTime _selectedDate =DateTime.now();
  
  
  //Map <String,List> mySelectedEvents={};
  @override
  void initState(){
    super.initState();
    _selectedDate = _focusDate;
    var rnd = Random().nextInt(colors.length);
      currentColor=colors[rnd];
  }
  int ind =0;
  String eventDate="";
  List _listOfDayEvents(DateTime dateTime){
    eventDate=DateFormat.yMd().format(dateTime);
    print("event "+eventDate);
    if(Eventss[3] == eventDate){
      ind =3;
      return Eventss;
    }else {return [];}
  }
   _check(){
   if(DateFormat.yMd().format(_selectedDate) == Eventss[4]){
    print("here");
   }
  }
  int x=0;
  generateColors(){
    x=0;
    //colors[x];
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
    
      body: /*Column(
        children: [
          TableCalendar(
            focusedDay: _focusDate, 
            firstDay: DateTime(2015), 
            lastDay: DateTime(2111),
            calendarFormat: _calendarFormat,
            onDaySelected: (selectedDate,focusDate){
              if(!isSameDay(_selectedDate, selectedDate)){
                setState(() {
                  _selectedDate= selectedDate;
                  _focusDate = focusDate;
                  String Date= DateFormat.yMd().format(_selectedDate);
                  print(Date);
                });
              }
            }, 
            selectedDayPredicate: (day){
              return isSameDay(_selectedDate, day);
            },
            onFormatChanged:(format){
              if(_calendarFormat != format){
                setState(() {
                  _calendarFormat=format;
                });
              }
            },
            onPageChanged: (focusedDay){
              _focusDate = focusedDay;
            },
           // eventLoader: _listOfDayEvents,
           
          ),
        ],
      ),*/
        Column(
          children: [
            CalendarDatePicker(
              initialDate: _focusDate, 
              firstDate: DateTime(2000), 
              lastDate: DateTime(2111), 
              onDateChanged: (date){
                setState(() {
                   _selectedDate=date;
                   print(DateFormat.yMd().format(_selectedDate));
                });
              }
            
            ),
            Divider(),
            Expanded(
              flex: 1,
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.all(7),
                itemCount: Eventss.length,
                itemBuilder: (context, index){
                  if(Eventss[index].date == DateFormat.yMd().format(_selectedDate)){
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      child: SlideAnimation(
                        child: FadeInAnimation(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal:2,vertical: 20),
                                margin: const EdgeInsets.only(bottom: 8),
                                width: MediaQuery.of(context).size.width*0.95,
                                height: MediaQuery.of(context).size.height*0.15,
                                decoration: BoxDecoration(
                                  color:colors[index],//index<colors.length?colors[index]://x<colors.length?colors[x++]:colors[0],//currentColor,
                                  borderRadius: BorderRadius.all(Radius.circular(10),),
                                  border: Border.all(width:1,color:Color.fromARGB(255, 14, 1, 36),),
                                  boxShadow: [BoxShadow(
                                    spreadRadius: 1, blurRadius: 1,
                                  ),],
                                ),
                                child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.access_time_rounded,
                                        color:Color.fromARGB(255, 11, 0, 49),size:27,),
                                        SizedBox(width:7),
                                         Text(Eventss[index].StartTime!,
                                         // textAlign: TextAlign.right,
                                          style:TextStyle(
                                          color:Color.fromARGB(255, 11, 0, 49),
                                          fontWeight: FontWeight.w700, fontSize:16,
                                          ) ,),
                                         SizedBox(width:2),
                                         Text('-',
                                         // textAlign: TextAlign.right,
                                          style:TextStyle(
                                          color:Color.fromARGB(255, 11, 0, 49),
                                          fontWeight: FontWeight.w700, fontSize:17,
                                          ) ,),
                                          SizedBox(width:2),
                                          Text(Eventss[index].EndTime!,
                                         // textAlign: TextAlign.right,
                                          style:TextStyle(
                                          color:Color.fromARGB(255, 11, 0, 49),
                                          fontWeight: FontWeight.w700, fontSize:16,
                                          ) ,),
                                      ],
                                    ),
                                    SizedBox(width:7,),
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(Eventss[index].LastName!,// textAlign: TextAlign.right,
                                             style:TextStyle(
                                             color:Color.fromARGB(255, 11, 0, 49),
                                            fontWeight: FontWeight.w700, fontSize:20,
                                            ) ,),
                                            SizedBox(width: 3,),
                                            Text(Eventss[index].FirstName!,// textAlign: TextAlign.right,
                                             style:TextStyle(
                                             color:Color.fromARGB(255, 11, 0, 49),
                                            fontWeight: FontWeight.w700, fontSize:20,
                                            ) ,),
                                          ],
                                        ),
                                        SizedBox(height:2,),
                                        Text(Eventss[index].Type!,// textAlign: TextAlign.right,
                                            style:TextStyle(
                                            color:Color.fromARGB(255, 11, 0, 49),
                                            fontWeight: FontWeight.w700, fontSize:16,
                                          ) ,),
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
                  }else{return Container();}
                }
              ),
            ),
          ],
        ),
    );
  }
}
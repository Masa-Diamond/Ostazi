// ignore_for_file: unused_import, prefer_const_constructors

import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:grad_project/Pages/bookings_admin_class.dart';
import 'package:grad_project/Pages/side_bar_admin.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class BookingsTablet extends StatefulWidget {
  const BookingsTablet({super.key});

  @override
  State<BookingsTablet> createState() => _BookingsTabletState();
}

class _BookingsTabletState extends State<BookingsTablet> {
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
  String _selected = "";
  List <String> dropDown =["أيمن صبوح","غسان الساحلي","حمدي وهبة","ماسة السيد"];
  String _selected2 = "";
  List <String> dropDown2 =["فيزياء","كيمياء","رياضيات","الانجليزية"];
  int money=0;
  int ClassPrice =0;
  String _all ="جميع الحجوزات";
  int counter=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 244, 244, 248),
      drawer: SideBar(),
      appBar: AppBar(
        iconTheme: IconThemeData(size:30,color:Color.fromARGB(255, 213, 213, 215),
        ),
        backgroundColor: Color.fromARGB(255, 4, 4, 71),
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
          ],),
      ),
      
      body: Column(
        children: [
          /////////// CALANDER
          Container(
            margin:const EdgeInsets.only(top:20, left: 20) ,
            child: DatePicker(
              DateTime.now(),
              height: 100, width: 80,
              initialSelectedDate:DateTime.now(),
              selectionColor:Color.fromARGB(255, 182, 188, 187),
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
                  _selected =""; _selected2="";
                  counter=0;
                  print(DateFormat.yMd().format(_selectedDate));
                }); 
              },
            ),
          ),
          //////////// INFORMATION
          SizedBox(height: 7,),
          Container(
            width: MediaQuery.of(context).size.width*0.9,
            height: MediaQuery.of(context).size.height*0.13,
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color:Color.fromARGB(255, 196, 214, 218),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                SizedBox(width: 15,),
                Column(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                SizedBox(width:170,),
                Column(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                  ],
                ),
                SizedBox(width:100,),
                Column(
                  // ignore: prefer_const_literals_to_create_immutables
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Text(" :عدد المسجلين لدى",
                    style: TextStyle(
                      color: Color.fromARGB(255, 6, 1, 46),
                      fontWeight: FontWeight.w600, fontSize: 18
                    ),),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20,),
          /////////////////////////////// SELECTING
          Container(
            width: MediaQuery.of(context).size.width,
            height:50,
            //color: Colors.pink[100],
            padding: EdgeInsets.all(8),
            child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
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
                  child:Container(
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
                SizedBox(width: 10,),
                Container(
                  width:250, 
                  height:40,
                  padding: EdgeInsets.only(left:10, right:5),
                  decoration:BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 1, color: Color.fromARGB(255, 219, 217, 217)),
                    boxShadow:[BoxShadow(blurRadius: 3, spreadRadius: 3,color:Color.fromARGB(255, 219, 217, 217) )]
                  ),
                  child: Row(//mainAxisAlignment: MainAxisAlignment.start,
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
                SizedBox(width: 10,),
                Container(
                  width:250, 
                  height:40,
                  padding: EdgeInsets.only(left:10, right: 5),
                  decoration:BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 1, color: Color.fromARGB(255, 219, 217, 217)),
                    boxShadow:[BoxShadow(blurRadius: 3, spreadRadius: 3,color:Color.fromARGB(255, 219, 217, 217) )]
                  ),
                  child: Row(//mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          ),
          ////////////////////////////////////////////////////////
          SizedBox(height: 50,),
          Expanded(flex:1,
          child: ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.all(7),
            itemCount: bookings.length,
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
                            width: MediaQuery.of(context).size.width*0.95,
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
                              width: MediaQuery.of(context).size.width*0.95,
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
                }else{return Container();}
            },
          ),
          ),
        ],
      ),
    );
  }
}
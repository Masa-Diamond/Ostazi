// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:grad_project/Pages/add_appointments.dart';
import 'package:grad_project/model/tutors_courses.dart';
import 'package:intl/intl.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grad_project/Pages/inbox-student.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firestore = FirebaseFirestore.instance;
late User signedInUser;

class AddAppPage extends StatefulWidget {
  const AddAppPage({super.key});

  @override
  State<AddAppPage> createState() => _AddAppPageState();
}
 DateTime _selectedDate = DateTime.now();
 

 String _startTime =DateFormat("hh:mm a").format(DateTime.now()).toString();
 String _endTime ="3:00";
 String _selectedType = "نوع الحجز";
 List <String> TypeList=[
  "حجز مؤقت",
  "حجز دائم"
 ];
 String _selectedRepeat = "لا تكرار";
 List <String> RepeatList=[
  "لا تكرار",
  "يوميا",
  "أسبوعيا"
 ];
 int _selectedColor =0;
 final TextEditingController _typeController =TextEditingController();
class _AddAppPageState extends State<AddAppPage> {
  //EventController _controller = EventController();
  TextEditingController  _eventController = TextEditingController();
  TextEditingController  _dateController = TextEditingController();
  TextEditingController  _starttimeController = TextEditingController();
  TextEditingController  _endtimeController = TextEditingController();
  TextEditingController  _repeatingController = TextEditingController();
  @override
  final _auth = FirebaseAuth.instance;
  final formkey = GlobalKey<FormState>();
  late String Tutor;
  late String Field;
  late String Date;
  late String StartTime;
  late String EndTime;
  late String Type;
  late String Repeat;
  late String Colorr;

  @override
  void initState(){
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async{
    try {
      DateTime begin = new DateTime(2023, 1, 12);
      DateTime endd =new DateTime(2023, 2, 2);
      while(begin != endd){
        begin= begin.add(Duration(days:7));
        print(begin);
      }
      
      final user = _auth.currentUser;
      if (user != null){
      signedInUser = user;
      print(signedInUser.email);
      DocumentSnapshot ds = await FirebaseFirestore.instance.collection('tutors').doc(_auth.currentUser!.uid).get();
      Tutor = ds.get('Account');
      Field = ds.get('Field');
      }
    } catch (e) {
      print(e);
    }
  }
  Widget build(BuildContext context) {
    
    final TextEditingController _noteController =TextEditingController();
    //DateTime _selecedDate = DateTime.now();
    return Scaffold(
      backgroundColor:Color.fromARGB(255, 244, 244, 248),
      //drawer: TutorNavBar(),
      appBar: AppBar(
        elevation: 5,
        iconTheme: IconThemeData(size:30,color: Color.fromARGB(255, 192, 218, 240)),
        backgroundColor: Color.fromARGB(255, 4, 4, 71),
        leading: IconButton(
          onPressed: (){
            Navigator.pushReplacement(
            context, 
            MaterialPageRoute(builder: (context) => AddAppointments())); 
          },
          icon: Icon(Icons.arrow_back_ios_new,size: 15,),
        ),
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
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(left: 20, right: 20,top: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("اضافة وقت حصة",
              textAlign: TextAlign.right,
              style:TextStyle(
                color: Color.fromARGB(255, 4, 4, 71),
                fontSize:30, fontWeight: FontWeight.bold, 
              ) ,),
            
              Container(
                margin: EdgeInsets.only(top:16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('الحجز',
                    //textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Color.fromARGB(255, 4, 4, 71),
                      fontSize:20, fontWeight: FontWeight.w600,  
                    ),),                    
                    Container(                     
                      padding: EdgeInsets.only(right: 14), 
                      height: 52,
                      margin: EdgeInsets.only(top:8),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color.fromARGB(255, 142, 142, 164),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _eventController,
                              readOnly: true,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color:Color.fromARGB(255, 57, 57, 67),
                                fontSize: 20, fontWeight:FontWeight.w500,  
                              ),
                              decoration: InputDecoration(
                                hintText: "$_selectedType",
                                hintStyle: TextStyle(
                                  color:Color.fromARGB(255, 88, 88, 100),
                                  fontSize: 20, fontWeight:FontWeight.w500,
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(width:0,
                                  color:Color.fromARGB(255, 4, 4, 71),),
                                ),
                                enabledBorder:UnderlineInputBorder(
                                  borderSide: BorderSide(width:0,
                                  color:Color.fromARGB(255, 4, 4, 71),),
                                ), 
                              ),
                            ),
                          ),

                          DropdownButton(
                            icon: Icon(Icons.keyboard_arrow_down,
                            color:Color.fromARGB(255, 88, 88, 100),),
                            //iconSize: 32,
                            elevation: 4,
                            underline: Container(height: 0,),
                            style: TextStyle(
                              color:Color.fromARGB(255, 57, 57, 67),
                              fontSize: 20, fontWeight:FontWeight.w500,
                            ),
                            onChanged: (String? newValue){
                              setState(() {
                                _selectedType = newValue!;
                                Type = _selectedType;
                                print("Typee");
                                print(Type);
                              });
                            },
                            items: TypeList.map<DropdownMenuItem<String>>((String? value){
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value!,
                                style:TextStyle(
                                  color:Color.fromARGB(255, 57, 57, 67),
                                  fontSize: 20, fontWeight:FontWeight.w500,
                                ),),
                              );
                            }).toList(),
                           ),
                        ],
                      ),
                    ),                                        
                  ],
                ),
              ),  
 
             
              Container(
                margin: EdgeInsets.only(top:16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('التاريخ',
                    //textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Color.fromARGB(255, 4, 4, 71),
                      fontSize:20, fontWeight: FontWeight.w600,  
                    ),),                    
                    Container(
                      margin: EdgeInsets.only(top:8),
                      padding: EdgeInsets.only(right: 14),
                      height: 52,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color.fromARGB(255, 142, 142, 164),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(12),),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: TextFormField(
                              onChanged: (value){
                                Date = value;
                                print("date");
                                    //print(Date);
                              },
                              controller: _dateController,
                              readOnly: true,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color:Color.fromARGB(255, 57, 57, 67),
                                fontSize: 20, fontWeight:FontWeight.w500,  
                              ),
                              decoration: InputDecoration(
                                hintText: DateFormat.yMd().format(_selectedDate),//DateFormat('yyyy-MM-dd').format(_selectedDate),
                                hintStyle: TextStyle(
                                  color:Color.fromARGB(255, 88, 88, 100),
                                  fontSize: 20, fontWeight:FontWeight.w500,
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(width:0,
                                  color:Color.fromARGB(255, 4, 4, 71),),
                                ),
                                enabledBorder:UnderlineInputBorder(
                                  borderSide: BorderSide(width:0,
                                  color:Color.fromARGB(255, 4, 4, 71),),
                                ), 
                              ),                              
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.calendar_today_outlined,
                            color:Color.fromARGB(255, 88, 88, 100),),
                              onPressed: (){
                                _getDateFromUser();
                              },
                          ),
                        ],
                        ),
                    ),                                       
                  ],
                ),
              ),

              /*Container(
                margin: EdgeInsets.only(top:16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('اليوم',
                    //textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Color.fromARGB(255, 4, 4, 71),
                      fontSize:20, fontWeight: FontWeight.w600,  
                    ),),                    
                    Container(
                      margin: EdgeInsets.only(top:8),
                      padding: EdgeInsets.only(right: 14),
                      height: 52,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color.fromARGB(255, 142, 142, 164),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(12),),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color:Color.fromARGB(255, 57, 57, 67),
                                fontSize: 20, fontWeight:FontWeight.w500,  
                              ),
                              decoration: InputDecoration(
                                hintText: 'يوم الاسبوع',
                                hintStyle: TextStyle(
                                  color:Color.fromARGB(255, 88, 88, 100),
                                  fontSize: 20, fontWeight:FontWeight.w500,
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(width:0,
                                  color:Color.fromARGB(255, 4, 4, 71),),
                                ),
                                enabledBorder:UnderlineInputBorder(
                                  borderSide: BorderSide(width:0,
                                  color:Color.fromARGB(255, 4, 4, 71),),
                                ), 
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    
                  ],
                ),
              ),*/

              Row(
                children: [
                Expanded(child:
                  Container(
                    margin: EdgeInsets.only(top:16),
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                    Text('بداية الحصة',
                    //textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Color.fromARGB(255, 4, 4, 71),
                      fontSize:20, fontWeight: FontWeight.w600,  
                    ),),                    
                    Container(
                      margin: EdgeInsets.only(top:8),
                      padding: EdgeInsets.only(right: 14),
                      height: 52,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color.fromARGB(255, 142, 142, 164),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(12),),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _starttimeController,
                              readOnly: true,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color:Color.fromARGB(255, 57, 57, 67),
                                fontSize: 20, fontWeight:FontWeight.w500,  
                              ),
                              decoration: InputDecoration(
                                hintText: _startTime,
                                hintStyle: TextStyle(
                                  color:Color.fromARGB(255, 88, 88, 100),
                                  fontSize: 20, fontWeight:FontWeight.w500,
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(width:0,
                                  color:Color.fromARGB(255, 4, 4, 71),),
                                ),
                                enabledBorder:UnderlineInputBorder(
                                  borderSide: BorderSide(width:0,
                                  color:Color.fromARGB(255, 4, 4, 71),),
                                ), 
                              ),                              
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.access_time_rounded,
                            color:Color.fromARGB(255, 88, 88, 100),),
                              onPressed: (){
                                _getTimeFromUser(isStartTime: true);
                              },
                          ),
                        ],
                        ),
                      ),                                       
                     ],
                    ),
                  ),
                 ),
                SizedBox(width: 15,),
                Expanded(child:
                  Container(
                    margin: EdgeInsets.only(top:16),
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                    Text('نهاية الحصة',
                    //textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Color.fromARGB(255, 4, 4, 71),
                      fontSize:20, fontWeight: FontWeight.w600,  
                    ),),                    
                    Container(
                      margin: EdgeInsets.only(top:8),
                      padding: EdgeInsets.only(right: 14),
                      height: 52,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color.fromARGB(255, 142, 142, 164),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(12),),
                        child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _endtimeController,
                              readOnly: true,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color:Color.fromARGB(255, 57, 57, 67),
                                fontSize: 20, fontWeight:FontWeight.w500,  
                              ),
                              decoration: InputDecoration(
                                hintText:_endTime,
                                hintStyle: TextStyle(
                                  color:Color.fromARGB(255, 88, 88, 100),
                                  fontSize: 20, fontWeight:FontWeight.w500,
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(width:0,
                                  color:Color.fromARGB(255, 4, 4, 71),),
                                ),
                                enabledBorder:UnderlineInputBorder(
                                  borderSide: BorderSide(width:0,
                                  color:Color.fromARGB(255, 4, 4, 71),),
                                ), 
                              ),                              
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.access_time_rounded,
                            color:Color.fromARGB(255, 88, 88, 100),),
                              onPressed: (){
                                _getTimeFromUser(isStartTime: false);
                              },
                            ),
                        ],
                        ),
                      ),                                       
                     ],
                    ),
                  ),
                 ),
                
                ],
              ), 
             
              Container(
                margin: EdgeInsets.only(top:16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('التكرار',
                    //textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Color.fromARGB(255, 4, 4, 71),
                      fontSize:20, fontWeight: FontWeight.w600,  
                    ),),                    
                    Container(                     
                      padding: EdgeInsets.only(right: 14), 
                      height: 52,
                      margin: EdgeInsets.only(top:8),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color.fromARGB(255, 142, 142, 164),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _repeatingController,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color:Color.fromARGB(255, 57, 57, 67),
                                fontSize: 20, fontWeight:FontWeight.w500,  
                              ),
                              decoration: InputDecoration(
                                hintText: "$_selectedRepeat",
                                hintStyle: TextStyle(
                                  color:Color.fromARGB(255, 88, 88, 100),
                                  fontSize: 20, fontWeight:FontWeight.w500,
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(width:0,
                                  color:Color.fromARGB(255, 4, 4, 71),),
                                ),
                                enabledBorder:UnderlineInputBorder(
                                  borderSide: BorderSide(width:0,
                                  color:Color.fromARGB(255, 4, 4, 71),),
                                ), 
                              ),
                            ),
                          ),

                          DropdownButton(
                            icon: Icon(Icons.keyboard_arrow_down,
                            color:Color.fromARGB(255, 88, 88, 100),),
                            iconSize: 32, 
                            elevation: 4,
                            underline: Container(height: 0,),
                            style: TextStyle(
                              color:Color.fromARGB(255, 57, 57, 67),
                              fontSize: 20, fontWeight:FontWeight.w500,
                            ),
                            onChanged: (String? newValue){
                              setState(() {
                                _selectedRepeat = newValue!;
                                Repeat= _selectedRepeat;
                                print("Repeat"); print(Repeat);
                              });
                            },
                            items: RepeatList.map<DropdownMenuItem<String>>((String? value){
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value!,
                                style:TextStyle(
                                  color:Color.fromARGB(255, 57, 57, 67),
                                  fontSize: 20, fontWeight:FontWeight.w500,
                                ),),
                              );
                            }).toList(),
                           ),
                        ],
                      ),
                    ),                                        
                  ],
                ),
              ),  
              
              SizedBox(height: 20,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //color Pallete
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("اللون",
                      style:TextStyle(
                        color: Color.fromARGB(255, 4, 4, 71),
                        fontSize:20, fontWeight: FontWeight.w600,),),
                      SizedBox(height: 8,),
                      Wrap(
                        children: List<Widget>.generate(
                          3,
                          (int index) {
                            return GestureDetector(
                              onTap: (){
                               setState(() {
                                  _selectedColor=index;
                                  Colorr = _selectedColor.toString();
                                  print("$index");
                                  print('Colorr'); print(Colorr);
                               });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right:8),
                                child: CircleAvatar(
                                  radius: 14,
                                  backgroundColor:index==0? Color.fromARGB(255,140,14,15)
                                  :index==1?Color.fromARGB(255,219,168,88)
                                  :Color.fromARGB(255,71,73,115),
                                  child:_selectedColor==index? Icon(Icons.done,size: 16,
                                  color:Color.fromARGB(255, 244, 244, 248),):Container(),
                                ),
                                
                              ),
                            );
                          }
                        ),
                      ),  
                    ],
                  ),

                  GestureDetector(
                    onTap: () async{
                     /*var acc = FirebaseFirestore.instance.collection('tutors')
                      .doc(FirebaseAuth.instance.currentUser!.uid).get()
                      .then((value) => {
                        Tutor = value.get('Account'),  
                        Field = value.get('Field'),                                  
                      });*/
                      print(Tutor); print(Field);
                      insertData(Tutor,Field,Date,StartTime,EndTime,Type,Repeat,Colorr);
                    },
                    child: Container(
                      padding: EdgeInsets.only(top:15),
                      width: 80, height:60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color:Color.fromARGB(255, 140, 14, 15),
                      ),
                      child: Text("انشاء",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color:Color.fromARGB(255, 244, 244, 248),
                        fontSize: 18, fontWeight: FontWeight.w600,
                      ),),
                    ),
                  ),               
                ],
              ),
              SizedBox(height: 50,),
            ],
          ),
        ),
        ),

      );
    
  }

  /*_validateDate(){
    if(_eventController.text.isNotEmpty && _dateController.text.isNotEmpty 
    && _starttimeController.text.isNotEmpty && _endtimeController.text.isNotEmpty){
      //Get.back();
    }else if(_eventController.text.isEmpty || _dateController.text.isEmpty 
    || _starttimeController.text.isEmpty || _endtimeController.text.isEmpty){
      snackBar("مطلوب","يجب تعبئة ",
      snackPosition: snackPosition.bottom,
      backgroundColor : Colors.black,
      );
    }
  }*/

_getDateFromUser() async{
    DateTime?  _pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate:DateTime(2023 , 1 , 1), lastDate:DateTime(2023 , 6, 3),);
      if(_pickerDate != null){
       setState(() {
          _selectedDate = _pickerDate;
          _dateController.text=DateFormat.yMd().format(_selectedDate);
          print(_selectedDate);
          print(_dateController.text);
          print("Date");
          Date = DateFormat.yMd().format(_selectedDate).toString();
          print(Date);
       });
      }else{print("It's null or somrthing went wrong!");}
  }

  _getTimeFromUser({required bool isStartTime}) async{
    var pickedTime = await _showTimePicker();
    String _formatedTime = pickedTime.format(context);
    if(pickedTime == null){print("Time Cancled");}
    else if(isStartTime == true){
      setState(() {
        _startTime=_formatedTime;
        StartTime = _startTime.toString();
        print(_startTime);
        print("Start Time");
        print(StartTime);
      }); 
    }
    else if(isStartTime == false){
      setState((){
        _endTime=_formatedTime;
       EndTime = _endTime.toString();
        print(_endTime);
        print("End Time");
        print(EndTime);
      });
    }
  }
  _showTimePicker(){
    return showTimePicker(
      initialEntryMode:TimePickerEntryMode.input,
      context: context,
     initialTime: TimeOfDay
     (
      hour: int.parse(_startTime.split(":")[0]), 
      minute: int.parse(_startTime.split(":")[1].split(" ")[0])
      ));
  }
  /*_showDatePicker(){
    return showDatePicker(
      initialEntryMode:DatePickerEntryMode.input,
      context: context,
     initialDate: DateFormat.yMd
     (
      hour: int.parse(_startTime.split(":")[0]), 
      minute: int.parse(_startTime.split(":")[1].split(" ")[0])
      ));
  }*/
  void insertData(String Tutor, String Field, String Date,
   String StartTime, String EndTime, String Type, String Repeat, String Colorr){
    
    print(Tutor); print(Field); print(Date); 
    print(StartTime); print(EndTime); 
    print(Type); print(Repeat); print(Colorr);

    try {
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      User? user = _auth.currentUser;
      TutorCoursesModel tutorCourse = TutorCoursesModel();
      tutorCourse.uid = user!.uid;
      tutorCourse.Tutor = Tutor;
      tutorCourse.Field = Field;
      tutorCourse.Date = Date;
      tutorCourse.StartTime = StartTime;
      tutorCourse.EndTime = EndTime;
      tutorCourse.Type = Type;
      tutorCourse.Color = Colorr;
      tutorCourse.Repeat = Repeat;
      print(tutorCourse.Repeat);
      firebaseFirestore.collection("TutorsCourses")
      .add(tutorCourse.toMap());
      final snackBar = SnackBar( 
        content: Text("لقد تمت اضافة الحصة  ",
        style: const TextStyle(
          fontSize: 28, color: Color.fromARGB(255, 247, 240, 204)
        ),),
        backgroundColor: Color.fromARGB(255, 8, 1, 48),
        duration: const Duration(seconds: 5)
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.pushReplacement
        (context, MaterialPageRoute(
        builder: (context) => AddAppPage() ));
    } catch (e) {
      print(e);
      final snackBar = SnackBar( 
        content: Text("لقد حصل خلل ما "+ e.toString(),
        style: const TextStyle(
          fontSize: 28, color: Color.fromARGB(255, 247, 204, 204)
        ),),
        backgroundColor: Color.fromARGB(255, 8, 1, 48),
        duration: const Duration(seconds: 5)
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
   }
}
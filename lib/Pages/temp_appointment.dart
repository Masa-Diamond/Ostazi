// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:grad_project/Pages/NavBar.dart';
import 'package:grad_project/Pages/student_reg_atutor.dart';
import 'package:grad_project/Pages/time_slots.dart';

class TempAppoint extends StatefulWidget {
  const TempAppoint({super.key});

  @override
  State<TempAppoint> createState() => _TempAppointState();
}

class _TempAppointState extends State<TempAppoint> {
  List selectedIndex = [];
  static List<TimeSlots> times = [
    TimeSlots( '7:00 PM','8:00 PM', true),
    TimeSlots( '8:00 PM','9:00 PM', false),
    TimeSlots( '9:00 PM','10:00 PM', true), 
    TimeSlots( '10:00 PM','11:00 PM', true),
    TimeSlots( '12:00 PM','1:00 PM', false),
    
  ];
  //List<TimeSlots> times_list = List.from(times);
  List<TimeSlots> timess_list =[];
  void initState(){
    super.initState();
    setState(() {
      timess_list = times;
    });
  }
  DateTime date = DateTime.now();
  bool flag = true;
  int tapped_index = -1;
  bool tapped = true;
  void clickCard(){
    setState(() {
      if(flag){flag=false;}
    else flag=true;
    
    });
    
    print(flag);
  }
  void checkSelectedCard(int index){
    print("Tapped index: ${index}");
    tapped_index =index;
  }
  @override
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
          actions: [
              IconButton(icon:Icon(Icons.arrow_forward),
              onPressed: (){
               Navigator.pushReplacement(
                context, 
                MaterialPageRoute(builder: (context) 
                => tutorPageforStudent()));
              },),
            ],
      ),
      body: //SingleChildScrollView(
        //child:
         Column(
          children: <Widget>[
            SizedBox(height: 15,),
                Text(':الحجوزات المؤقتة ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 4, 4, 71),
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),),
                SizedBox(height: 15,),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.09,
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.only(top:10),
              color: Color.fromARGB(255, 4, 4, 71),
              child: Row(
                children: <Widget>[
                  Icon(Icons.calendar_today, size:30,color:Color.fromARGB(255, 241, 224, 77),),
                  SizedBox(width: 40,),
                  Text(
                   '${date.month}/${date.day}/${date.year}',
                    style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold,
                      color:Color.fromARGB(255, 244, 244, 248),
                    ),
                  ),
                  const SizedBox(width: 100,),
                  ElevatedButton(
                    child: Text('اختر تاريخ',
                    style: TextStyle(
                      color:Color.fromARGB(255, 241, 224, 77),
                      fontSize: 22,
                    ),),
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 4, 4, 71),
                    ),
                    onPressed: () async{
                      DateTime? newDate =await showDatePicker(
                        context: context,
                        initialDate: date,
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                      );
                      //if cancle
                      if(newDate == null) return;
                      //if OK
                      setState(() {
                        date = newDate;
                      });
                    },),
                ],
              ),
            ),
            SizedBox(height: 30,),
            Expanded(
              child:  GridView.builder(
                  itemCount: timess_list.length, 
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount
                  (crossAxisCount: 3, mainAxisSpacing:5, crossAxisSpacing:0),
                  itemBuilder: (context, index) => GestureDetector(
                    
                  child:GestureDetector(
                    onTap: (){
                      setState(() {
                        if(timess_list[index].check == true){
                        !timess_list[index].check;
                        showDialog(context: context,
                         builder: (context)=> AlertDialog(
                          title: Text('هل أنت متأكد؟'),
                          actions: [
                            TextButton(
                              child: Text('نعم',
                              style:TextStyle(color:Color.fromARGB(255, 4, 4, 71),),),
                              onPressed: ()=> Navigator.pop(context),
                            ),
                            TextButton(
                              child: Text('لا',
                              style:TextStyle(color:Color.fromARGB(255, 4, 4, 71),),),
                              onPressed: ()=> Navigator.pop(context),
                            )
                          ],
                         ),); 
                        print(timess_list[index].check);
                      }
                       
                      });
                      //clickCard();
                      checkSelectedCard(index+1);
                      tapped: index+1 == tapped_index;
                      if (selectedIndex.contains(index)) {
                           selectedIndex.remove(index);
                          } else {
                            selectedIndex.add(index);
                          }
                         
                    },
                    child: Card(
                      //times_list[index].check
                      //selectedIndex.contains(index)
                      //color:selectedIndex.contains(index)?
                       color:selectedIndex.contains(index)?
                       Color.fromARGB(255, 202, 43, 43):
                       timess_list[index].check ? 
                      Color.fromARGB(255, 4, 4, 71) 
                      :Color.fromARGB(255, 202, 43, 43),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 2,color: Color.fromARGB(255, 4, 4, 71),),
                        borderRadius: BorderRadius.circular(17),
                      ),
                      
                      //child: GridTile(
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(timess_list[index].initTime!,
                                  style: TextStyle(
                                    fontSize:14, fontWeight: FontWeight.w500,
                                    color:Color.fromARGB(255, 244, 244, 248),
                                  ),),
                                  //SizedBox(width: 1,),
                                  Text('-',
                                  style: TextStyle(
                                    fontSize:7, //fontWeight: FontWeight.bold,
                                    color:Color.fromARGB(255, 244, 244, 248),
                                  ),),
                                  //SizedBox(width: 3,),
                                  Text(timess_list[index].endTime!,
                                  style: TextStyle(
                                    fontSize:14, fontWeight: FontWeight.w500,
                                    color:Color.fromARGB(255, 244, 244, 248),
                                  ),),
                                 // SizedBox(width: 1,),
                                  
                                ],
                              ),
                              SizedBox(height: 5,),
                              selectedIndex.contains(index)?
                              Text(  'غير متاح',  
                                  style: TextStyle(
                                    fontSize:20, fontWeight: FontWeight.w500,
                                    color:Color.fromARGB(255, 244, 244, 248),
                                  ),):
                              timess_list[index].check ?
                              Text(  'متاح' ,  
                                  style: TextStyle(
                                    fontSize:20, fontWeight: FontWeight.w500,
                                    color:Color.fromARGB(255, 244, 244, 248),
                                  ),)
                                  :
                              Text(  'غير متاح',  
                                  style: TextStyle(
                                    fontSize:20, fontWeight: FontWeight.w500,
                                    color:Color.fromARGB(255, 244, 244, 248),
                                  ),),
                                  
                                 
                            ],
                          ),
                        ),
                      //),
                      
                    ),
                  ),
                  ),
                ),
            ),
          ],
        ),
    );
  }
}
// ignore_for_file: unused_import, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:grad_project/Pages/NavBar.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:grad_project/Pages/perm_appintment.dart';
import 'package:grad_project/Pages/temp_appointment.dart';

class tutorPageforStudent extends StatefulWidget {
  const tutorPageforStudent({super.key});

  @override
  State<tutorPageforStudent> createState() => _tutorPageforStudentState();
}

class _tutorPageforStudentState extends State<tutorPageforStudent> {
  double value = 3.5;
  double rating =0;
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
      ),
      body: 
      Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.33,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              image: DecorationImage(
                image: AssetImage('assets/images/msedge_0s3au1QvAD.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(child: 
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(30),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              //color: Color.fromARGB(255, 4, 4, 71),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 4, 4, 71),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,                  
                  children: <Widget>[
                     SizedBox(height: 30,),
                     Text('أيمن صبوح',
                     textAlign: TextAlign.left,
                     style: TextStyle(
                      fontSize: 35, fontWeight: FontWeight.bold,
                      color:Color.fromARGB(255, 244, 244, 248),
                     ),),
                     SizedBox(height: 5,),
                     Text('فيزياء',
                     textAlign: TextAlign.left,
                     style: TextStyle(
                      fontSize: 27, fontWeight: FontWeight.w500,
                      color:Color.fromARGB(255, 214, 214, 218),
                     ),),
                     Divider(color: Color.fromARGB(255, 244, 244, 248),),
                     Row(
                      //crossAxisAlignment: CrossAxisAlignment.center, 
                      children: <Widget>[
                      Icon(Icons.star_rate, size:30,color:Colors.amber,),
                      Icon(Icons.star_rate, size:30,color:Colors.amber,),
                      Icon(Icons.star_rate, size:30,color:Colors.amber,),
                      Icon(Icons.star_rate, size:30,color:Colors.amber,),
                      Icon(Icons.star_rate, size:30,color:Colors.amber,),
                      SizedBox(width:10),
                      Text('4.8',
                      style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color:Color.fromARGB(255, 244, 244, 248),),),
                     ],),
                     SizedBox(height: 5,),
                     Row(
                      crossAxisAlignment: CrossAxisAlignment.center, 
                      children: <Widget>[
                      Text('60',
                      style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color:Color.fromARGB(255, 244, 244, 248),),),
                      SizedBox(width: 5,),
                      Text('₪/ساعة',
                      style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color:Color.fromARGB(255, 244, 244, 248), 
                      ),),
                     ],),
                     //Divider(color: Color.fromARGB(255, 244, 244, 248),),
                     SizedBox(height: 30,),
                     GestureDetector(
                       child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height *0.1,
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(width: 1, color: Color.fromARGB(255, 244, 244, 248),),
                            bottom: BorderSide(width: 1, color: Color.fromARGB(255, 244, 244, 248),),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Icon(Icons.arrow_left_outlined,size:50,color:Color.fromARGB(255, 178, 214, 248),),
                            Text('حجوزات دائمة',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 25,
                              color:Color.fromARGB(255, 244, 244, 248),
                            ),),
                          ],
                        ),
                       ),
                       onTap: (){
                        Navigator.pushReplacement(context, 
                        MaterialPageRoute(builder: (context) => PermAppoint() ));
                      },
                     ),
                     GestureDetector(
                       child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height *0.1,
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(width: 1, color: Color.fromARGB(255, 244, 244, 248),),
                            bottom: BorderSide(width: 1, color: Color.fromARGB(255, 244, 244, 248),),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Icon(Icons.arrow_left_outlined,size:50,color:Color.fromARGB(255, 178, 214, 248),),
                            Text('حجوزات مؤقتة',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 25,
                              color:Color.fromARGB(255, 244, 244, 248),
                            ),),
                          ],
                        ),
                       ),
                       onTap: (){
                        Navigator.pushReplacement(context, 
                        MaterialPageRoute(builder: (context) => TempAppoint() ));
                      },
                     ),
                     SizedBox(height: 40,),
                     Divider(),
                     Container(
                      width: MediaQuery.of(context).size.width ,
                      height: MediaQuery.of(context).size.height *0.1,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        //borderRadius: BorderRadius.all(Radius.circular(10)),
                        //border: Border.all(width:2,color: Color.fromARGB(255, 247, 241, 130), )
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text('ما مدى رضالك عن اداء الأستاذ؟',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 25,
                            color:Color.fromARGB(255, 244, 244, 248),
                          ),),
                          SizedBox(width: 15,),
                          Icon(Icons.reviews_rounded,size:30,color:Color.fromARGB(255, 231, 204, 70),),
                        ],
                      ),
                     ),
                     //SizedBox(height: 10,),
                     Container(
                      width: MediaQuery.of(context).size.width ,
                      height: MediaQuery.of(context).size.height *0.2,
                      padding: EdgeInsets.all(5),
                     /* decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(width:2,color: Color.fromARGB(255, 247, 241, 130), )
                      ),*/
                      /*child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                         /* RatingStars(
                            value: value,
                            onValueChanged: (v){
                              setState(() {
                                value= v;
                              });
                            },
                            starBuilder: (index, color) => Icon(
                              Icons.star,
                              color: Color.fromARGB(255, 255, 243, 76),),
                              starCount: 5,
                              starSize: 30,
                              valueLabelColor: const Color(0xff9b9b9b),
                              valueLabelTextStyle: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 25,
                                color:Color.fromARGB(255, 244, 244, 248),
                              ),
                              valueLabelRadius: 10,
                              maxValue: 5,
                              starSpacing: 2,
                              maxValueVisibility: true,
                              valueLabelVisibility: true,
                              animationDuration: Duration(milliseconds: 1000),
                              valueLabelPadding: const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                              valueLabelMargin: const EdgeInsets.only(right: 8),
                              starOffColor: const Color(0xffe7e8ea),
                              starColor: Colors.yellow,

                          ),*/
                        ],
                      ),*/
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(' التقييم:  $rating',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 30,
                              color:Color.fromARGB(255, 244, 244, 248),
                            ),),
                            RatingBar.builder(
                            minRating: 1,
                            itemSize: 45,
                            itemPadding: EdgeInsets.symmetric(horizontal:4),
                            itemBuilder: (context, _)=> Icon(
                              Icons.star,color: Colors.amber,),
                              updateOnDrag: true, 
                            onRatingUpdate: (rating) =>
                              setState(() {
                              this.rating = rating;
                              }),),

                          ],
                        ),
                      ),
                     ),
                  ],
                ),
           
            ),),)
        ],
      ),

    );
  }
}
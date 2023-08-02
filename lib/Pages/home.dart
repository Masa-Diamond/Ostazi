// ignore_for_file: unused_import, prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grad_project/Pages/NavBar.dart';
import 'package:grad_project/Pages/acoount.dart';
import 'package:grad_project/Pages/bookings.dart';
import 'package:grad_project/Pages/courses.dart';
import 'package:grad_project/Pages/inbox-student.dart';
import 'package:grad_project/Pages/search.dart';
import 'package:grad_project/Pages/tutors.dart';
import 'package:grad_project/main.dart';

class homePage extends StatefulWidget { 
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  //final navigationKey = GlobalKey<CurvedNavigationBarState>();
  var _page =0;
  final List pages =[homePage(),searchStu(),StuProfile()];
  


  @override

  Widget build(BuildContext context) {
    
    var size = MediaQuery.of(context)
        .size;
    return Scaffold(
      drawer: NavBar(),
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
        extendBody: true,
        backgroundColor: Color.fromARGB(255, 244, 244, 248),
        bottomNavigationBar:       
           Theme(
            data: Theme.of(context).copyWith(
              iconTheme: IconThemeData(color:Color.fromARGB(255, 208, 208, 208))
            ),
             child: CurvedNavigationBar(
              index: 0,
              height: 60,
              items: [
                Icon(Icons.home_filled, size: 30, 
                     color:Color.fromARGB(255, 244, 244, 248) ,),
                     
                GestureDetector(
                  onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => searchStu() ));
                    },
                  child: Icon(Icons.explore_rounded, size: 30, 
                       color:Color.fromARGB(255, 235, 238, 231)),
                ),

                GestureDetector( 
                  onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => StuProfile() ));
                    },
                  child: Icon(Icons.perm_identity_sharp, size: 30, 
                       color:Color.fromARGB(255, 235, 238, 231),),
                ),
               
          ],
              //index: index,
              buttonBackgroundColor: Color.fromARGB(255, 4, 4, 71),
              backgroundColor: Colors.transparent,
              color: Color.fromARGB(255, 4, 4, 71),
              animationDuration: Duration(milliseconds: 300),
              animationCurve: Curves.easeInOut,
              /*onTap: (index){
                setState(() {
                  _page = index;
                });
              },*/
             ),
           ),

           

        body:
        ///pages[_page],  
        Stack(
          children: [
            
          //getSelectedWidget(index:index),
          SizedBox(height: 100),
    
          Container(
            padding: EdgeInsets.all(1),
            width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.40, 
            decoration: BoxDecoration(
              //color: Color.fromARGB(255, 96, 152, 114),
                          
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(35),
                  bottomRight: Radius.circular(35),
                ),
              image: DecorationImage(
                image: AssetImage('assets/images/juicy-business-coach-explains-the-material-to-the-woman.gif'),
                //colorFilter: new ColorFilter.mode(Color.fromARGB(255, 216, 236, 199).withOpacity(1), BlendMode.dstATop),
                //alignment: Alignment.centerLeft,
                colorFilter: new ColorFilter.mode(Color.fromARGB(255, 4, 4, 71).withOpacity(1), BlendMode.dstATop),
                //alignment: Alignment.centerLeft,
                fit: BoxFit.cover,
    
              ),
            ),
          ),
    
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  SizedBox(height: 70),
                 // Align(
                    //alignment: Alignment.bottomCenter,
                  Text(
                    "",
                    style: TextStyle(
                        fontFamily: 'Courgette',
                        fontWeight: FontWeight.w900,
                        fontSize: 43.0,
                        //fontFeatures: fon,
                        letterSpacing: 1.5,
                        color: Color.fromARGB(255, 4, 4, 71),
                      ),
                  ),
              //),
    
              SizedBox(height:180),
              
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  crossAxisSpacing: 30,
                  mainAxisSpacing: 20,
                  children: [
                    Container(
                      height: 120,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 231, 239, 220),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[Color.fromARGB(255, 253, 246, 204),Color.fromARGB(255, 253, 246, 204)],
                         // colors: <Color>[Color.fromARGB(255, 235, 238, 231),Color.fromARGB(255, 235, 238, 231)],
                          
                        ),
                        borderRadius: BorderRadius.circular(13),
                        boxShadow: [BoxShadow(
                          color: Color.fromARGB(255, 183, 181, 181),
                          blurRadius: 6.0,
                        )]
                        
                      ),
                      child: Column(
                        children:[
                          //SvgPicture.network(url),
                          GestureDetector(
                            onTap: (){
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => courses() ));
                            },
                            child: Icon(Icons.school_outlined, size: 80,
                              color: Color.fromARGB(255, 4, 4, 71)),
                          ),
                          Spacer(),
                          Text(
                           "حصص المعهد",
                           style: TextStyle(
                           fontWeight: FontWeight.w900,
                           fontSize: 20.0,
                           color: Color.fromARGB(255, 4, 4, 71),
                           ),
                          ),
    
                        ],
                      ),
                    ),
    
    
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 231, 239, 220),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[Color.fromARGB(255, 249, 205, 227),Color.fromARGB(255, 249, 205, 227)],
                          //colors: <Color>[Color.fromARGB(255, 235, 238, 231),Color.fromARGB(255, 235, 238, 231)],
                        ),
                        borderRadius: BorderRadius.circular(13),
                        boxShadow: [BoxShadow(
                          color: Color.fromARGB(255, 193, 190, 190),
                          blurRadius: 6.0,
                        )]
                      ),
                      child: Column(
                        children:[
                          //SvgPicture.asset(assetName),
                          GestureDetector(
                            onTap: (){
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => tutors() ));
                            },
                            child: Icon(Icons.class_outlined, size: 90,
                              color: Color.fromARGB(255, 4, 4, 71)),
                          ),
                          Spacer(),
                          Text(
                           "مدرس خصوصي",
                           style: TextStyle(
                           fontWeight: FontWeight.w900,
                           fontSize: 20.0,
                           color: Color.fromARGB(255, 4, 4, 71),
                      ),
                  ),
    
                        ],
                      ),
                    ),
    
    
                   Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 231, 239, 220),
                        gradient: LinearGradient(  
                          begin: Alignment.topCenter, 
                          end: Alignment.bottomCenter,
                          colors: <Color>[Color.fromARGB(255, 198, 237, 189),Color.fromARGB(255, 198, 237, 189)],
                          //colors: <Color>[Color.fromARGB(255, 235, 238, 231),Color.fromARGB(255, 235, 238, 231)],
                        ),
                        borderRadius: BorderRadius.circular(17),
                        boxShadow: [BoxShadow(
                          color: Color.fromARGB(255, 158, 154, 154),
                          blurRadius: 6.0,
                        )]
                      ),
                      child: Column(
                        children:[
                          //SvgPicture.asset(assetName),
                          GestureDetector(
                            onTap: (){
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => bookings() ));
                            },
                            child: Icon(Icons.book_online_outlined, size: 90,
                              color: Color.fromARGB(255, 4, 4, 71)),
                          ),
                          Spacer(),
                          Text(
                           "الحجوزات",
                           style: TextStyle(
                           fontWeight: FontWeight.w900,
                           fontSize: 20.0,
                           color: Color.fromARGB(255, 4, 4, 71),
                      ),
                  ),
                  ],
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 231, 239, 220),
                        gradient: LinearGradient(  
                          begin: Alignment.topCenter, 
                          end: Alignment.bottomCenter,
                          colors: <Color>[Color.fromARGB(255, 209, 243, 255),Color.fromARGB(255, 209, 243, 255)],
                          //colors: <Color>[Color.fromARGB(255, 235, 238, 231),Color.fromARGB(255, 235, 238, 231)],
                        ),
                        borderRadius: BorderRadius.circular(17),
                        boxShadow: [BoxShadow(
                          color: Color.fromARGB(255, 158, 154, 154),
                          blurRadius: 6.0,
                        )]
                      ),
                      child: Column(
                        children:[
                          //SvgPicture.asset(assetName),
                          GestureDetector(
                            onTap: (){
                              Navigator.pushReplacement(context, 
                              MaterialPageRoute(builder: (context) => ChatStu() ));
                            },
                            child: Icon(Icons.mark_unread_chat_alt, size: 90,
                              color: Color.fromARGB(255, 4, 4, 71)),
                          ),
                          Spacer(),
                          Text(
                           "المحادثات",
                           style: TextStyle(
                           fontWeight: FontWeight.w900,
                           fontSize: 20.0,
                           color: Color.fromARGB(255, 4, 4, 71),
                      ),
                  ),
                  ],
                      ),
                    ),


                   
                  ],
                ),
              ),
    
              SizedBox(height: 50),
                ],
              ),
            ),
          ),
    
        ],
        ),

        
      
    );
  }

  Widget getSelectedWidget ({required int index}){
  Widget widget;
  switch(index){
    case 0:
    widget = const homePage();
    break;

    case 1:
    widget = const searchStu();
    break;

    default:
    widget = const StuProfile();
    break;
  }

  return widget;

} 
}


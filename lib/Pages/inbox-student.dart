// ignore_for_file: unused_import, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:grad_project/Pages/NavBar.dart';
import 'package:grad_project/Pages/chat-screen-stu.dart';
import 'package:grad_project/Pages/chatting.dart';
import 'package:grad_project/Pages/chatting3.dart';

import 'chat_class.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'chat_reg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'chatting2.dart';


final _firestore = FirebaseFirestore.instance;
late User signedInUser; //this will give us the email
final _auth = FirebaseAuth.instance;

class ChatStu extends StatefulWidget {
  const ChatStu({super.key});

  @override
  State<ChatStu> createState() => _ChatStuState();
}
List selectedIndex = [];
   List<Chat> inbox = [
    Chat( "أيمن صبوح","ayman@gmail.com","شكرا أستاذ","9:30 PM"),
    Chat( "غسان الساحلي","ghasan@gmail.com","اتفقنا","6:00 PM"),
    Chat( "احمد شاعر","shaer@gmail.com","ان شاء الله بكرا","7:13 AM"),
    Chat( "حمدي وهبة","hamdi@gmail.com","الأسبوع القادم","10:08 AM"),
    Chat( "عمار النابلسي","ammar@gmail.com","العفو","8:27 PM"),
    Chat( "ماسة السيد","masa@gmail.com","بالكلاس بنناقشه","5:55 PM"),
  ];
   List<Chat> inbox_list = List.from(inbox);
class _ChatStuState extends State<ChatStu> {
  
  //late User signedInUser;
  
  //late String email;
  //late String password;
  //bool showSpinner = false;

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
              width: 100,
              height: 100,
              //color: Colors.white,
               decoration: BoxDecoration(
               image: DecorationImage(
               image: AssetImage("assets/images/loogo.png"),
               fit: BoxFit.fitWidth
            //colorFilter: new ColorFilter.mode(Color.fromARGB(255, 4, 4, 71).withOpacity(0.5), BlendMode.dstATop),
               //fit: BoxFit.cover,
           ),
          ),
            ),
            Text("صندوق الوارد",
            style: TextStyle(
              color: Color.fromARGB(255, 244, 244, 248),
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),),
            
          ],
        ),
        actions: [
          IconButton(
            onPressed: (){
              _auth.signOut();
              Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => ChatReg() ));
            },
             icon: Icon(Icons.logout), color: Color.fromARGB(255, 234, 234, 250),)
        ],
      ),

      body:
      Column(
        children: [
          GestureDetector(
            onTap: () async{
              try {
                final user = _auth.currentUser;
                if (user != null){
                signedInUser = user;
                print(signedInUser.email);
      
                Navigator.pushReplacement
                  (context, MaterialPageRoute(
                  builder: (context) => ChattScreen() ));
                  /*setState(() {
                    showSpinner = false;
                  }); */
                }
              } catch (e) {
                print(e);
              }
            },
            child: Container(

              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(45)),
                      border: Border.all(color:Color.fromARGB(255, 4, 4, 71),
                      width: 3, ),
                      //shape: BoxShape.circle,
                      // ignore: prefer_const_literals_to_create_immutables
                      boxShadow: [
                        BoxShadow( 
                          color: Color.fromARGB(255, 222, 219, 242),
                          spreadRadius: 2, blurRadius: 5,
                        ),
                      ]
                    ),
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage("assets/images/avatar.png"),),
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width* 0.65,
                    height: MediaQuery.of(context).size.height*0.15,
                    padding: EdgeInsets.only(left: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          Text("أيمن صبوح",style: TextStyle(
                            color: Color.fromARGB(255, 4, 4, 71),
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),),
                          /*Text(inbox_list[index].time!,style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w300,
                            fontSize: 15,
                          ),),*/
                        ],),
                        SizedBox(height:5,),
                        Container(alignment: Alignment.topLeft,
                          child: Text("ayman@gmail.com",
                          style: TextStyle(
                            color: Color.fromARGB(137, 18, 0, 45),
                            fontWeight: FontWeight.w800,
                            fontSize:15,
                          ), overflow: TextOverflow.ellipsis,maxLines: 2,),),
                        SizedBox(height:17,),
                        Container(alignment: Alignment.topLeft,
                          child: Text("تمام ان شاء الله",
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w600,
                            fontSize:15,
                          ), overflow: TextOverflow.ellipsis,maxLines: 2,),),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          ////////////////////////////////
          GestureDetector(
            onTap: () async{
              try {
                final user = _auth.currentUser;
                if (user != null){
                signedInUser = user;
                print(signedInUser.email);
      
                Navigator.pushReplacement
                  (context, MaterialPageRoute(
                  builder: (context) => ChattScreen2() ));
                  /*setState(() {
                    showSpinner = false;
                  }); */
                }
              } catch (e) {
                print(e);
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(45)),
                      border: Border.all(color:Color.fromARGB(255, 4, 4, 71),
                      width: 3, ),
                      //shape: BoxShape.circle,
                      // ignore: prefer_const_literals_to_create_immutables
                      boxShadow: [
                        BoxShadow( 
                          color: Color.fromARGB(255, 241, 238, 248),
                          spreadRadius: 2, blurRadius: 5,
                        ),
                      ]
                    ),
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage("assets/images/avatar.png"),),
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width* 0.65,
                    height: MediaQuery.of(context).size.height*0.15,
                    padding: EdgeInsets.only(left: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          Text("غسان الساحلي",style: TextStyle(
                            color: Color.fromARGB(255, 4, 4, 71),
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),),
                          /*Text(inbox_list[index].time!,style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w300,
                            fontSize: 15,
                          ),),*/
                        ],),
                        SizedBox(height:5,),
                        Container(alignment: Alignment.topLeft,
                          child: Text("ghasan@gmail.com",
                          style: TextStyle(
                            color: Color.fromARGB(137, 18, 0, 45),
                            fontWeight: FontWeight.w800,
                            fontSize:15,
                          ), overflow: TextOverflow.ellipsis,maxLines: 2,),),
                        SizedBox(height:17,),
                        Container(alignment: Alignment.topLeft,
                          child: Text("ان شاء الله",
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w600,
                            fontSize:15,
                          ), overflow: TextOverflow.ellipsis,maxLines: 2,),),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        
        ///////////////////////////////////////////////
        GestureDetector(
            onTap: () async{
              try {
                final user = _auth.currentUser;
                if (user != null){
                signedInUser = user;
                print(signedInUser.email);
      
                Navigator.pushReplacement
                  (context, MaterialPageRoute(
                  builder: (context) => ChattScreen3() ));
                  /*setState(() {
                    showSpinner = false;
                  }); */
                }
              } catch (e) {
                print(e);
              }
            },
            child: Container(

              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(45)),
                      border: Border.all(color:Color.fromARGB(255, 4, 4, 71),
                      width: 3, ),
                      //shape: BoxShape.circle,
                      // ignore: prefer_const_literals_to_create_immutables
                      boxShadow: [
                        BoxShadow( 
                          color: Color.fromARGB(255, 222, 219, 242),
                          spreadRadius: 2, blurRadius: 5,
                        ),
                      ]
                    ),
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage("assets/images/avatar.png"),),
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width* 0.65,
                    height: MediaQuery.of(context).size.height*0.15,
                    padding: EdgeInsets.only(left: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          Text("حمدي وهبة",style: TextStyle(
                            color: Color.fromARGB(255, 4, 4, 71),
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),),
                          /*Text(inbox_list[index].time!,style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w300,
                            fontSize: 15,
                          ),),*/
                        ],),
                        SizedBox(height:5,),
                        Container(alignment: Alignment.topLeft,
                          child: Text("hamdi@gmail.com",
                          style: TextStyle(
                            color: Color.fromARGB(137, 18, 0, 45),
                            fontWeight: FontWeight.w800,
                            fontSize:15,
                          ), overflow: TextOverflow.ellipsis,maxLines: 2,),),
                        SizedBox(height:17,),
                        Container(alignment: Alignment.topLeft,
                          child: Text("ولا يهمك",
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w600,
                            fontSize:15,
                          ), overflow: TextOverflow.ellipsis,maxLines: 2,),),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
       /*ListView.builder( 
        itemCount: inbox_list.length,
        itemBuilder: (context ,index){
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () async{
            try {
                final user = _auth.currentUser;
                if (user != null){
                signedInUser = user;
                print(signedInUser.email);
      
                Navigator.pushReplacement
                  (context, MaterialPageRoute(
                  builder: (context) => ChattScreen() ));
                  /*setState(() {
                    showSpinner = false;
                  }); */
                }
                
            } catch (e) {
              print(e);
            }
            
          },
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
              child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(45)),
                      border: Border.all(color:Color.fromARGB(255, 4, 4, 71),
                      width: 3, ),
                      //shape: BoxShape.circle,
                      // ignore: prefer_const_literals_to_create_immutables
                      boxShadow: [
                        BoxShadow( 
                          color: Color.fromARGB(255, 222, 219, 242),
                          spreadRadius: 2, blurRadius: 5,
                        ),
                      ]
                    ),
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage("assets/images/avatar.png"),
                      
                      ),
                  ),
        
                  Container(
                    width: MediaQuery.of(context).size.width* 0.65,
                    height: MediaQuery.of(context).size.height*0.15,
                    padding: EdgeInsets.only(left: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          Text(inbox_list[index].Account!,style: TextStyle(
                            color: Color.fromARGB(255, 4, 4, 71),
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),),
                          Text(inbox_list[index].time!,style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w300,
                            fontSize: 15,
                          ),),
                        ],),
                        SizedBox(height:5,),
                        Container(alignment: Alignment.topLeft,
                          child: Text(inbox_list[index].emaill!,
                          style: TextStyle(
                            color: Color.fromARGB(137, 18, 0, 45),
                            fontWeight: FontWeight.w800,
                            fontSize:15,
                          ), overflow: TextOverflow.ellipsis,maxLines: 2,),),
                        SizedBox(height:17,),
                        Container(alignment: Alignment.topLeft,
                          child: Text(inbox_list[index].msg!,
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w600,
                            fontSize:15,
                          ), overflow: TextOverflow.ellipsis,maxLines: 2,),),  
                      ],
                    ),
                  ),
                ],
              ),
            ),
        );
      }),*/ 
      
    );
  }
}

/*
class MessageStreamBuilder extends StatelessWidget {
  const MessageStreamBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('messages').orderBy('time').snapshots(),
      builder: (context,snapshot){
        List<UsersList> messageWidgets = [];

        if(!snapshot.hasData){
          //add here a spinner
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Color.fromARGB(255, 29, 1, 73),
            ),
          );
        };

        final messages = snapshot.data!.docs.reversed;
        for(var message in messages){
          final messageText = message.get('text');
          final messageSender = message.get('sender');
          //final messageTime = message.get('time');
          final currentUser = signedInUser.email;

          if(currentUser == messageSender){
            // the code of the message from the signed in user 
          }
          final messageWidget = UsersList(
            text: messageText, sender: messageSender);
          messageWidgets.add(messageWidget);
        };

        return Expanded(
          child: ListView(
            reverse: true, 
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            children: messageWidgets,
          ),
        );
      }
    );
  }
}


class UsersList extends StatelessWidget {
  const UsersList({this.text, this.sender,super.key});

  final String? sender;
  final String? text;
  //final String? time;
  //get sender => sender;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column( crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$sender',
          style: TextStyle(
            color:Color.fromARGB(255, 156, 120, 2),
            fontSize: 12,
          ),
          ),
          Material(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text('$text',
                style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.w700,
                color:  Color.fromARGB(255, 9, 1, 53),
              ),),
            ),
          ),
        ],
      ),
    );
     /*GestureDetector(
      onTap: () async{
        try {
            final user = _auth.currentUser;
            if (user != null){
            signedInUser = user;
            print(signedInUser.email);

            Navigator.pushReplacement
              (context, MaterialPageRoute(
              builder: (context) => ChattScreen() ));
              setState(() {
               // showSpinner = false;
              }); 
            }
            
        } catch (e) {
          print(e);
        }          
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal:15,vertical: 10),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(45)),
                border: Border.all(color:Color.fromARGB(255, 4, 4, 71),
                width: 3, ),
                //shape: BoxShape.circle,
                // ignore: prefer_const_literals_to_create_immutables
                boxShadow: [
                  BoxShadow( 
                    color: Color.fromARGB(255, 222, 219, 242),
                    spreadRadius: 2, blurRadius: 5,
                  ),
                ]
              ),
              child: CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage("assets/images/avatar.png"),
                
                ),
            ),

            Container(
              width: MediaQuery.of(context).size.width* 0.65,
              padding: EdgeInsets.only(left: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Text('$sender',style: TextStyle(
                      color: Color.fromARGB(255, 4, 4, 71),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),),
                    /*Text('$time',style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w300,
                      fontSize: 15,
                    ),),*/
                  ],),
                  SizedBox(height: 10,),
                  Container(alignment: Alignment.topLeft,
                    child: Text('$text',
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ), overflow: TextOverflow.ellipsis,maxLines: 2,),),
                ],
              ),
            ),
          ],
        ),
      )
    );*/
  }
}
*/
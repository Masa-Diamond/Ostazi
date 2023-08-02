// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grad_project/Pages/inbox-student.dart';
import 'package:firebase_auth/firebase_auth.dart';


final _firestore = FirebaseFirestore.instance;
late User signedInUser; //this will give us the email

class ChattScreen2 extends StatefulWidget {
  const ChattScreen2({super.key});

  @override
  State<ChattScreen2> createState() => _ChattScreen2State();
}

class _ChattScreen2State extends State<ChattScreen2> {
  @override
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  
  
  String? messageText;
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
      backgroundColor: Color.fromARGB(255, 241, 241, 243),
      appBar:AppBar(
        backgroundColor: Color.fromARGB(255, 5, 1, 50),
        title: Row(
          children: [
            Image.asset("assets/images/loogo.png",height: 25,),
            SizedBox(width: 10,),
            Text("MessageMe!",
            style: TextStyle(
              color: Color.fromARGB(255, 244, 243, 254),
              fontSize: 20, fontWeight: FontWeight.bold,
            ),),
          ],
        ),
        leading:
          IconButton(onPressed: (){
            //messagesStreams();
            Navigator.pushReplacement
            (context, MaterialPageRoute(
            builder: (context) => ChatStu() ));
          }, 
          icon: Icon(Icons.arrow_back_ios), color:Color.fromARGB(255, 244, 243, 254),)
        
      ) ,

      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MessageStreamBuilder(),

            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Color.fromARGB(255, 241, 204, 83),
                    width: 2,
                  ),
                ),
              ),
              child: Row(crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                    onChanged: (value){
                      messageText = value;
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical:10,horizontal: 20),
                      hintText: "...اكتب رسالتك هنا",
                      border: InputBorder.none,
                    ),
                  ),),
                  TextButton(
                    onPressed: () {
                    messageTextController.clear();
                    _firestore.collection('messages2').add({
                      'text': messageText,
                      'sender': signedInUser.email,
                      'time' : FieldValue.serverTimestamp(),
                    });
                  }, 
                  child:Text("إرسال",
                  style: TextStyle(
                    color: Color.fromARGB(255, 15, 76, 117),
                    fontWeight: FontWeight.bold, fontSize:20,
                  ),
                  ),
                  ),
                ], 
              ),
            ),
          
          ],
        ),
      ),
    );
  }
}

class MessageStreamBuilder extends StatelessWidget{
  const MessageStreamBuilder({super.key});

  @override
  Widget build(BuildContext context) {
  return StreamBuilder<QuerySnapshot>(
    stream: _firestore.collection('messages2').orderBy('time').snapshots(),
      builder: (context,snapshot){
        List<MessageLine> messageWidgets = [];

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
          final messageTime = message.get('time');
          final currentUser = signedInUser.email;

          if(currentUser == messageSender){
            // the code of the message from the signed in user 
          }
          final messageWidget = MessageLine(
            text: messageText, sender: messageSender, 
            isMe : currentUser == messageSender);
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

class MessageLine extends StatelessWidget {
  const MessageLine({this.text, this.sender,required this.isMe,super.key});
  
  final String? sender;
  final String? text;
  final bool isMe;
  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text('$sender',
          style: TextStyle(
            color:Color.fromARGB(255, 156, 120, 2),
            fontSize: 12,
          ),
          ),
          Material(
            elevation: 5,
            
            borderRadius: isMe ? BorderRadius.only(             
              topLeft: Radius.circular(30),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
              
            ) :
            BorderRadius.only(             
              topRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
              
            ),
            color: isMe ? Color.fromARGB(255, 9, 1, 53) : Color.fromARGB(255, 229, 233, 249),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text('$text',
                style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.w700,
                color:isMe? Color.fromARGB(255, 229, 233, 249) : Color.fromARGB(255, 9, 1, 53),
              ),),
            ),
          ),
        ],
      ),
    );
  }
}
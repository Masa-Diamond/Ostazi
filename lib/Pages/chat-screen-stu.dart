// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, dead_code

import 'package:flutter/material.dart';
import 'package:grad_project/Pages/inbox-student.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  _chatBubble( bool isMe, bool isSameUser){

    if(isMe){
      return ///////sender
                Column(
                  children:<Widget> [
                    Container(
                      alignment: Alignment.topRight,
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width *0.80,
                        ),
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                         border: Border.all(color:Color.fromARGB(255, 253, 200, 242),
                         width: 1, ),
                          color:Color.fromARGB(255, 4, 4, 71) ,                                      
                          //borderRadius: BorderRadius.circular(15),
                          
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 222, 219, 242),
                                spreadRadius: 2, blurRadius: 5,
                            ),
                          ],
                        ),
                        child: Text("يا هلا مسا الخير",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 244, 244, 248),
                        ),),
                      ),
                    ),
                  
                //time
                !isSameUser ?
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text('9:27',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 12,
                    ),)
                  ],
                ):
                Container(child: null,),
                ],
                // ignore: dead_code
                );
    }
    else {
       return 
                /////////receiver
                Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width *0.80,
                        ),
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color:Color.fromARGB(255, 244, 244, 248),                 
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 222, 219, 242),
                                spreadRadius: 2, blurRadius: 5,
                            ),
                          ],
                        ),
                        child: Text("مرحبا",
                        style: TextStyle(
                          fontSize: 25,
                          color: Color.fromARGB(255, 4, 4, 71) ,
                        ),),
                      ),
                    ),
                  
                ///time
                !isSameUser ?
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text('9:25',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 12,
                    ),)
                  ],
                )
                : Container(child: null,),
                ],
                );


    }
    
  }


_sendMessageArea(){
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8),
    height: 70,
    color: Color.fromARGB(255, 244, 244, 248),
    child: Row(
     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(onPressed: (){

        }, 
        icon: Icon(Icons.photo),
        iconSize: 25,
        color: Color.fromARGB(255, 4, 4, 71) ,
        ),


        Expanded(
          child: TextField(
            decoration: InputDecoration.collapsed(
              hintText: '... أرسل رسالة'
            ),
        
          ),
        ),



        IconButton(onPressed: (){
          _chatBubble(true,true);

        }, 
        icon: Icon(Icons.send),
        iconSize: 25,
        color: Color.fromARGB(255, 4, 4, 71) ,
        ),
      ],
    ),
  );

}


  @override
  Widget build(BuildContext context) {
    int prevUserID;
    return Scaffold(
      appBar: AppBar(
        elevation: 8,
        
        // ignore: prefer_const_constructors
        leading: IconButton(icon: Icon(
          Icons.arrow_back_ios,
          color:Color.fromARGB(255, 244, 244, 248),
        ),
        onPressed: (){
          Navigator.push(context,
          MaterialPageRoute(builder: (context) => const ChatStu()),
  );
        },
        ),


        backgroundColor: Color.fromARGB(255, 4, 4, 71),
        centerTitle: true,
        title:
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [            
            Text("محادثة خاصة",
            style: TextStyle(
              color: Color.fromARGB(255, 244, 244, 248),
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),),
            
          ],
        ),
      ),

      body: Column(
        children: <Widget>[
          
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(20),
              reverse: true,
              itemCount: 2,
              itemBuilder: (BuildContext context, int index){
                
               // final bool isMe = msdg.sender.id == currentUser.id;
               // final Message = msg[index]
               //final bool isSameUser =  prevUserID == mdg.sender.id;
               //prevUserID = msg.sender.id;
               
               return _chatBubble(true,true);
              },
              
            ),
          ),
          //Container(),
          _sendMessageArea(),
        ],
      ),
    );
  }
}
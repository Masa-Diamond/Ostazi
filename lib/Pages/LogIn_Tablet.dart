// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:grad_project/Pages/admin.dart';

class LogInTablet extends StatefulWidget {
  const LogInTablet({super.key});

  @override
  State<LogInTablet> createState() => _LogInTabletState();
}

class _LogInTabletState extends State<LogInTablet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 244, 244, 248),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height*0.6,
                decoration: BoxDecoration(
                  //color: Color.fromARGB(255, 96, 152, 114),            
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(140),
                    bottomRight: Radius.circular(150),
                  ),
                  image: DecorationImage(
                  image: AssetImage('assets/images/boylog.png'),
                  fit: BoxFit.cover,
                  // ignore: unnecessary_new
                  colorFilter: new ColorFilter.mode(Color.fromARGB(255, 185, 213, 161).withOpacity(1), BlendMode.dstATop),
                  
                    )
                ),
              ),

              Container(
                margin: EdgeInsets.symmetric(horizontal: 25.0),
                width: MediaQuery.of(context).size.width*0.27,
                //key: formkey,
                child: Column(
                  children: [
                    SizedBox(height: 50.0),
                    TextFormField( 
                      style: TextStyle(fontWeight: FontWeight.w600,color: Color.fromARGB(255, 4, 4, 71),),             
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2,
                          color:Color.fromARGB(255, 4, 4, 71), ),
                          
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2,
                          color:Color.fromARGB(255, 4, 4, 71), ),
                        ),
                        hintText: 'اسم الحساب الشخصي',
                        prefixIcon: Icon(Icons.person, color: Color.fromARGB(255, 4, 4, 71)),
                      ),
                      
                    ),
                      
                    SizedBox(height: 50.0),
                    TextFormField(  
                      style: TextStyle(fontWeight: FontWeight.w600,color: Color.fromARGB(255, 4, 4, 71),),              
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2,
                          color:Color.fromARGB(255, 4, 4, 71) ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2,
                          color:Color.fromARGB(255, 4, 4, 71), ),
                        ),
                        hintText: 'كلمة السر',
                        prefixIcon: Icon(Icons.lock, color: Color.fromARGB(255, 4, 4, 71)),
                      ),
                      obscureText: true,
                    ),

                    SizedBox(height: 35.0),
                    GestureDetector(
                      child: InkWell(
                        child: Container(
                          height: 50.0,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 3.0,
                              color: Color.fromARGB(255, 4, 4, 71)),
                            //style: OutlineInputBorder.styleFrom(side: BorderSide(width: 3.0),), 
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: <Color>[Color.fromARGB(255, 232, 231, 246),Color.fromARGB(255, 174, 219, 255)],
                            ),
                            borderRadius: BorderRadius.circular(50.0),
                            
                          ),
                          child: Center(
                            child: Text(
                              'تسجيل الدخول',
                              style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20.0,
                              color: Color.fromARGB(255, 4, 4, 71),),
                            ),
                          ),
                        ),

                        onTap: (){
                          Navigator.pushReplacement
                          (context, MaterialPageRoute(
                            builder: (context) => AdminPage() ));
                          
                        },
                      ),
                    ),

                    SizedBox(height: 60.0),
                    /*Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: (){
                            
                          Navigator.pushReplacement(
                              context, MaterialPageRoute(
                                builder: (context) => AdminPage()));
                          },
                          child: Text('  انشاء حساب جديد',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize:18.0,
                                decoration: TextDecoration.underline,
                                color: Color.fromARGB(255, 220, 13, 13),),
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Text(
                          ' لا يوجد لديك حساب؟ ',
                          style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize:18.0,
                                color: Color.fromARGB(255, 4, 4, 71),
                              ),
                        ),
                      ],
                    ),*/
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    
    );
  }
}
require("dotenv").config();

const mysql =require('mysql2');
const express =require('express');
const bodyparser = require('body-parser');
var app = express();
app.use(bodyparser.json());
const jwt=require('jsonwebtoken');
const bcrypt =require('bcryptjs');
var passwordHash = require('password-hash');
const  request  = require("express");
var  query  = require("express");
var  query2  = require("express");
var date = require('date-and-time');


f=0;
//var session = require('express-session');

// app.use(session({
//  secret : 'booking',
//  resave : true,
//  saveUninitialized : true
// }))



app.use(express.json());
app.listen (3000,()=> console.log('the server is running on : 3000'));
var mysqlConnection = mysql.createConnection({

    host:process.env.DB_HOST,
    user:process.env.DB_USER,
    database:process.env.DB_NAME,
    password:process.env.DB_PASSWORD,
    multipleStatements : true

});

//batabase connection
mysqlConnection.connect((err)=>{
    if(!err)
    console.log('DB connection succeded');
    else 
    console.log('DB connection faild \n Error' + JSON.stringify(err, undefined,2));

});

//student register
app.post('/register',async (req,res)=>{
    //to get var
    var name=req.body.name;
    var last_name=req.body.last_name;
    var user=req.body.user;
    var email=req.body.email;
    var password=req.body.password;
    var school=req.body.school;
    var grade=req.body.grade;
    
    //query
    var sqlquery=" INSERT INTO student(first_name,last_name,user,email,pass,school,class) VALUES(?,?,?,?,?,?,?)";
    // //check email
    query = `SELECT * FROM student WHERE email = "${email}"`;
    query2 = `SELECT * FROM student WHERE user = "${user}"`;

    mysqlConnection.query(query , function(error, data){
       if(data.length > 0){
        f=1;
        console.log("this email is already been used")
        
        res.send(JSON.stringify({success:false,message:'this email is already been used'}));
       }

       //check user
         if(f==0){
         mysqlConnection.query(query2 , async function(error, data){
          if(data.length > 0){
            console.log("this user name is already been used")
            res.send(JSON.stringify({success:false,message:'this user name is already been used'}));
          }
         else{
          //hash password 
        // let hashedPassword = await bcrypt.hash(password,8);
        var hashedPassword = passwordHash.generate(password);
          console.log(email);
           console.log(hashedPassword);
        //call DB save info
         mysqlConnection.query(sqlquery,[name,last_name,user,email,hashedPassword,school,grade],function(error,results){
            if(error){
               res.send(JSON.stringify({success:false,message:error}));
               console.log(error);
             }
             else{
                console.log(results);
                res.json({ status: "OK" });
                 console.log("register successful");
                 //webtoken
                //    const token=jwt.sign({email:email}, 'secret')
                //    res.status(200).json({token:token});
             }
              })
            }
        });
    }
      } );

});



//login
//login student 
app.post('/login',  async (req, res,next)=>{
    var email=req.body.email;
        var password=req.body.password;
      
      if (email && password){
        //login using email
         query = `SELECT * FROM student WHERE email = "${email}"`;

         mysqlConnection.query(query , function(error, data){
            if(data.length > 0){
               for(var count =0; count < data.length; count++ ){
                if(passwordHash.verify(password, data[count].pass)){
                   
                   //redirect to main page
                   console.log("login succesful")
                   //res.send(JSON.stringify({success:true,message:'loged in'}));
                   const user_token ={name: email}
                   const accessToken = jwt.sign(user_token, process.env.ACCESS_TOKEN_SECRET)
                   
                   res.json({accessToken: accessToken})
                 }
                 else{
                    console.log('incorrect password')
                    res.send(JSON.stringify({success:false,message:'wrong password'}));
                    
                 }
               }
            }
            //login using user
            else{
                query = `SELECT * FROM student WHERE user = "${email}"`;
                mysqlConnection.query(query , function(error, data){
                   if(data.length > 0){
                      for(var count =0; count < data.length; count++ ){
                        if(passwordHash.verify(password, data[count].pass)){
                       // if(data[count].pass == hashedPassword){
                          
                          //redirect to main page
                          console.log("login succesful")
                          query2 = `SELECT email FROM student WHERE user = "${email}"`

                          mysqlConnection.query(query2, function(error,data){
                            var v=JSON.parse(JSON.stringify(data))
                            email=v[0].email
                            console.log(email)
                            const user_token ={name: email}
                            const accessToken = jwt.sign(user_token, process.env.ACCESS_TOKEN_SECRET)
                            
                            res.json({accessToken: accessToken})
                            
                          })
                         
                          //res.send(JSON.stringify({success:true,message:'loged in'}));

                        
                        }
                        else{
                           console.log('incorrect password')
                           res.send(JSON.stringify({success:false,message:'wrong password'}));
                        }
                      }
                    }
                    //check if it's a teacher!!
                    else{
                        query = `SELECT * FROM teacher WHERE email = "${email}"`;
                        
                        mysqlConnection.query(query , function(error, data){
                           if(data.length > 0){
                            const hidden=data[0].hidden
                            const yes = "yes"
                            if(hidden==yes){
                              console.log('your account is band')
                              res.send(JSON.stringify({success:false,message:'your account is band'}));
                              //stay in login page
                               }
                               else{
                                for(var count =0; count < data.length; count++ ){
                                 if(passwordHash.verify(password, data[count].pass)){
                                  
                                  //redirect to main page
                                  console.log("login succesful")
                                  const user_token ={name: email}
                                  const accessToken = jwt.sign(user_token, process.env.ACCESS_TOKEN_SECRET)
                                  
                                  res.json({accessToken: accessToken})
                                //  res.send(JSON.stringify({success:true,message:'loged in'}));
                                }
                                else{
                                   console.log('incorrect password')
                                   
                                   res.send(JSON.stringify({success:false,message:'wrong password'}));
                                   
                                }
                              }
                           } }//not a teacher or a student 
                           else{
                        
                            //not found
                             res.status(404).json('user not found');
                           
                            console.log('user not found, register now!')
                        }
                        });
                    }
               });}

         });
            } else{
        console.log("please enter email and password details");
        res.json("please enter email and password details" );
      }

        
    });

  //student profile
    app.get('/profile', authenticationToken, async (req,res)=>{
        //return the info that are for the authrized logged in user
        //const user = req.user_token;
        const user = req.user
        console.log(user)
        //res.send(JSON.stringify({success:true,message:'in profile'}))
        query = `SELECT * FROM student WHERE email = "${user}"`
        if(query !=null){
            mysqlConnection.query(query , function(error, data){
                if (data.length > 0){
                
                   var info=JSON.parse(JSON.stringify(data))
                  
                   console.log(info[0].first_name)
                   console.log(info[0].last_name)
                   console.log(info[0].user)
                   console.log(info[0].email)
                   console.log(info[0].class)
                   console.log(info[0].school)
                   

                    
                  }
                  res.json(info);
                  //res.send(JSON.stringify("success"))

            })
       
    }
})
//change profile info
app.put('/change-info', authenticationToken, async (req, res, next) => {
    const authrize = req.user
    console.log(authrize)
    var name=req.body.name;
    var last_name=req.body.last_name;
    var user=req.body.user;
    var email=req.body.email;
    var school=req.body.school;
    var grade=req.body.grade;
    var password=req.body.password;
    var hashedPassword = passwordHash.generate(password);
  mysqlConnection.query("UPDATE `student` SET `first_name`= (?) , `last_name`= (?) , `user`= (?) , `school`= (?) , `class` = (?) , `email` = (?) , `pass` = (?)  WHERE `email`= (?);", [name, last_name, user, school ,grade,email,hashedPassword , authrize]);
  
  
    res.json({ status: "OK" });
    next();
  });

  //minu display name 
  app.get('/minu', authenticationToken,async(req,res)=>{
    const user = req.user
    console.log(user)
    
    query = `SELECT * FROM student WHERE email = "${user}"`
    if(query !=null){
        mysqlConnection.query(query , function(error, data){
            if (data.length > 0){
            
               var info=JSON.parse(JSON.stringify(data))
              
               console.log(info[0].first_name )
               console.log(info[0].last_name )
               console.log(info[0].email)
              }
              res.json(info);

        })
   
}
  })

    //to authenticate token
    function authenticationToken(req,res,next){
     const authHeader = req.headers['authorization']
     const token = authHeader && authHeader.split(" ")[1]
     if (token == null) {
        console.log("you don't have a token!")
        return res.sendStatus(401);
     }
     jwt.verify(token, process.env.ACCESS_TOKEN_SECRET, (err, user_token)=>{
        if(err){ 
            console.log("your token is not vaild!")
            return res.sendStatus(403); 
       } else {
        console.log("your token is  vaild")
        
        
        req.user= user_token.name
        next()
        
       }
       
     })
    }
    //if the token is not authrized
    app.use(function(err,req,res,next){
        console.error(err.stack);
            res.status(500).send('something is wrong!!');
    });

    //logout
app.use("/logout",authenticationToken, function(req,res,next){
    
    console.log("loged-out")
    res.status(200).send('loged-out');
    
    //request.session.destroy();
    //redirect to the login page
})

//teacher register
//register
app.post('/register/t',async (req,res)=>{
    //to get var
    var name=req.body.name;
    var last_name=req.body.last_name;
    var email=req.body.email;
    var password=req.body.password;
    var subject=req.body.subject;
    var price=req.body.price;
    var school=req.body.school
    var user=req.body.user
    
    
    //query
    var sqlquery=" INSERT INTO teacher(first_name,last_name,subject,email,pass,price,school,user) VALUES(?,?,?,?,?,?,?,?)";
    // //check email
    query = `SELECT * FROM teacher WHERE email = "${email}"`;
    query2 = `SELECT * FROM teacher WHERE user = "${user}"`
    mysqlConnection.query(query , function(error, data){
       if(data.length > 0){
        f=1
        console.log("this email is already been used")
        res.json("this email is already been used");
       // res.send(JSON.stringify({success:false,message:'faild'}));


       }
       if(f==0){
         mysqlConnection.query(query2,function(error,data){
          if(data.length > 0){
            console.log("this user is already been used")
            res.json("this user is already been used")
           // res.send(JSON.stringify({success:false,message:'faild'}));
           }
           else{
            //hash password 
          // let hashedPassword = await bcrypt.hash(password,8);
          var hashedPassword = passwordHash.generate(password);
            console.log(email);
             console.log(hashedPassword);
          //call DB save info
           mysqlConnection.query(sqlquery,[name,last_name,subject,email,hashedPassword,price,school,user],function(error,results){
              if(error){
                 res.send(JSON.stringify({success:false,message:error}));
                 console.log(error);
               }
               else{
                  console.log(results);
                   //res.send(JSON.stringify({success:true,message:'teacher register'}));
                   res.json("new teacher successful")
                   console.log("new teacher successful");
                   //webtoken
                  //    const token=jwt.sign({email:email}, 'secret')
                  //    res.status(200).json({token:token});
               }
                })
              }
         })
       }
         
        
      } )
    

});

//teacher profile
app.get('/profile/t', authenticationToken, async (req,res)=>{
    //return the info that are for the authrized logged in user
    //const user = req.user_token;
    const user = req.user
    console.log(user)
    //res.send(JSON.stringify({success:true,message:'in profile'}))
    query = `SELECT * FROM teacher WHERE email = "${user}"`
    if(query !=null){
        mysqlConnection.query(query , function(error, data){
            if (data.length > 0){
            
               var info=JSON.parse(JSON.stringify(data))
              
               console.log(info[0].first_name)
               console.log(info[0].last_name)
               console.log(info[0].subject)
               console.log(info[0].email)
               console.log(info[0].school)
               console.log(info[0].user)
               console.log(info[0].price) //price per hour can be changed from profile 
               

                
              }
              res.json(info)
              //res.send(JSON.stringify("success"))

        })
   
}
})

//change teacher profile
app.put('/change-info/t', authenticationToken, async (req, res, next) => {
    const authrize = req.user
    console.log(authrize)
    var name=req.body.name;
    var last_name=req.body.last_name;
    var price=req.body.price;
    var email=req.body.email;
    var school=req.body.school
    var user=req.body.user
    var password=req.body.password;
    var hashedPassword = passwordHash.generate(password);
  mysqlConnection.query("UPDATE `teacher` SET `first_name`= (?) , `last_name`= (?)  , `email` = (?) , `pass` = (?) , `price` = (?) , `school` = (?) , `user` = (?) WHERE `email`= (?);", [name, last_name,email,hashedPassword,price,school,user, authrize]);
  
  
    res.json({ status: "OK" });
    next();
  });

//teacher info using teacher_id
app.get('/teacher-info' , async(req,res)=>{
    const id= req.body.id
    query = `SELECT * FROM teacher WHERE teacher_id = "${id}"`
    if(query !=null){
        mysqlConnection.query(query , function(error, data){
           
            if (data.length > 0){
              
               var info=JSON.parse(JSON.stringify(data))
              
               console.log(info[0].first_name)
               console.log(info[0].last_name)
               console.log(info[0].subject)
               console.log(info[0].score)
               console.log(info[0].price) //price per hour can be changed from profile 
               
              }
              res.json(info)
              //res.send(JSON.stringify("success"))

        })
    }
    })

//score
app.put('/score' , async(req,res)=>{
    const id= req.body.id
    const score =req.body.score
    query = `SELECT * FROM teacher WHERE teacher_id = "${id}"`
    if(query !=null){
        mysqlConnection.query(query , function(error, data){
           
            if (data.length > 0){
              
               var info=JSON.parse(JSON.stringify(data))
               var sum= parseFloat(info[0].score_sum) + parseFloat(score)
               var times = info[0].score_times +1
               var avg_score =  sum / times
               mysqlConnection.query("UPDATE `teacher` SET `score`= (?) , `score_sum`= (?) , `score_times`= (?)   WHERE `teacher_id`= (?);", [avg_score,sum,times,id]);
               console.log(avg_score)
              }
              //res.send(JSON.stringify("success"))
              res.json({ status: "OK" });
        })
    }
})

//search by subject
app.get('/search', async(req,res)=>{
    const subject = req.body.subject
    var i =0
    query = `SELECT * FROM teacher WHERE subject = "${subject}"`
    mysqlConnection.query(query, function(error,data){
        if(data.length > 0){
           var band
           var yes="yes"
            var info=JSON.parse(JSON.stringify(data))
            for(i ; i<info.length;i++){
                band = info[i].hidden
                if(band==yes){
                 continue
                }
                else{
                console.log(info[i].first_name)
                console.log(info[i].last_name)
                console.log(info[i].score)
                console.log(info[i].price)
                console.log(info[i].subject)
                console.log(info[i].teacher_id) // the id is needed to acces the teacher profile
                }

            }
             res.json(info)
            //res.send(JSON.stringify("search results"))
        }
        else{
            //res.send(JSON.stringify(" not found"))
            res.json("not found");
        }
    })

})

//add class
app.post('/class-add', authenticationToken, async(req,res,next)=>{
  const authrize = req.user
  const type= req.body.type
  const day= req.body.date
  const start =req.body.start
  const end =req.body.end
  var repeat = req.body.repeat
  var duration=repeat
  const mydate = day.split("/");
  var my_year = parseInt(mydate[0])
  var my_month = parseInt(mydate[1])-1
  var my_day = parseInt(mydate[2])+1
  console.log(my_day)
  console.log(my_month)
  console.log(my_year)
  //const pattern = date.compile('YYYY/MM/DD');
  var ddate = new Date(my_year,my_month,my_day);
  
  //date.format(ddate, pattern);
  var info2
      info2=JSON.parse(JSON.stringify(ddate))
       info2 = info2.split("T");
      result = info2[0]
      console.log(result)
      
  query = `SELECT * FROM teacher WHERE email = "${authrize}"`
  mysqlConnection.query(query, function(error,data){
    
      var info=JSON.parse(JSON.stringify(data))
      var id= info[0].teacher_id
      var subject =info[0].subject
      var price= info[0].price
      if(type=="once"){
        console.log("it's once")
      query2= "INSERT INTO class(subject,teacher_id,date,start,end,price,type) VALUES(?,?,?,?,?,?,?)"
      
      mysqlConnection.query(query2,[subject,id,result,start,end,price,type],function(error,results){
        if(error){
            console.log(error);
          }
          else{
              console.log("new class added successful");
    }
})

 while(repeat>1){
  
  ddate =date.addDays(ddate,7)
  info=JSON.parse(JSON.stringify(ddate))
 info = info.split("T");
 result = info[0]
 console.log(result)
  mysqlConnection.query(query2,[subject,id,result,start,end,price,type],function(error,results){
    if(error){
        console.log(error);
      }
      else{
          console.log("new class added successful");
}
})
repeat=repeat-1
 }}
 else{
  console.log("it's weekly")
  query2= "INSERT INTO class(subject,teacher_id,date,start,end,price,type,duration) VALUES(?,?,?,?,?,?,?,?)"
      
  mysqlConnection.query(query2,[subject,id,result,start,end,price,type,duration],function(error,results){
    if(error){
        console.log(error);
      }
      else{
          console.log("new class added successful");
}
})
 }

       
    
})
//res.send(JSON.stringify({success:true,message:'new classes added successfully'}));
res.json("new class added successfully")
        next();
})

//view weekly classes
app.get('/view/weekly', async(req,res,next)=>{
  const id= req.body.id
  const day=req.body.date
  const mydate = day.split("/");
  var my_year = parseInt(mydate[0])
  var my_month = parseInt(mydate[1])-1
  var my_day = parseInt(mydate[2])+1
  console.log(my_day)
  console.log(my_month)
  console.log(my_year)
  var ddate = new Date(my_year,my_month,my_day);
  var info2
      info2=JSON.parse(JSON.stringify(ddate))
       info2 = info2.split("T");
      result = info2[0]
      console.log(result)
  query = `SELECT * FROM class WHERE teacher_id = ${id} AND type = "weekly" AND date = "${result}" AND taken ="no"`
  mysqlConnection.query(query,function(error,data){
    if(data.length>0){
    var info=JSON.parse(JSON.stringify(data))
    var i =0
    for(i;i<info.length;i++){
      console.log(info[i].start)
      console.log(info[i].end)
      console.log(info[i].taken)
    }
   // res.send(JSON.stringify("ok"))
   res.json(info)
  }
  else{
    //res.send(JSON.stringify("no availble classes"))
    res.json("no availble classes")
  }


  })
})
//view once classes
app.get('/view/once', async(req,res,next)=>{
  const id= req.body.id
  const day=req.body.date
  const mydate = day.split("/");
  var my_year = parseInt(mydate[0])
  var my_month = parseInt(mydate[1])-1
  var my_day = parseInt(mydate[2])+1
 
  var ddate = new Date(my_year,my_month,my_day);
  var info2
      info2=JSON.parse(JSON.stringify(ddate))
       info2 = info2.split("T");
      result = info2[0]
      console.log(result)
  query = `SELECT * FROM class WHERE teacher_id = ${id} AND type = "once" AND date = "${result}"  AND taken ="no"`
  mysqlConnection.query(query,function(error,data){
    if(data.length>0){
    var info=JSON.parse(JSON.stringify(data))
    var i =0
    for(i;i<info.length;i++){
      console.log(info[i].start)
      console.log(info[i].end)
      console.log(info[i].taken)
    }
    res.send(JSON.stringify("ok"))
  }
  else{
    res.send(JSON.stringify("no availble classes"))
  }


  })
})

//booking a class
app.post("/booking",authenticationToken, async(req,res,next)=>{
  const user = req.user
  const id=req.body.id
  const taken="yes"
  mysqlConnection.query("UPDATE `class` SET `taken`= (?)  WHERE `class_id`= (?);", [taken,id]);
  
  query2= "INSERT INTO student_class(class_id,user) VALUES(?,?)"
      
  mysqlConnection.query(query2,[id,user],function(error,results){
    if(error){
        console.log(error);
      }
      else{
          console.log("new class booked");
}
//res.send(JSON.stringify("ok"))
res.json({ status: "OK" });
next()
})
})

//student cancle class
app.delete("/cancle/booking" , authenticationToken,async(req,res,next)=>{
  const user = req.user
  const id=req.body.id
  const taken="no"
  mysqlConnection.query("UPDATE `class` SET `taken`= (?)  WHERE `class_id`= (?);", [taken,id]);
  query2 = `SELECT * FROM student_class WHERE class_id = ${id} AND user = "${user}"`
  mysqlConnection.query(query2,function(error,data){
  
     if(data.length > 0){
       mysqlConnection.query( "DELETE FROM student_class WHERE `class_id` = (?) AND `user` = (?);",[id,user]);
      console.log(" class cancled");
     
  }
  
 })
 res.json({ status: "OK" });
 //res.send(JSON.stringify("ok"))  
next()
})
//teacher delete class
app.delete("/delete/class",authenticationToken,async(req,res,next)=>{
  const authrize = req.user
  const id=req.body.id
  var taken
  query =  `SELECT * FROM teacher WHERE email = "${authrize}"`
  mysqlConnection.query(query,function(error,data){
    if (data.length > 0){
      var info=JSON.parse(JSON.stringify(data))
      const teacher_id = info[0].teacher_id
      query2 =  `SELECT * FROM class WHERE class_id = ${id} AND teacher_id = "${teacher_id}" `
      mysqlConnection.query(query2,function(error,data){
        if(data.length>0){
          var info=JSON.parse(JSON.stringify(data))
           taken=info[0].taken
           if(taken=="no"){
            mysqlConnection.query( "DELETE FROM class WHERE `class_id` = (?);",[id]);
            console.log(" class deleted successfully");
           // res.send(JSON.stringify("class deleted successfully"))  
           res.json({ status: "OK" });
           }
           else{
            console.log("this class is booked!")
            //res.send(JSON.stringify("this class is booked! can't delete"))  
            res.json("this class is booked! can't delete")
          }
        }
        else{
          console.log("something is wrong!")
          res.json("something is wrong!")
          //res.send(JSON.stringify("something is wrong!"))  
        }
        
      })
    }
  })
  
 })

 //view my teacher
 app.get("/view/teacher",authenticationToken,async(req,res,next)=>{
  const user = req.user
  query = `SELECT * FROM student_class WHERE user = "${user}"`
  mysqlConnection.query(query,function(error,data){
    if(data.length > 0){
      var info=JSON.parse(JSON.stringify(data))
      var i=0
      var class_id
      var teacher_id
      //var [ids]=[0]
      for(i;i<info.length;i++){
        class_id = info[i].class_id
        
        // console.log("class id")
        // console.log(class_id)
        query2 = `SELECT * FROM class WHERE class_id = "${class_id}"`
        mysqlConnection.query(query2,function(error,data){
        if(data.length>0){
        var info2=JSON.parse(JSON.stringify(data))
        teacher_id=info2[0].teacher_id
        // var flag =0
        
        // for(var i=-1;i<ids.length;i++){
        //   console.log("check")
        //   if(teacher_id==ids[i]){
        //     flag=1
        //     console.log("yes")
        //   }

        // }
        // if(flag==0){
        // ids[i]=teacher_id}
        // console.log("teacher id")
        // console.log(teacher_id)
        query = `SELECT * FROM teacher WHERE teacher_id = "${teacher_id}"`
        mysqlConnection.query(query,function(error,data){
          if(data.length>0){
            
          var info3=JSON.parse(JSON.stringify(data))
          var yes ="yes"
          var band = info3[0].hidden
                if(band==yes){
                 console.log("hidden")
                }
                else{
                console.log(info3[0].first_name)
                console.log(info3[0].last_name)
                console.log(info3[0].score)
                console.log(info3[0].price)
                console.log(info3[0].subject)
                console.log(info3[0].teacher_id) // the id is needed to acces the teacher profile
                }
                res.json(info3)
              }
              else{
                console.log("teacher not found!!")
                res.json("teacher not found!!")
              }
        })
      }
      else{
        console.log("class not in table!!")
        res.json("class not in table!!")
      }
        })
      }
    }
  
  })
  console.log("done")
  //res.send(JSON.stringify("done")) 
 })
 
 //view my classes
 app.get("/view/classes",authenticationToken,async(req,res,next)=>{
  const user = req.user
  var arr=[]
  query = `SELECT * FROM student_class WHERE user = "${user}"`
  mysqlConnection.query(query,async function(error,data){
    if(data.length > 0){
      var info=JSON.parse(JSON.stringify(data))
      var i =0
      info.forEach(element => {
        console.log("class num")
        
        var id =element.class_id
        console.log(id)
        query = `SELECT * FROM class WHERE class_id = "${id}"`
        mysqlConnection.query(query, async function(error,data){
          var info=JSON.parse(JSON.stringify(data))
          var type=info[0].type
          var price=info[0].price
          var subject=info[0].subject
          var date=info[0].date
          var time=info[0].start.split(":")
          var hour=time[0]
          var min=time[1]
          var duration=hour
              duration+=":"
              duration+=min
              time=info[0].end.split(":")
              hour=time[0]
              min=time[1]
              duration+="-"
              duration+=hour
              duration+=":"
              duration+=min
              id=info[0].teacher_id
              query=`SELECT * FROM teacher WHERE teacher_id = "${id}"`
              mysqlConnection.query(query,async function(error,data){
                var info=JSON.parse(JSON.stringify(data))
                teacher=info[0].first_name
                teacher+=" "
                teacher+=info[0].last_name

                
                if(type=="once"){
                  console.log(teacher)
                console.log(subject)
                console.log(duration)
                console.log(price)

                var info2 = date.split("T");
                result = info2[0]
                result2=result.split("-")
                var my_year = parseInt(result2[0])
                var my_month = parseInt(result2[1])-1
                 var my_day = parseInt(result2[2])+2
 
                  var ddate = new Date(my_year,my_month,my_day);
        
               info3=JSON.parse(JSON.stringify(ddate))
                 info3 = info3.split("T");
                  result3 = info3[0]
                  console.log(result3)
                  arr.push(teacher)
                     arr.push(subject)
                     arr.push(duration)
                     arr.push(price)
                     arr.push(type)
                     arr.push(result3)
                }
                 if(type=="weekly"){
                  query=`SELECT DAYNAME('${date}')`
                  mysqlConnection.query(query,function(error,data){
                    var info=JSON.stringify(data)
                    var day=""
                    l=parseInt(info.length)-3
                    for(var i=41;i<l;i++){
                       day+=info[i]
                    }
                     console.log(teacher)
                     console.log(subject)
                     console.log(duration)
                     console.log(price)
                     console.log(type)
                     console.log(day)
                     arr.push(teacher)
                     arr.push(subject)
                     arr.push(duration)
                     arr.push(price)
                     arr.push(type)
                     arr.push(day)
                    //  console.log("the array")
                    // console.log(arr)
                    JSON.stringify(arr)
                    res.json(arr) //each 6 element is a class
                  })
                }
                
              })
          
          
        })
      });
      
      //    for(i;i<info.length;i++){
        
      // }
      
    }
  })
  
 })
 //teacher scheduale
 app.get("/booked",authenticationToken,async(req,res,next)=>{
  const authrize = req.user
  const taken ="yes"
  var arr=[]
  query =  `SELECT * FROM teacher WHERE email = "${authrize}"`
  mysqlConnection.query(query,function(error,data){
    if (data.length > 0){
      var info=JSON.parse(JSON.stringify(data))
      const teacher_id = info[0].teacher_id
      query2 =  `SELECT * FROM class WHERE teacher_id = "${teacher_id}" AND taken = "${taken}" `
      mysqlConnection.query(query2,function(error,data){
        var info=JSON.parse(JSON.stringify(data))
        var i =0
        var day
        var d
        var id
        var student
        for(i;i<info.length;i++){
          var info2
       info2=JSON.parse(JSON.stringify(info[i].date))
       info2 = info2.split("T");
       result = info2[0]
       result2=result.split("-")
       var my_year = parseInt(result2[0])
       var my_month = parseInt(result2[1])-1
       var my_day = parseInt(result2[2])+2
 
        var ddate = new Date(my_year,my_month,my_day);
        
       info3=JSON.parse(JSON.stringify(ddate))
       info3 = info3.split("T");
       result3 = info3[0]
       id=info[i].class_id
       var start=info[i].start
       var end=info[i].end
       var student
       query=`SELECT * FROM student_class WHERE class_id = "${id}" `
       mysqlConnection.query(query,function(error,data){
         var info2=JSON.parse(JSON.stringify(data))
         
         student=info2[0].user
         query=`SELECT * FROM student WHERE email = "${student}"`
         mysqlConnection.query(query,function(error,data){
           var info=JSON.parse(JSON.stringify(data))
           student=info[0].first_name
           student+=" "
           student+=info[0].last_name
           console.log(student)
           console.log(result3)
           console.log(start)
           console.log(end)
           arr.push(student)
           arr.push(result3)
           arr.push(start)
           arr.push(end)
           JSON.stringify(arr)
           res.json(arr)
                  
         })
       })
       
       

          
        
         
        }
      })
    }
    })
   // res.send(JSON.stringify("ok"))
 })
//teacher profit
app.get("/profit",authenticationToken,async(req,res,next)=>{
  const admin = req.user
  const teacher_id=req.body.id
  const date =req.body.date
  var yes="yes"
  query = `SELECT * FROM admin WHERE email = "${admin}"`
  mysqlConnection.query(query,function(error,data){
    if(data.length>0){
      if(date!=null){
        const mydate = date.split("/");
  var my_year = mydate[0]
  var my_month = mydate[1]
  var my_day = mydate[2]
 
  var result=""+my_year
  result+="-"
  result+=my_month
  result+="-"
  result+=my_day
  console.log(result)

      query = `SELECT * FROM class WHERE teacher_id = "${teacher_id}" AND taken = "${yes}" AND date = "${result}"`
      }
      else{
        query = `SELECT * FROM class WHERE teacher_id = "${teacher_id}" AND taken = "${yes}"`
      }
      mysqlConnection.query(query,function(error,data){
        if(data.length>0){
          var info=JSON.parse(JSON.stringify(data))
          const price=parseInt(info[0].price)
          var profit=0
          l=info.length
          for(var i =0;i<l;i++){
            if(info[i].type=="once"){
              console.log("once")
              profit+=price
            }
            else{
              if(date!=null){
                profit+=(price)
              }
              else{
              d=parseInt(info[0].duration)
              profit+=(d*price)}
            }
          }
          
          console.log(profit)
          res.json(profit)
          //res.send(JSON.stringify({message:'profit=',profit}));
        }
        else{
          console.log("teacher not found")
          res.send(JSON.stringify({success:false,message:'teacher not found'}));
        }
      })
    }
    else{
      console.log('you are not an authrized admin')
      res.send(JSON.stringify({success:false,message:'you are not an authrized admin'}));
    }
  })

})
 //band teacher
 app.put("/band",authenticationToken,async(req,res,next)=>{
  const admin = req.user
  const teacher_id=req.body.id
  const yes="yes"
  const no="no"
  query = `SELECT * FROM admin WHERE email = "${admin}"`
  mysqlConnection.query(query,function(error,data){
    if(data.length>0){
      query2 = `SELECT * FROM teacher WHERE teacher_id = "${teacher_id}"`
      mysqlConnection.query(query2,function(error,data){
       if(data.length>0){
         var info=JSON.parse(JSON.stringify(data))
         if(info[0].hidden==no){
           mysqlConnection.query("UPDATE `teacher` SET `hidden` = (?) WHERE `teacher_id`= (?);", [yes,teacher_id])
           console.log('done')
           res.send(JSON.stringify({success:false,message:'the teacher has been band'}));
         }
         else{
           mysqlConnection.query("UPDATE `teacher` SET `hidden` = (?) WHERE `teacher_id`= (?);", [no,teacher_id])
           console.log('done')
           res.send(JSON.stringify({success:false,message:'the teacher is back to work'}));
         }
       }
       else{
        
           console.log('something is wrong')
           res.send(JSON.stringify({success:false,message:'something is wrong!'}));
       }
      })
    }
    else{
      console.log('you are not an authrized admin')
           res.send(JSON.stringify({success:false,message:'you are not an authrized admin'}));
    }
  })
  
 

 })

 //add new autazi class
 app.post("/austazi/class" ,authenticationToken,async(req,res,next)=>{
  const admin = req.user
  var teacher= req.body.teacher
  const day= req.body.day
  const start =req.body.start
  const end =req.body.end
  const day_date =req.body.date
  const price = req.body.price
  const capacity =req.body.capacity
  const subject =req.body.subject
  const mydate = day_date.split("/");
  var my_year = parseInt(mydate[0])
  var my_month = parseInt(mydate[1])-1
  var my_day = parseInt(mydate[2])+1
  console.log(my_day)
  console.log(my_month)
  console.log(my_year)
  //const pattern = date.compile('YYYY/MM/DD');
  var ddate = new Date(my_year,my_month,my_day);
  
  //date.format(ddate, pattern);
  var info2
      info2=JSON.parse(JSON.stringify(ddate))
       info2 = info2.split("T");
      result = info2[0]
      console.log(result)
     var teachers=teacher.split(" ")
      first_name=teachers[0]
      last_name=teachers[1]
      console.log(first_name)
      console.log(last_name)
      query = `SELECT * FROM admin WHERE email = "${admin}"`
      mysqlConnection.query(query,function(error,data){
        if(data.length>0){
          query = `SELECT * FROM teacher WHERE first_name = "${first_name}" AND last_name = "${last_name}"`
          mysqlConnection.query(query,function(error,data){
            if(data.length>0){
           var info=JSON.parse(JSON.stringify(data))
            const teacher_id=info[0].teacher_id
            query2= "INSERT INTO austazi(teacher,teacher_id,date,start,end,price,day,subject,capacity) VALUES(?,?,?,?,?,?,?,?,?)"
      
            mysqlConnection.query(query2,[teacher,teacher_id,result,start,end,price,day,subject,capacity],function(error,results){
              if(error){
                  console.log(error);
                }
                else{
                    console.log("new class added successful");
                    res.send(JSON.stringify({success:true,message:'new classes added successfully'}));
          }
          })
        }
        else{
          console.log('teacher not found')
          res.send(JSON.stringify({success:false,message:'teacher not found'}));
        }
          })

        }
        else{
          console.log('you are not an authrized admin')
          res.send(JSON.stringify({success:false,message:'you are not an authrized admin'}));
        }
      })
      

 })

 //delete autazi class
 app.delete("/austazi/delete",authenticationToken,(req,res,next)=>{
  const admin = req.user
  const class_id =req.body.id
  query = `SELECT * FROM admin WHERE email = "${admin}"`
 mysqlConnection.query(query,function(error,data){
  if(data.length>0){
    mysqlConnection.query( "DELETE FROM austazi WHERE `id` = (?);",[class_id]);
            console.log(" class deleted successfully");
            res.send(JSON.stringify("class deleted successfully"))  
  }
  else{
    console.log('you are not an authrized admin')
    res.send(JSON.stringify({success:false,message:'you are not an authrized admin'}));
  }
 })
 })
 //admin login
 app.post("/admin",async(req,res,next)=>{
        var email=req.body.email
        var password=req.body.password
        //var hashedPassword = passwordHash.generate(password);
        //mysqlConnection.query("UPDATE `admin` SET `pass` = (?) WHERE `email`= (?);", [hashedPassword,email]);
        query = `SELECT * FROM admin WHERE email = "${email}"`
        
       mysqlConnection.query(query,function(error,data){
        
          if(data.length>0){
          var info=JSON.parse(JSON.stringify(data))
          if(passwordHash.verify(password, info[0].pass)){
         // if(data[count].pass == hashedPassword){
            
            //redirect to main page
              console.log("login succesful")
              const user_token ={name: email}
              const accessToken = jwt.sign(user_token, process.env.ACCESS_TOKEN_SECRET)
              
              res.json({accessToken: accessToken})
              
            
            //res.send(JSON.stringify({success:true,message:'loged in'}));

          }
          else{
             console.log('incorrect password')
             res.send(JSON.stringify({success:false,message:'wrong password'}));
          }}
          else{
            console.log('account not found')
            res.send(JSON.stringify({success:false,message:'account not found'}));
          }
       })
 })

//test
app.get('/date',async(req,res)=>{
    const ddate = req.body.date
    const mydate = ddate.split("/");
    const my_year = mydate[0]
    const my_month = mydate[1]-1
    const my_day = mydate[2]
    
    console.log(my_year)
    console.log(my_month)
    console.log(my_day)
    const pattern = date.compile('YYYY/MM/DD');
    const m = new Date(my_year,my_month,my_day);
    
    
    const s =date.addDays(m,8)
    date.format(s, pattern);
    var info=JSON.parse(JSON.stringify(s))
     info = info.split("T");
    console.log(info[0])
    const result = info[0]
    query=`SELECT DAYNAME('${result}')`
    mysqlConnection.query(query,function(error,data){
      var info=JSON.stringify(data)
      var day=""
      l=parseInt(info.length)-3
      for(var i=27;i<l;i++){
         day+=info[i]
      }
      
      console.log(day)
    })
res.send(JSON.stringify({success:true,message:result}));
})
app.get("/test",async(req,res)=>{
  var student="o"
  student+="i"
  console.log(student)
  res.send(JSON.stringify("hi"));
})


      // query = `SELECT * FROM class WHERE teacher_id = "${id}"`
    // query=`SELECT * FROM class WHERE teacher_id = ${id} AND date = ${result} AND (TIME(${start}) <= start AND start < TIME(${end}));`

// app.get('/class',(err, res)=>{
//     mysqlConnection.query(`SELECT * FROM class`,(err ,rows,fields)=>{
//             if(!err)
//               console.log(rows);
//               else 
//               console.log(err);
//          })
// });
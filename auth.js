
//if the token is authrized the next will exicute
const jwt = require("jsonwebtoken");
const auth =(req,res,next)=>{
    //passing the token from the postman header
    
   try{

    const token  =req.headers.authrixation.split(" ");
    if(token[0]=='Bwarer' && Jwt.varify(token[1],f00118e9bc7e06c64d3875b286c50468eef41ff132f5fae4484ef0f05dd6bef2d155afa307e9e353402ca76e179e373067ed526935916d581781776681089345)){
        next()
    }
} catch(e){
            if(e.name=== 'JsownerbtokenError') {
                res.sendStatus(401);
            }else{
                res.sendStatus(401);
            }

    }
}
module.exports=auth;
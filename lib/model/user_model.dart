class UserModel{
  String? Uid;
  String? FirstName;
  String? LastName;
  String? Account;
  String? email;
  String? password;
  String? School;
  String? Grade;

  UserModel({this.Uid, this.FirstName, this.LastName, this.Account, this.email, this.password, this.School, this.Grade});
  
  //recieving data from server
  factory UserModel.fromMap(map){
    return UserModel(
      Uid: map['uid'],
      FirstName: map['FirstName'],
      LastName: map['LastName'],
      Account: map['Account'],
      email: map['email'],
      School: map['School'],
      Grade: map['Grade']
    );
  }

  //sending data to our server
  Map<String, dynamic> toMap(){
    return{
      'uid': Uid,
      'FirstName': FirstName,
      'LastName': LastName,
      'Account': Account,
      'email': email,
      'School': School,
      'Grade': Grade,
    };
  }
}
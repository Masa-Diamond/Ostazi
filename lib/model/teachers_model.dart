class TutorrModel{
  String? Uid;
  String? FirstName;
  String? LastName;
  String? Account;
  String? Field;
  String? email;
  String? password;
  String? School;
  String? Rating;
  String? Price;

  TutorrModel({this.Uid, this.FirstName, this.LastName, this.Account, this.Field, this.email,
   this.password, this.School, this.Rating, this.Price});
  
  //recieving data from server
  factory TutorrModel.fromMap(Map<String, dynamic> map){
    return TutorrModel(
      Uid: map['uid'],
      FirstName: map['FirstName'],
      LastName: map['LastName'],
      Account: map['Account'],
      Field: map['Field'],
      email: map['email'],
      School: map['School'],
      Rating: map['Rating'],
      Price: map['Price']
    );
  }
  
  
  //sending data to our server
  Map<String, dynamic> toMap(){
    return{
      'uid': Uid,
      'FirstName': FirstName,
      'LastName': LastName,
      'Account': Account,
      'Field': Field,
      'email': email,
      'School': School,
      'Rating': Rating,
      'Price': Price
    };
  }

  TutorrModel.fromSnapshot(snapshot)
  : Uid = snapshot.data()['uid'],
    FirstName = snapshot.data()['FirstName'],
    LastName = snapshot.data() ['LastName'],
    Account = snapshot.data() ['Account'],
    email = snapshot.data() ['email'],
    School  = snapshot.data() ['School'],
    Rating  = snapshot.data() ['Rating'],
    Price  = snapshot.data() ['Price'],
    Field = snapshot.data() ['Field'];
}
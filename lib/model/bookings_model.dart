class BookingsModel{
  String? uid;
  String? Tutor;
  String? Field;
  String? Date;
  String? StartTime;
  String? EndTime;
  String? Price;
  String? StuAccount;
  String? stuID;

  BookingsModel({this.uid, this.Tutor, this.Field, this.Date, 
  this.StartTime, this.EndTime, this.Price, this.StuAccount, this.stuID});

  //recieving data from server
  factory BookingsModel.fromMap(Map<String, dynamic> map){
    return BookingsModel(
      uid: map['uid'],
      Tutor: map['Tutor'],
      Field: map['Field'],
      Date: map['Date'],
      StartTime: map['startTime'],
      EndTime: map['EndTime'],
      Price: map['Price'],
      StuAccount: map['StuAccount'],
      stuID: map['stuID']
    );
  }

  //sending data to our server
  Map<String, dynamic> toMap(){
    return{
      'uid': uid,
      'Tutor': Tutor,
      'Field': Field,
      'Date': Date,
      'StartTime': StartTime,
      'EndTime': EndTime,
      'Price': Price,
      'StuAccount': StuAccount,
      'stuID': stuID
    };
  }

  BookingsModel.fromSnapshot(snapshot)
  : uid = snapshot.data()['uid'],
    Tutor = snapshot.data()['Tutor'],
    Field = snapshot.data() ['Field'],
    Date = snapshot.data() ['Date'],
    StartTime = snapshot.data() ['StartTime'],
    EndTime = snapshot.data() ['EndTime'],
    Price = snapshot.data() ['Price'],
    StuAccount = snapshot.data() ['StuAccount'],
    stuID = snapshot.data() ['stuID'];
}
class CourseModel{
  String? uid;
  String? Tutor;
  String? Field;
  String? Date;
  String? StartTime;
  String? EndTime;
  String? Price;
  String? Day;

  CourseModel({this.uid, this.Tutor, this.Field, this.Date, 
  this.StartTime, this.EndTime, this.Price, this.Day});

  //recieving data from server
  factory CourseModel.fromMap(Map<String, dynamic> map){
    return CourseModel(
      uid: map['uid'],
      Tutor: map['Tutor'],
      Field: map['Field'],
      Date: map['Date'],
      StartTime: map['startTime'],
      EndTime: map['EndTime'],
      Price: map['Price'],
      Day: map['Day'],
    );
  }

  //sending data to our server
  Map<String, dynamic> toMap(){
    return{
      'uid': uid,
      'Tutor': Tutor,
      'Field': Field,
      'Date': Date,
      'StartTimr': StartTime,
      'EndTime': EndTime,
      'Price': Price,
      'Day': Day
    };
  }

  CourseModel.fromSnapshot(snapshot)
  : uid = snapshot.data()['uid'],
    Tutor = snapshot.data()['Tutor'],
    Field = snapshot.data() ['Field'],
    Date = snapshot.data() ['Date'],
    StartTime = snapshot.data() ['StartTime'],
    EndTime = snapshot.data() ['EndTime'],
    Price = snapshot.data() ['Price'],
    Day = snapshot.data() ['Day'];
}
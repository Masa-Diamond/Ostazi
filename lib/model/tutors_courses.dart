class TutorCoursesModel{
  String? uid; //
  String? Date; //
  String? StartTime; //
  String? EndTime; //
  String? Type;
  String? Field; //
  String? Tutor; //
  String? Repeat;
  String? Color;
  TutorCoursesModel({this.uid, this.Date, this.StartTime, this.EndTime,
   this.Tutor, this.Field, this.Type,
  this.Repeat, this.Color});

  factory TutorCoursesModel.fromMap(Map<String, dynamic> map){
    return TutorCoursesModel(
      uid: map['uid'],
      Tutor: map['Tutor'],
      Field: map['Field'],
      Date: map['Date'],
      StartTime: map['startTime'],
      EndTime: map['EndTime'],
      Type: map['Type'],
      Repeat: map['Repeat'],
      Color: map['color'],
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
      'Type': Type,
      'Repeat': Repeat,
      'Color': Color
    };
  }

  TutorCoursesModel.fromSnapshot(snapshot)
  : uid = snapshot.data()['uid'],
    Tutor = snapshot.data()['Tutor'],
    Field = snapshot.data() ['Field'],
    Date = snapshot.data() ['Date'],
    StartTime = snapshot.data() ['StartTime'],
    EndTime = snapshot.data() ['EndTime'],
    Type = snapshot.data() ['Type'],
    Color = snapshot.data() ['Color'],
    Repeat = snapshot.data() ['Repeat'];
    
}


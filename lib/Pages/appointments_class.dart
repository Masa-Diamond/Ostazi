import 'dart:ui';

class Appointments{
  int id;
  String? Type;
  String? date;
  String? StartTime;
  String? EndTime;
  int Background;
  String? Repeat;
  //bool? EveryDay;
  //bool? EveryWeek;
  //bool? EveryMonth;

  Appointments(this.id,this.Type,this.date,this.StartTime,this.EndTime,this.Background,this.Repeat);
}
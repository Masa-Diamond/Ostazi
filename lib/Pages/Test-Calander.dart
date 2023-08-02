import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
//import 'package:calendar_view/alendar_view.dart';
import 'dart:math';
import 'TutorNavBar.dart';
import 'events_class.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart'; 

class TestCalender extends StatefulWidget {
  const TestCalender({super.key});

  @override 
  State<TestCalender> createState() => _TestCalenderState();
}

class _TestCalenderState extends State<TestCalender> with SingleTickerProviderStateMixin {
 // TabController? _tabController;
 /* @override
  void initState(){
  //  _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 244, 244, 248),
      drawer: TutorNavBar(),
      appBar: AppBar(
        iconTheme: IconThemeData(size:30,color: Color.fromARGB(255, 192, 218, 240)),
        backgroundColor: Color.fromARGB(255, 4, 4, 71),
        title:
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: 250,height: 100,
               decoration: BoxDecoration(
               image: DecorationImage(
               image: AssetImage("assets/images/logo2.png"),
               fit: BoxFit.fitWidth
           ),),
          ),           
          ],),
      ),
      body: SfCalendar(
            view: CalendarView.schedule,
            todayHighlightColor: Color.fromARGB(255, 169, 169, 184),
            cellBorderColor: Color.fromARGB(255, 3, 1, 57),
            backgroundColor: Color.fromARGB(255, 234, 231, 249),
            showNavigationArrow: true,
            allowedViews: const [
              CalendarView.month,
              CalendarView.day,
              CalendarView.week,
              CalendarView.workWeek,
              CalendarView.schedule
            ],
            dataSource: _getCalendarDataSource())
    );
  }
  _AppointmentDataSource _getCalendarDataSource(){
    final List<Appointment> appointments = <Appointment>[];
    final DateTime exceptionDate = DateTime(2021, 04, 14);
    DateTime exceptionDate1 = DateTime(2023, 05, 01);
    appointments.add(Appointment(
        //recurrenceId: 01,
        startTime: DateTime(2023, 01, 15, 16),
        endTime: DateTime(2023, 01, 15, 17),
        subject: 'حجز دائم - محمد احمد',
        color: Color.fromARGB(255,140,14,15),
        recurrenceExceptionDates: <DateTime>[exceptionDate1],
        recurrenceRule: "FREQ=WEEKLY;INTERVAL=1;BYDAY=SU;UNTIL=20230610T183000Z"));

     appointments.add(Appointment(
        //recurrenceId: 01,
        startTime: DateTime(2023, 01, 31, 12),
        endTime: DateTime(2023, 01, 31, 13),
        subject: 'حجز مؤقت - محمد احمد',
        color: Color.fromARGB(255,140,14,15),
        recurrenceExceptionDates: <DateTime>[exceptionDate1],
        recurrenceRule: "FREQ=WEEKLY;INTERVAL=1;BYDAY=SU;UNTIL=20230610T183000Z"));    

    appointments.add(Appointment(
        startTime: DateTime(2023, 01, 26, 14),
        endTime: DateTime(2023, 01, 26, 15),
        subject: 'حجز دائم - ميرا صايمة',
        color: Color.fromARGB(255,71,73,115),
        recurrenceExceptionDates: <DateTime>[exceptionDate1],
        recurrenceRule: "FREQ=WEEKLY;INTERVAL=1;BYDAY=SU;UNTIL=20230610T183000Z"));

         appointments.add(Appointment(
        startTime: DateTime(2023, 01, 31, 19),
        endTime: DateTime(2023, 01, 31, 20),
        subject: 'حجز مؤقت - ميرا صايمة',
        color: Color.fromARGB(255,219,168,88),
        recurrenceExceptionDates: <DateTime>[exceptionDate1],
        //recurrenceRule: "FREQ=WEEKLY;INTERVAL=1;BYDAY=SU;UNTIL=20230610T183000Z"
        )
        );

    /*appointments.add(Appointment(
        startTime: DateTime(2023, 01, 15, 15),
        endTime: DateTime(2023, 01, 15, 16),
        subject: 'حجز دائم - حلمي زهير',
        color: Color.fromARGB(255,219,168,88),
        recurrenceExceptionDates: <DateTime>[exceptionDate1],
        recurrenceRule: "FREQ=WEEKLY;INTERVAL=1;BYDAY=SU;UNTIL=20230610T183000Z")); 

    appointments.add(Appointment(
        //recurrenceId: 01,
        startTime: DateTime(2023, 01, 15, 16),
        endTime: DateTime(2023, 01, 15, 17),
        subject: 'حجز دائم - نايا رمضان',
        color: Color.fromARGB(255,71,73,115),
        recurrenceExceptionDates: <DateTime>[exceptionDate1],
        recurrenceRule: "FREQ=WEEKLY;INTERVAL=1;BYDAY=SU;UNTIL=20230610T183000Z")); 
        
    appointments.add(Appointment(
        //recurrenceId: 01,
        startTime: DateTime(2023, 01, 16, 14),
        endTime: DateTime(2023, 01, 16, 15),
        subject: 'حجز دائم - ليث هاشم',
        color: Color.fromARGB(255,140,14,15),
        recurrenceExceptionDates: <DateTime>[exceptionDate1],
        recurrenceRule: "FREQ=WEEKLY;INTERVAL=1;BYDAY=MO;UNTIL=20230610T183000Z"));          
    
    appointments.add(Appointment(
        startTime: DateTime(2023, 01, 17, 18),
        endTime: DateTime(2023, 01, 17, 19),
        subject: 'حجز مؤقت - لمى هادي',
        color: Color.fromARGB(255,219,168,88),));*/

    appointments.add(Appointment(
        startTime: DateTime(2023, 01, 22, 18),
        endTime: DateTime(2023, 01, 22, 19),
        subject: 'حجز دائم - سعد كامل',
        color: Color.fromARGB(255,71,73,115),));  

    appointments.add(Appointment(
        startTime: DateTime(2023, 01, 31, 20),
        endTime: DateTime(2023, 01, 31, 21),
        subject: 'حجز مؤقت - سعد كامل',
        color: Color.fromARGB(255,71,73,115),));       

   /* appointments.add(Appointment(
        startTime: DateTime(2023, 02, 1, 10),
        endTime: DateTime(2023, 02, 1, 11),
        subject: 'Weekly Meeting',
        color: Colors.brown,
        recurrenceRule: "FREQ=WEEKLY;INTERVAL=1;BYDAY=MO,WE;COUNT=10"));

    appointments.add(Appointment(
        startTime: DateTime(2023, 02, 1, 11),
        endTime: DateTime(2023, 02, 1, 12),
        subject: 'Monthly Meeting',
        color: Colors.indigo,
        recurrenceRule: "FREQ=MONTHLY;BYMONTHDAY=3;INTERVAL=1;COUNT=10"));

    appointments.add(Appointment(
        startTime: DateTime(2023, 02, 1, 10),
        endTime: DateTime(2023, 02, 1, 11),
        subject: 'Yearly Meeting',
        color: Colors.green,
        recurrenceRule:
            "FREQ=YEARLY;BYMONTHDAY=16;BYMONTH=6;INTERVAL=1;COUNT=10"));

    appointments.add(Appointment(
        startTime: DateTime(2023, 12, 16, 10),
        endTime: DateTime(2023, 12, 16, 12),
        subject: 'Meeting',
        color: Colors.blue,
        recurrenceRule: 'FREQ=DAILY;INTERVAL=2;COUNT=10'));

    //DateTime exceptionDate1 = DateTime(2023, 12, 20);
    appointments.add(Appointment(
        startTime: DateTime(2023, 12, 16, 10),
        endTime: DateTime(2023, 12, 16, 12),
        subject: 'Occurs daily',
        color: Colors.red,
        recurrenceRule: 'FREQ=DAILY;COUNT=20',
        recurrenceExceptionDates: <DateTime>[exceptionDate1]));

    final Appointment recurrenceAppointment = Appointment(
      startTime: DateTime(2023, 04, 12, 10),
      endTime: DateTime(2023, 04, 12, 12),
      subject: 'Daily scrum meeting',
      id: '01',
      recurrenceRule: 'FREQ=DAILY;INTERVAL=1;COUNT=10',
      color: Colors.lightGreen,
      recurrenceExceptionDates: <DateTime>[exceptionDate],
    );
    appointments.add(recurrenceAppointment);*/


    return _AppointmentDataSource(appointments);            
  }
}

class _AppointmentDataSource extends CalendarDataSource {
  _AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}
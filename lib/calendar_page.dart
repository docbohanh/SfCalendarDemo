import 'dart:math';
import 'package:calendar_test/sfCalendar/calendar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//ignore: must_be_immutable
class ScheduleCalendarPage extends StatefulWidget {
  ScheduleCalendarPage({this.hasBackButton = true, Key key}) : super(key: key);
  bool hasBackButton;

  @override
  State createState() => _ScheduleCalendarPageState();
}

class _ScheduleCalendarPageState extends State<ScheduleCalendarPage> {
  bool panelOpen;
  final ValueNotifier<bool> frontPanelVisible = ValueNotifier<bool>(true);
  CalendarView _calendarView;
  List<String> subjectCollection;
  List<Color> colorCollection;
  List<Meeting> meetings;
  MeetingDataSource events;

  @override
  void initState() {
    panelOpen = frontPanelVisible.value;
    frontPanelVisible.addListener(_subscribeToValueNotifier);
    _calendarView = CalendarView.week;
    meetings = <Meeting>[];
    addAppointmentDetails();
    events = MeetingDataSource(meetings);
    super.initState();
  }

  void _subscribeToValueNotifier() => panelOpen = frontPanelVisible.value;

  @override
  void didUpdateWidget(ScheduleCalendarPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    frontPanelVisible.removeListener(_subscribeToValueNotifier);
    frontPanelVisible.addListener(_subscribeToValueNotifier);
  }

  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build([BuildContext context]) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Lịch công tác',
        ),
      ),
      body: Container(
        child: getGettingStartedCalendar(
          _calendarView,
          events,
          onViewChanged,
          onCalendarTapped,
        ),
      ),
    );
  }

  void onCalendarTapped(CalendarTapDetails calendarTapDetails) {
    if (calendarTapDetails.targetElement != CalendarElement.calendarCell &&
        calendarTapDetails.targetElement != CalendarElement.appointment) {
      return;
    }

    final Meeting appointment = calendarTapDetails.appointments.first;
    var from = DateFormat('hh:mm a').format(appointment.from).toUpperCase();
    var to = DateFormat('hh:mm a').format(appointment.to).toUpperCase();

    final snackBar = SnackBar(
      content: Container(
        height: 44,
        child: RichText(
          text: TextSpan(
            text: '${appointment.eventName} \n',
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
            children: <TextSpan>[
              TextSpan(
                text: '$from - $to',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
        ),
      ),
      duration: Duration(seconds: 5),
    );

    _scaffoldKey.currentState.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  void onViewChanged(ViewChangedDetails visibleDatesChangedDetails) {
    final List<Meeting> appointment = <Meeting>[];
    events.appointments.clear();
    final Random random = Random();

    for (int i = 0; i < visibleDatesChangedDetails.visibleDates.length; i++) {
      final DateTime date = visibleDatesChangedDetails.visibleDates[i];
      final int count = 1;
      for (int j = 0; j < count; j++) {
        final DateTime startDate = DateTime(
          date.year,
          date.month,
          date.day,
          8 + random.nextInt(8),
          random.nextInt(30),
          random.nextInt(60),
        );
        appointment.add(
          Meeting(
            subjectCollection[random.nextInt(7)],
            '',
            '',
            null,
            startDate,
            startDate.add(Duration(hours: 2 + random.nextInt(5))),
            colorCollection[random.nextInt(colorCollection.length - 1)],
            false,
            '',
            '',
          ),
        );
      }
    }

    events.appointments.addAll(appointment);

    events.notifyListeners(CalendarDataSourceAction.reset, appointment);
  }

  void addAppointmentDetails() {
    subjectCollection = <String>[];
    subjectCollection.add('General Meeting');
    subjectCollection.add('Plan Execution');
    subjectCollection.add('Project Plan');
    subjectCollection.add('Consulting');
    subjectCollection.add('Support');
    subjectCollection.add('Development Meeting');
    subjectCollection.add('Scrum');
    subjectCollection.add('Project Completion');
    subjectCollection.add('Release updates');
    subjectCollection.add('Performance Check');

    colorCollection = <Color>[];
    colorCollection.add(const Color(0xFF0F8644));
    colorCollection.add(const Color(0xFF8B1FA9));
    colorCollection.add(const Color(0xFFD20100));
    colorCollection.add(const Color(0xFFFC571D));
    colorCollection.add(const Color(0xFF36B37B));
    colorCollection.add(const Color(0xFF01A1EF));
    colorCollection.add(const Color(0xFF3D4FB5));
    colorCollection.add(const Color(0xFFE47C73));
    colorCollection.add(const Color(0xFF0A8043));
  }
}

SfCalendar getGettingStartedCalendar(
    [CalendarView _calendarView,
    CalendarDataSource _calendarDataSource,
    ViewChangedCallback viewChangedCallback,
    CalendarTapCallback calendarTapCallback]) {
  return SfCalendar(
    view: _calendarView,
    dataSource: _calendarDataSource,
    onViewChanged: viewChangedCallback,
    onTap: calendarTapCallback,
    monthViewSettings: MonthViewSettings(
      appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
    ),
    timeSlotViewSettings: TimeSlotViewSettings(
      minimumAppointmentDuration: const Duration(minutes: 60),
    ),
  );
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(this.source);

  List<Meeting> source;

  @override
  List<dynamic> get appointments => source;

  @override
  DateTime getStartTime(int index) {
    return source[index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return source[index].to;
  }

  @override
  bool isAllDay(int index) {
    return source[index].isAllDay;
  }

  @override
  String getSubject(int index) {
    return source[index].eventName;
  }

  @override
  String getStartTimeZone(int index) {
    return source[index].startTimeZone;
  }

  @override
  String getEndTimeZone(int index) {
    return source[index].endTimeZone;
  }

  @override
  Color getColor(int index) {
    return source[index].background;
  }
}

class Meeting {
  Meeting(
      this.eventName,
      this.organizer,
      this.contactID,
      this.capacity,
      this.from,
      this.to,
      this.background,
      this.isAllDay,
      this.startTimeZone,
      this.endTimeZone);

  String eventName;
  String organizer;
  String contactID;
  int capacity;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
  String startTimeZone;
  String endTimeZone;
}

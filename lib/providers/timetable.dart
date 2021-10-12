import 'package:flutter/material.dart';

class ClassData {
  String className;
  String classroom = '0000';

  ClassData(this.className);

  void setClassroom(String room) {
    classroom = room;
  }
}

// class TimeTabelData{
//   List<dynamic> timetable = [0,0,0,0,0];
// }

enum DayOfWeek {
  Mon,
  Tue,
  Wed,
  Thu,
  Fry,
}

class TimeTable with ChangeNotifier {
  //Map<String, List<0 or ClassData> >
  Map<DayOfWeek, List<dynamic>> _timetable = {
    DayOfWeek.Mon: [0, 0, 0, 0, 0],
    DayOfWeek.Tue: [0, 0, 0, 0, 0],
    DayOfWeek.Wed: [0, 0, 0, 0, 0],
    DayOfWeek.Thu: [0, 0, 0, 0, 0],
    DayOfWeek.Fry: [0, 0, 0, 0, 0],
  };

  Map<DayOfWeek, List<dynamic>> timetable() {
    return _timetable;
  }

  void setTimetable(DayOfWeek day, List<dynamic> newTimeTable) {
    _timetable[day] = newTimeTable;
    notifyListeners();
  }
}

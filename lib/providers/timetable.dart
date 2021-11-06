import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

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

  var database;

  TimeTable() {
    database = openTimeTableDatabase();
  }

  Map<DayOfWeek, List<dynamic>> timetable() {
    return _timetable;
  }

  void setTimetable(DayOfWeek day, List<dynamic> newTimeTable) {
    _timetable[day] = newTimeTable;
    notifyListeners();
  }

  //データベースに接続
  Future<Database> openTimeTableDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'timetable_databese.db'),
    );
  }

  Future<void> insertTimeable(DayOfWeek day, List<dynamic> newTT) {
    return Future.delayed(Duration.zero);
  }
}

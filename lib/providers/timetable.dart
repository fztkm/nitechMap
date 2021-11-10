import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ClassData {
  String className;
  String classroom = '0000';

  ClassData(this.className);
  ClassData.setRoom(this.className, this.classroom);

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

int _dayOfWeekToInt(DayOfWeek day) {
  switch (day) {
    case DayOfWeek.Mon:
      return 0;
    case DayOfWeek.Tue:
      return 1;
    case DayOfWeek.Wed:
      return 2;
    case DayOfWeek.Thu:
      return 3;
    case DayOfWeek.Fry:
      return 4;
  }
}

DayOfWeek? _intToDayOfWeek(int day) {
  switch (day) {
    case 0:
      return DayOfWeek.Mon;
    case 1:
      return DayOfWeek.Tue;
    case 2:
      return DayOfWeek.Wed;
    case 3:
      return DayOfWeek.Thu;
    case 4:
      return DayOfWeek.Fry;
    default:
      return null;
  }
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

  Map<DayOfWeek, List<dynamic>> timetable() {
    return _timetable;
  }

  void setTimetable(DayOfWeek day, List<dynamic> newTimeTable) {
    _timetable[day] = newTimeTable;
    notifyListeners();
  }

  //一番最初にやる。データベースに接続する
  Future<void> getinitDatabase() async {
    database = await openTimeTableDatabase();
  }

  //データベースに接続 getinitDatabaseでdatabase変数に代入する
  Future<Database> openTimeTableDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'timetable_databese.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE timetable(day INTEGER, time INTEGER, name TEXT, room TEXT)",
        );
      },
      version: 1,
    );
  }

  //データベースに挿入
  Future<void> insertTimeable(DayOfWeek day, List<dynamic> newTT) async {
    final Database db = await database;
    int dayInt = _dayOfWeekToInt(day);
    for (int i = 0; i < 5; i++) {
      await db.insert(
        'timetable',
        timeTableListPerDoWToMap(dayInt, i, newTT),
        conflictAlgorithm: ConflictAlgorithm.replace, //上書きする
      );
    }
  }

  //n DayOfWeekを整数にして渡す
  Map<String, dynamic> timeTableListPerDoWToMap(
      int day, int time, List<dynamic> tt) {
    return {
      "day": day,
      "time": time,
      "name": tt[time] == 0 ? 0 : (tt[time] as ClassData).className,
      "room": tt[time] == 0 ? 0 : (tt[time] as ClassData).classroom,
    };
  }

  //全データをセット 授業単位で作られたmapのリスト keys= {"day", "time", "name", "room"}
  void setAllData(List<Map<String, dynamic>> maps) {
    maps.forEach((table) {
      int day = int.parse(table["day"]);
      int time = int.parse(table["time"]);
      var classDataOrZero;
      if (table["name"] != 0 && table["room"] != 0) {
        classDataOrZero = ClassData.setRoom(table["name"], table["room"]);
      } else {
        classDataOrZero = 0;
      }
      _timetable[_intToDayOfWeek(day)]![time] = classDataOrZero;
    });
  }

  //データの取得
  Future<TimeTable> getTimeTable() async {
    final List<Map<String, dynamic>> maps = await database.query("timetable");
    TimeTable fetchedTimeTable = TimeTable();
    fetchedTimeTable.setAllData(maps);
    return fetchedTimeTable;
  }
}

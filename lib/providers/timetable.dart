import 'package:flutter/material.dart';
import 'package:nitechmap_c0de/materials/dayOfWeek.dart';
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

class TimeTable with ChangeNotifier {
  //Map<String, List<0 or ClassData> >
  Map<DayOfWeek, List<dynamic>> _timetable = {
    DayOfWeek.Mon: [0, 0, 0, 0, 0],
    DayOfWeek.Tue: [0, 0, 0, 0, 0],
    DayOfWeek.Wed: [0, 0, 0, 0, 0],
    DayOfWeek.Thu: [0, 0, 0, 0, 0],
    DayOfWeek.Fri: [0, 0, 0, 0, 0],
  };

  var database;

  Map<DayOfWeek, List<dynamic>> timetable() {
    return _timetable;
  }

  void setTimetable(DayOfWeek day, List<dynamic> newTimeTable) {
    _timetable[day] = newTimeTable;
    notifyListeners();
    //データベースに保存
    getinitDatabase().then((_) => insertTimeable(day, newTimeTable));
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
          "CREATE TABLE timetable(id INTEGER PRIMARY KEY,day INTEGER, time INTEGER, name TEXT, room TEXT)",
        );
      },
      version: 1,
    );
  }

  //データベースに挿入
  Future<void> insertTimeable(DayOfWeek day, List<dynamic> newTT) async {
    final Database db = await database;
    int dayInt = dayOfWeekToInt(day);
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
      "id" : day*10 + time,
      "day": day,
      "time": time,
      "name": tt[time] == 0 ? 0 : (tt[time] as ClassData).className,
      "room": tt[time] == 0 ? 0 : (tt[time] as ClassData).classroom,
    };
  }

  //全データをセット 授業単位で作られたmapのリスト keys= {"day", "time", "name", "room"}
  void setAllData(List<Map<String, dynamic>> maps) {
    maps.forEach((table) {
      int day = table["day"];
      int time = table["time"];
      var classDataOrZero;
      print("table[name] :" + table["name"]);
      if (table["name"] == "0") {
        classDataOrZero = 0;
      } else {
        classDataOrZero = ClassData.setRoom(table["name"], table["room"]);
      }
      _timetable[intToDayOfWeek(day)]![time] = classDataOrZero;
    });
  }

  //データの取得
  Future<void> getTimeTable() async {
    final List<Map<String, dynamic>> maps = await database.query("timetable");
    this.setAllData(maps);
  }

  //データの取得の一連
  Future<void> getInitAndGetTimeTable() async {
    await getinitDatabase().then((_) => getTimeTable());
    notifyListeners();
  }
}

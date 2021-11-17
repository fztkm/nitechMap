import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:nitechmap_c0de/providers/timetable.dart';
import 'package:provider/provider.dart';

class NextClassData {
  DateTime now = DateTime.now();
  int _thisClassIdx = 0; //今何コマ目か　存在しないときは０
  int _nextClassIdx = 0; //次何コマ目か　存在しないときは０

  TimeTable? timeTable;

  NextClassData(BuildContext context) {
    timeTable = Provider.of<TimeTable>(context, listen: false);
    print("コンストラクタ");
    setThisClassIdx();
    setNextClassIdx();
  }

  Future<void> setTimeTableFromDB() async {
    await timeTable!.getInitAndGetTimeTable();
  }

  bool beforeTime(int hour, int minute) {
    DateTime time = DateTime(now.year, now.month, now.day, hour, minute);
    return now.isBefore(time);
  }

  String getToday() {
    return DateFormat.Md().format(now);
  }

  int getThisClassIdx() {
    return _thisClassIdx;
  }

  int getNextClassIdx() {
    return _nextClassIdx;
  }

  //今何コマ目か
  //
  void setThisClassIdx() {
    //平日かどうか　休日なら0
    if (getDayOfWeek() is DayOfWeek) {
      if (beforeTime(10, 20)) {
        _thisClassIdx = 1;
      } else if (beforeTime(12, 00)) {
        _thisClassIdx = 2;
      } else if (beforeTime(14, 30)) {
        _thisClassIdx = 3;
      } else if (beforeTime(16, 10)) {
        _thisClassIdx = 4;
      } else if (beforeTime(17, 50)) {
        _thisClassIdx = 5;
      } else {
        //テストのために２にセット
        print("_thisClassIdx : set Test Index 2");
        _thisClassIdx = 2;
      }
    } else {
      _thisClassIdx = 0; //土曜・日曜は0
    }
    print("_thisClassIdx = " + _thisClassIdx.toString());
  }

  //次何コマ目か
  void setNextClassIdx() {
    /*To-Do 土曜日曜は0
    朝早くは、１コマ目を指定
    それ以外(thisClassIdx !₌ 0)ならthisClassIdx + 1を代入
    */
    if (_thisClassIdx == 5) {
      _nextClassIdx = 0;
    } else if (_thisClassIdx != 0) {
      _nextClassIdx = _thisClassIdx + 1;
    }
    print("_nextClassIdx = " + _nextClassIdx.toString());
  }

  //曜日取得
  DayOfWeek? getDayOfWeek() {
    // int index = now.weekday; //Mon = 1, max7
    int index = now.weekday;
    switch (index) {
      case 1:
        print('Today is Mon');
        return DayOfWeek.Mon;
      case 2:
        print('Today is Tue');
        return DayOfWeek.Tue;
      case 3:
        print('Today is Tue');
        return DayOfWeek.Wed;
      case 4:
        print('Today is Tue');
        return DayOfWeek.Thu;
      case 5:
        print('Today is Tue');
        return DayOfWeek.Fry;
      default:
        print('Today is Holiday');
        return null;
    }
  }

  //今のクラスの名前と講義室名
  List<String> getThisClassData() {
    List<String> result = ["なし", "0000"];
    DayOfWeek? dofw = getDayOfWeek();
    if (dofw != null && _thisClassIdx >= 1) {
      final classData = timeTable!
          .timetable()[dofw]![_thisClassIdx - 1]; //0かClassData // １コマ目のidx=0
      if (classData is ClassData) {
        if (classData.className != "" && classData.classroom != "") {
          result[0] = classData.className;
          result[1] = classData.classroom;
        }
        print("now : " + result.toString());
      }
    }
    return result;
  }

  //次のクラスの名前と講義室名
  List<String> getNextClassData() {
    List<String> result = ["なし", "0000"];
    DayOfWeek? dofw = getDayOfWeek();
    if (dofw != null && _nextClassIdx >= 1) {
      final classData =
          timeTable!.timetable()[dofw]![_nextClassIdx - 1]; //0かClassData
      if (classData is ClassData) {
        result[0] = classData.className;
        result[1] = classData.classroom;
        print("next : " + result.toString());
      }
    }
    return result;
  }
}

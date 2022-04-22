import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:nitechmap_c0de/providers/timetable.dart';
import 'package:provider/provider.dart';

import 'dayOfWeek.dart';

class NextClassData {
  DateTime now = DateTime.now();
  int _thisClassIdx = 0; //今何コマ目か　存在しないときは０
  int _nextClassIdx = 0; //次何コマ目か　存在しないときは０

  TimeTable? timeTable;

  NextClassData(BuildContext context) {
    timeTable = Provider.of<TimeTable>(context, listen: false);
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

  //setTimeTableFromDBのあとに実行
  //メモ画面に遷移するために、classdataのidを渡す
  //ただし、講義が連結している場合は、最初のコマの講義のidを渡すことに注意
  int? thisClassParentIdForMemoScreen() {
    DayOfWeek? dow = intToDayOfWeekForIntl(now.weekday);
    if (_thisClassIdx >= 1) {
      if (dow is DayOfWeek) {
        if (timeTable != null) {
          var index = _thisClassIdx - 1;
          var thisData = timeTable!.classDataByDayAndTime(dow, index);
          int? id = thisData is ClassData ? thisData.id() : null;
          if (index == 0) return id;
          var prevData = timeTable!.classDataByDayAndTime(dow, index - 1);
          while (thisData is ClassData &&
              prevData is ClassData &&
              thisData.className == prevData.className) {
            id = prevData.id();
            if (index <= 1) break;
            index -= 1;
            prevData = timeTable!.classDataByDayAndTime(dow, index - 1);
          }
          return id;
        }
      }
    }
    return null;
  }

  //setTimeTableFromDBのあとに実行
  //メモ画面に遷移するために、classdataのidを渡す
  //ただし、講義が連結している場合は、最初のコマの講義のidを渡すことに注意
  int? nextClassParentIdForMemoScreen() {
    DayOfWeek? dow = intToDayOfWeekForIntl(now.weekday);
    if (_nextClassIdx >= 1) {
      if (dow is DayOfWeek) {
        if (timeTable != null) {
          var index = _nextClassIdx - 1;
          var thisData = timeTable!.classDataByDayAndTime(dow, index);
          int? id = thisData is ClassData ? thisData.id() : null;
          if (index == 0) return id;
          var prevData = timeTable!.classDataByDayAndTime(dow, index - 1);
          while (thisData is ClassData &&
              prevData is ClassData &&
              thisData.className == prevData.className) {
            id = prevData.id();
            if (index <= 1) break;
            index -= 1;
            prevData = timeTable!.classDataByDayAndTime(dow, index - 1);
          }
          return id;
        }
      }
    }
    return null;
  }

  //今何コマ目か
  //休日の場合は常に0
  void setThisClassIdx() {
    //平日かどうか
    if (intToDayOfWeekForIntl(now.weekday) is DayOfWeek) {
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
        //テストのために２にセット //本番用に0にしました。2021-12-16
        print("_thisClassIdx : set Test Index 2");
        _thisClassIdx = 0;
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

  //今のクラスの名前と講義室名
  List<String> getThisClassData() {
    List<String> result = ["no data", "0000"];
    DayOfWeek? dofw = intToDayOfWeekForIntl(now.weekday);
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
    List<String> result = ["no data", "0000"];
    DayOfWeek? dofw = intToDayOfWeekForIntl(now.weekday);
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

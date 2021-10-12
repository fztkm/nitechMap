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
    setThisClassIdx();
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
    if (getDayOfWeek() is DayOfWeek) {
      //TODO: 時間ごとにコマ数割り当てる。1コマ目＝１
      _thisClassIdx = 3;
    } else {
      _thisClassIdx = 0; //土曜・日曜は0
    }
  }

  //次何コマ目か
  void setNextClassIdx() {
    /*To-Do 土曜日曜は0
    朝早くは、１コマ目を指定
    それ以外(thisClassIdx !₌ 0)ならthisClassIdx + 1を代入
    */
    _nextClassIdx = 0; //セットしよう
  }

  //曜日取得
  DayOfWeek? getDayOfWeek() {
    // int index = now.weekday; //Mon = 1, max7
    int index = 1;
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
    print("1段目");
    if (dofw != null && _thisClassIdx >= 1) {
      print('2段目までokです');
      final classData = timeTable!
          .timetable[dofw]![_thisClassIdx - 1]; //0かClassData // １コマ目のidx=0
      if (classData is ClassData) {
        result[0] = classData.className;
        result[1] = classData.classroom;
        print(result);
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
          timeTable!.timetable[dofw]![_nextClassIdx + 1]; //0かClassData
      if (classData is ClassData) {
        result[0] = classData.className;
        result[1] = classData.classroom;
      }
    }
    return result;
  }
}

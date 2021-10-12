import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nitechmap_c0de/providers/timetable.dart';
import 'package:nitechmap_c0de/widgets/InputListTile.dart';
import 'package:provider/provider.dart';

class EditTimeTableScreen extends StatefulWidget {
  static const routeName = '/edit_timetable_screen';

  @override
  _EditTimeTableScreenState createState() => _EditTimeTableScreenState();
}

class _EditTimeTableScreenState extends State<EditTimeTableScreen> {
  DayOfWeek _dayOfWeek = DayOfWeek.Mon;

  var optionsDOW = ['Mon', 'Tue', 'Wed', 'Thu', 'Fry'];

  // DayOfWeek dayOfWeek(String value) {
  //   switch (value) {
  //     case 'Mon':
  //       return DayOfWeek.Mon;
  //     case 'Tue':
  //       return DayOfWeek.Tue;
  //     case 'Wed':
  //       return DayOfWeek.Wed;
  //     case 'Thu':
  //       return DayOfWeek.Thu;
  //     case 'Fry':
  //       return DayOfWeek.Fry;
  //     default:
  //       return DayOfWeek.Mon;
  //   }
  // }

  //Provider で　TimeTable()を取得。initialValueを渡す必要あり

  List<dynamic> timeTableDate = [0, 0, 0, 0, 0];
  TimeTable? tt;
  bool initialized = false;
  final _form = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    if (!initialized) {
      tt = Provider.of<TimeTable>(context, listen: false);
      final routeArg = ModalRoute.of(context)!.settings.arguments;
      switch (routeArg as int) {
        case 0:
          timeTableDate = tt!.timetable[DayOfWeek.Mon] as List<dynamic>;
          _dayOfWeek = DayOfWeek.Mon;
          break;
        case 1:
          timeTableDate = tt!.timetable[DayOfWeek.Tue] as List<dynamic>;
          _dayOfWeek = DayOfWeek.Tue;
          break;
        case 2:
          timeTableDate = tt!.timetable[DayOfWeek.Wed] as List<dynamic>;
          _dayOfWeek = DayOfWeek.Wed;
          break;
        case 3:
          timeTableDate = tt!.timetable[DayOfWeek.Thu] as List<dynamic>;
          _dayOfWeek = DayOfWeek.Thu;
          break;
        case 4:
          timeTableDate = tt!.timetable[DayOfWeek.Fry] as List<dynamic>;
          _dayOfWeek = DayOfWeek.Fry;
          break;
      }
      initialized = true;
    }
    super.didChangeDependencies();
  }

  void _saveTimeTable() {
    print('おおーい');
    print(timeTableDate);
    // final valid = _form.currentState!.validate();
    // if (!valid) {
    //   print('ここまで０ｋ');
    //   return;
    // }
    _form.currentState!.save(); //onSavedをトリガー
    Provider.of<TimeTable>(context, listen: false)
        .setTimetable(_dayOfWeek, timeTableDate);
    Navigator.of(context).pop();
  }

  //以下の二つの関数はInputListTileに渡して使う
  //InputListTileからtimeTableDataに代入
  void setClassName(int classTime, String? value) {
    if (value != null && value != '' && value.isNotEmpty) {
      print(value);
      timeTableDate[classTime - 1] = ClassData(value);
    } else {
      timeTableDate[classTime - 1] = 0;
    }
  }

  void setClassroom(int classTime, String? value) {
    if (timeTableDate[classTime - 1] is ClassData) {
      timeTableDate[classTime - 1].setClassroom(value);
    }
  }

  void setInitialData() {
    //曜日に応じた以前のClassDataのリストを格納
    setState(() {
      timeTableDate = tt!.timetable[_dayOfWeek] as List<dynamic>;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit - ' + describeEnum(_dayOfWeek)),
        actions: [
          TextButton.icon(
              onPressed: _saveTimeTable,
              icon: Icon(
                Icons.save,
                color: Colors.white,
              ),
              label: Text(
                'Save',
                style: TextStyle(color: Colors.white),
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _form,
          autovalidate: true,
          child: ListView(
            children: [
              InputListTile(
                classTime: 1,
                setClassName: setClassName,
                setClassroom: setClassroom,
                initialData: timeTableDate,
              ),
              Divider(
                thickness: 1,
              ),
              InputListTile(
                classTime: 2,
                setClassName: setClassName,
                setClassroom: setClassroom,
                initialData: timeTableDate,
              ),
              Divider(
                thickness: 1,
              ),
              InputListTile(
                classTime: 3,
                setClassName: setClassName,
                setClassroom: setClassroom,
                initialData: timeTableDate,
              ),
              Divider(
                thickness: 1,
              ),
              InputListTile(
                classTime: 4,
                setClassName: setClassName,
                setClassroom: setClassroom,
                initialData: timeTableDate,
              ),
              Divider(
                thickness: 1,
              ),
              InputListTile(
                classTime: 5,
                setClassName: setClassName,
                setClassroom: setClassroom,
                initialData: timeTableDate,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

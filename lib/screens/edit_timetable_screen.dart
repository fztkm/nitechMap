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
  var _dayOfWeek = '月曜';

  var optionsDOW = ['月曜', '火曜', '水曜', '木曜', '金曜'];

  DayOfWeek dayOfWeek() {
    switch (_dayOfWeek) {
      case '月曜':
        return DayOfWeek.Mon;
      case '火曜':
        return DayOfWeek.Tue;
      case '水曜':
        return DayOfWeek.Wed;
      case '木曜':
        return DayOfWeek.Thu;
      case '金曜':
        return DayOfWeek.Fry;
      default:
        return DayOfWeek.Mon;
    }
  }

  List<dynamic> timeTableDate = [0, 0, 0, 0, 0];

  final _form = GlobalKey<FormState>();
  //ToDo provider<TimeTable>を取得して、saveで値を変更する.

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
        .setTimetable(dayOfWeek(), timeTableDate);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('時間割編集'),
        actions: [
          IconButton(
            onPressed: _saveTimeTable,
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _form,
          autovalidate: true,
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('曜日'),
                  SizedBox(
                    width: 20,
                  ),
                  DropdownButton<String>(
                    value: _dayOfWeek,
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 30,
                    elevation: 16,
                    style: TextStyle(fontSize: 20, color: Colors.black),
                    underline: Container(
                      height: 2,
                      color: Colors.grey,
                    ),
                    onChanged: (newValue) {
                      setState(() {
                        _dayOfWeek = newValue as String;
                      });
                    },
                    items: optionsDOW
                        .map<DropdownMenuItem<String>>((e) =>
                            DropdownMenuItem<String>(value: e, child: Text(e)))
                        .toList(),
                  ),
                ],
              ),
              InputListTile(
                classTime: 1,
                setClassName: setClassName,
                setClassroom: setClassroom,
              ),
              Divider(
                thickness: 1,
              ),
              InputListTile(
                classTime: 2,
                setClassName: setClassName,
                setClassroom: setClassroom,
              ),
              Divider(
                thickness: 1,
              ),
              InputListTile(
                classTime: 3,
                setClassName: setClassName,
                setClassroom: setClassroom,
              ),
              Divider(
                thickness: 1,
              ),
              InputListTile(
                classTime: 4,
                setClassName: setClassName,
                setClassroom: setClassroom,
              ),
              Divider(
                thickness: 1,
              ),
              InputListTile(
                classTime: 5,
                setClassName: setClassName,
                setClassroom: setClassroom,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

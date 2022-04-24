import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nitechmap_c0de/materials/dayOfWeek.dart';
import 'package:nitechmap_c0de/providers/timetable.dart';
import 'package:nitechmap_c0de/widgets/InputListTile.dart';
import 'package:provider/provider.dart';

class EditTimeTableScreen extends StatefulWidget {
  static const routeName = '/edit_timetable_screen';

  @override
  _EditTimeTableScreenState createState() => _EditTimeTableScreenState();
}

class _EditTimeTableScreenState extends State<EditTimeTableScreen> {
  DayOfWeek _dayOfWeek = DayOfWeek.Monday;

  static const optionsDOW = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'];

  //Provider で　TimeTable()を取得。initialValueを渡す必要あり

  List<List<dynamic>> timeTableDate = [
    [0, 0],
    [0, 0],
    [0, 0],
    [0, 0],
    [0, 0]
  ];
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
          _dayOfWeek = DayOfWeek.Monday;
          break;
        case 1:
          _dayOfWeek = DayOfWeek.Tuesday;
          break;
        case 2:
          _dayOfWeek = DayOfWeek.Wednesday;
          break;
        case 3:
          _dayOfWeek = DayOfWeek.Thursday;
          break;
        case 4:
          _dayOfWeek = DayOfWeek.Friday;
          break;
      }
      setInitialData();
      initialized = true;
    }
    super.didChangeDependencies();
  }

  void _saveTimeTable() {
    print(timeTableDate);
    // _form.currentState!.save(); //onSavedをトリガー
    List<dynamic> resultList = [0, 0, 0, 0, 0];
    timeTableDate.asMap().forEach((i, value) {
      if (value[0] != 0) {
        resultList[i] = ClassData(value[0] as String);
        if (value[1] != 0) (resultList[i] as ClassData).setClassroom(value[1]);
      }
    });
    Provider.of<TimeTable>(context, listen: false)
        .setTimetable(_dayOfWeek, resultList);
    Navigator.of(context).pop();
  }

  //以下の二つの関数はInputListTileに渡して使う
  //InputListTileからtimeTableDataに代入
  void setClassName(int classTime, String? value) {
    if (value != null && value != '' && value.isNotEmpty) {
      print(value);
      timeTableDate[classTime - 1][0] = value;
    } else {
      timeTableDate[classTime - 1][0] = 0;
    }
  }

  void setClassroom(int classTime, String? value) {
    if (value != null) {
      timeTableDate[classTime - 1][1] = value;
    }
  }

  void setInitialData() {
    //曜日に応じた以前のClassDataのリストを格納
    setState(() {
      final ttData = tt!.timetable()[_dayOfWeek] as List<dynamic>;
      ttData.asMap().forEach((i, value) {
        if (value is ClassData) {
          timeTableDate[i][0] = value.className;
          timeTableDate[i][1] = value.classroom;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.brown),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'Edit - ' + describeEnum(_dayOfWeek),
          style: const TextStyle(
            color: Colors.brown,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          TextButton.icon(
              onPressed: _saveTimeTable,
              icon: const Icon(
                Icons.save,
                color: Colors.brown,
              ),
              label: const Text(
                '保存  ',
                style:
                    TextStyle(color: Colors.brown, fontWeight: FontWeight.w500),
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Form(
          key: _form,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            children: [
              Container(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  style: TextButton.styleFrom(primary: Colors.brown),
                  label: Text(
                    "講義室番号とは",
                    style: TextStyle(color: Colors.grey),
                  ),
                  icon: Icon(
                    Icons.info,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          title: const Text("講義室番号とは"),
                          content: const Text(
                              '''講義室番号には時間割表に記載されている講義室名（黒の数字）を半角で入力してください。\n
＊一部数字でない講義室名もありますがそのまま入力して下さい。\n
（例：5224, 4-409, 講堂2階ラーニングコモンズ）'''),
                          actions: [
                            TextButton(
                              child: const Text("OK"),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
              InputListTile(
                classTime: 1,
                setClassName: setClassName,
                setClassroom: setClassroom,
                initialData: timeTableDate,
              ),
              const Divider(
                thickness: 1,
              ),
              InputListTile(
                classTime: 2,
                setClassName: setClassName,
                setClassroom: setClassroom,
                initialData: timeTableDate,
              ),
              const Divider(
                thickness: 1,
              ),
              InputListTile(
                classTime: 3,
                setClassName: setClassName,
                setClassroom: setClassroom,
                initialData: timeTableDate,
              ),
              const Divider(
                thickness: 1,
              ),
              InputListTile(
                classTime: 4,
                setClassName: setClassName,
                setClassroom: setClassroom,
                initialData: timeTableDate,
              ),
              const Divider(
                thickness: 1,
              ),
              InputListTile(
                classTime: 5,
                setClassName: setClassName,
                setClassroom: setClassroom,
                initialData: timeTableDate,
              ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

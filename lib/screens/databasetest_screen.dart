import 'package:flutter/material.dart';
import 'package:nitechmap_c0de/materials/dayOfWeek.dart';
import 'package:nitechmap_c0de/providers/timetable.dart';
import 'package:provider/provider.dart';

class DatabaseTestScreen extends StatefulWidget {
  const DatabaseTestScreen({Key? key}) : super(key: key);
  static const id = "databasetest";

  @override
  _DatabaseTestScreenState createState() => _DatabaseTestScreenState();
}

class _DatabaseTestScreenState extends State<DatabaseTestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              child: Text("データ挿入"),
              onPressed: () {
                TimeTable tt = TimeTable();
                List<dynamic> newTT = [
                  0,
                  0,
                  ClassData.setRoom("テスト", "1200"),
                  ClassData.setRoom("tesuting", "5331"),
                  0,
                ];
                tt.setTimetable(DayOfWeek.Monday, newTT);
              },
            ),
            TextButton(
                child: Text("データ取得"),
                onPressed: () async {
                  TimeTable data = Provider.of<TimeTable>(context);
                  await data.getInitAndGetTimeTable();
                  print(data);
                  print(data.timetable()[DayOfWeek.Monday]);
                  for (int i = 0; i < 5; i++) {
                    print((data.timetable()[DayOfWeek.Monday]![i] as ClassData)
                        .className);
                  }
                })
          ],
        ),
      ),
    );
  }
}

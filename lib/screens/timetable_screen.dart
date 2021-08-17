import 'package:flutter/material.dart';

class TimeTableScreen extends StatelessWidget {
  static String id = 'timetabele_screen';
  const TimeTableScreen({Key? key}) : super(key: key);

  static var weekdays = ['月', '火', '水', '木', '金'];

  List<Expanded> classroomCards() {
    return List.generate(
      5,
      (i) => Expanded(
        flex: 3,
        child: Card(
          margin: EdgeInsets.symmetric(vertical: 15, horizontal: 3),
          child: Column(children: [
            Text('微積'),
            Text('0221'),
          ]),
        ),
      ),
    );
  }

  List<Expanded> tiles(List<Expanded> classrooms, BuildContext context) {
    return List.generate(5, (index) {
      return Expanded(
        child: Row(children: [
          Card(
            child: Text(
              weekdays[index],
            ),
          ),
          ...classrooms,
        ]),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('時間割'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ...tiles(classroomCards(), context),
        ],
      ),
    );
  }
}

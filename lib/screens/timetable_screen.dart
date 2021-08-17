import 'package:flutter/material.dart';

class TimeTableScreen extends StatelessWidget {
  static String id = 'timetabele_screen';
  static var weekdays = ['月', '火', '水', '木', '金'];

  var timeTabel = ['微積', '線形代数', 'プログラミング', 'コンピュータアーキテクチャ', 'abc'];

  List<Expanded> classroomCards() {
    return List.generate(
      5,
      (index) => Expanded(
        flex: 3,
        child: Card(
          margin: EdgeInsets.symmetric(vertical: 15, horizontal: 3),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(timeTabel[index]),
              SizedBox(height: 10),
              Text('0221'),
            ],
          ),
        ),
      ),
    );
  }

  List<Expanded> tiles(List<Expanded> classrooms, BuildContext context) {
    return List.generate(5, (index) {
      return Expanded(
        child: Row(children: [
          SizedBox(width: 5),
          Container(
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: TextButton.icon(
              onPressed: () {},
              icon: Icon(
                Icons.edit,
                color: Colors.white,
              ),
              label: Text(
                'Edit',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
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

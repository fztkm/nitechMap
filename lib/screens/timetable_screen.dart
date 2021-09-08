import 'package:flutter/material.dart';
import 'package:nitechmap_c0de/screens/edit_timetable_screen.dart';
import 'package:nitechmap_c0de/widgets/main_drawer.dart';
import '../widgets/edit_card.dart';

class TimeTableScreen extends StatelessWidget {
  static String id = 'timetabele_screen';
  static var weekdays = ['月', '火', '水', '木', '金'];

  final timeTabel = ['微積', '線形代数', 'プログラミング', 'コンピュータアーキテクチャ', 'abc'];

  void startEditing(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (cx) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.8,
          child: EditCard(),
        );
      },
    );
  }

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
    AppBar appBar = AppBar(
      title: Text('時間割'),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: TextButton.icon(
            onPressed: () {
              // startEditing(context);
              Navigator.of(context).pushNamed(EditTimeTableScreen.routeName);
            },
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
    );
    return Scaffold(
      appBar: appBar,
      drawer: MainDrawer(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8),
          height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ...tiles(classroomCards(), context),
            ],
          ),
        ),
      ),
    );
  }
}

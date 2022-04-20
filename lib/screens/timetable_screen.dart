import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nitechmap_c0de/materials/dayOfWeek.dart';
import 'package:nitechmap_c0de/providers/timetable.dart';
import 'package:nitechmap_c0de/screens/edit_timetable_screen.dart';
import 'package:nitechmap_c0de/screens/memo_screen.dart';
import 'package:nitechmap_c0de/widgets/main_drawer.dart';
import '../widgets/edit_card.dart';
import 'package:provider/provider.dart';

import 'map_screen.dart';

class TimeTableScreen extends StatelessWidget {
  static const String id = 'timetabele_screen';
  static const weekdays = ['月', '火', '水', '木', '金'];
  static const list = [
    ['M', 'o', 'n'],
    ['T', 'u', 'e'],
    ['W', 'e', 'd'],
    ['T', 'h', 'u'],
    ['F', 'r', 'i'],
  ];

  // final timeTabel = ['微積', '線形代数', 'プログラミング', 'コンピュータアーキテクチャ', 'abc'];

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

  //講義名と講義室番号を表示するカード
  List<Expanded> classroomCards(
      int dayOfWeek, TimeTable table, BuildContext context) {
    DayOfWeek? day = intToDayOfWeek(dayOfWeek);
    List<dynamic> tableData = table.timetable()[day] as List<dynamic>;
    return List.generate(5, (index) {
      String className = '';
      String classroom = '';
      if (tableData[index] != 0) {
        className = (tableData[index] as ClassData).className;
        classroom = (tableData[index] as ClassData).classroom;
      }
      return Expanded(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              child: Card(
                margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 3),
                color: const Color(0xddf8edeb),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      className,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xff463020),
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      classroom,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xff463020),
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ],
                ),
                elevation: 4.0,
              ),
            ),
            if (classroom.isNotEmpty)
              Positioned(
                right: -10,
                top: -2,
                child: IconButton(
                  icon: Icon(
                    Icons.bookmark,
                    color: Colors.brown,
                  ),
                  onPressed: () {
                    final int classDataId = dayOfWeek * 10 + index;
                    Navigator.of(context)
                        .pushNamed(MemoScreen.id, arguments: classDataId);
                  },
                ),
              )
          ],
        ),
      );
    });
  }

  //　一覧画面の一行分のタイルを生成
  List<Expanded> tiles(TimeTable timetableData, BuildContext context) {
    return List.generate(5, (index) {
      return Expanded(
        child: Row(children: [
          const SizedBox(width: 3.0),
          //曜日のアルファベットをColumnで表示
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...List.generate(3, (i) {
                return Container(
                  child: Text(
                    list[index][i],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Color(0xff463020)),
                  ),
                );
              }),
            ],
          ),
          const SizedBox(
            width: 5.0,
          ),
          ...classroomCards(index, timetableData, context),
        ]),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final timeTableData = Provider.of<TimeTable>(context, listen: true);

    AppBar appBar = AppBar(
      title: const Text(
        'TimeTable',
        style: TextStyle(color: Colors.brown, fontWeight: FontWeight.bold),
      ),
      iconTheme: IconThemeData(color: Colors.brown),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: PopupMenuButton(
            child: Row(
              children: [
                const Icon(
                  Icons.edit,
                  size: 32,
                ),
                Text(
                  "編集",
                  style: TextStyle(
                      fontWeight: FontWeight.w500, color: Colors.brown),
                ),
                SizedBox(
                  width: 10,
                )
              ],
            ),
            //don't specify icon if you want 3 dot menu
            color: Theme.of(context).appBarTheme.backgroundColor,
            itemBuilder: (context) => const [
              PopupMenuItem<int>(
                value: 0,
                child: Text(
                  "Monday",
                  style: TextStyle(color: Colors.brown),
                ),
              ),
              PopupMenuItem<int>(
                value: 1,
                child: Text(
                  "Tuesday",
                  style: TextStyle(color: Colors.brown),
                ),
              ),
              PopupMenuItem<int>(
                value: 2,
                child: Text(
                  "Wednesday",
                  style: TextStyle(color: Colors.brown),
                ),
              ),
              PopupMenuItem<int>(
                value: 3,
                child: Text(
                  "Thursday",
                  style: TextStyle(color: Colors.brown),
                ),
              ),
              PopupMenuItem<int>(
                value: 4,
                child: Text(
                  "Friday",
                  style: TextStyle(color: Colors.brown),
                ),
              ),
            ],
            onSelected: (item) {
              print(item);
              Navigator.of(context)
                  .pushNamed(EditTimeTableScreen.routeName, arguments: item);
            },
          ),
        ),
      ],
    );
    return Scaffold(
      appBar: appBar,
      drawer: const MainDrawer(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).iconTheme.color,
        onPressed: () {
          Navigator.of(context).pushReplacementNamed(MapScreen.id);
        },
        child: const Icon(
          Icons.map,
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          height: MediaQuery.of(context).orientation == Orientation.portrait
              ? MediaQuery.of(context).size.height
              : MediaQuery.of(context).size.height * 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? MediaQuery.of(context).size.height * 0.02
                        : MediaQuery.of(context).size.height * 0.08,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.05,
                  ),
                  ...List.generate(
                    5,
                    (index) => Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          (index + 1).toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff463020)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              ...tiles(timeTableData, context),
              SizedBox(
                height: appBar.preferredSize.height +
                    MediaQuery.of(context).padding.top,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

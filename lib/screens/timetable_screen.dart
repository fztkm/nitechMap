import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nitechmap_c0de/providers/timetable.dart';
import 'package:nitechmap_c0de/screens/edit_timetable_screen.dart';
import 'package:nitechmap_c0de/widgets/main_drawer.dart';
import '../widgets/edit_card.dart';
import 'package:provider/provider.dart';

class TimeTableScreen extends StatelessWidget {
  static String id = 'timetabele_screen';
  static var weekdays = ['月', '火', '水', '木', '金'];
  static var list = [
    ['M', 'o', 'n'],
    ['T', 'u', 'e'],
    ['W', 'e', 'd'],
    ['T', 'h', 'u'],
    ['F', 'r', 'y'],
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

  DayOfWeek intToDayOfWeek(int index) {
    switch (index) {
      case 0:
        return DayOfWeek.Mon;
      case 1:
        return DayOfWeek.Tue;
      case 2:
        return DayOfWeek.Wed;
      case 3:
        return DayOfWeek.Thu;
      case 4:
        return DayOfWeek.Fry;
      default:
        return DayOfWeek.Mon;
    }
  }

  List<Expanded> classroomCards(int dayOfWeek, TimeTable table) {
    DayOfWeek day = intToDayOfWeek(dayOfWeek);
    List<dynamic> tableData = table.timetable()[day] as List<dynamic>;
    return List.generate(5, (index) {
      String className = '';
      String classroom = '';
      if (tableData[index] != 0) {
        className = (tableData[index] as ClassData).className;
        classroom = (tableData[index] as ClassData).classroom;
      }
      return Expanded(
        flex: 3,
        child: Card(
          margin: EdgeInsets.symmetric(vertical: 15, horizontal: 3),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                className,
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              SizedBox(height: 10),
              Text(
                classroom,
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ],
          ),
          elevation: 4.0,
        ),
      );
    });
  }

  List<Expanded> tiles(TimeTable timetableData, BuildContext context) {
    return List.generate(5, (index) {
      return Expanded(
        child: Row(children: [
          SizedBox(width: 3.0),
          //曜日のアルファベットをColumnで表示
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...List.generate(3, (i) {
                return Container(
                  child: Text(
                    list[index][i],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                );
              }),
            ],
          ),
          SizedBox(
            width: 5.0,
          ),
          ...classroomCards(index, timetableData),
        ]),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final timeTableData = Provider.of<TimeTable>(context, listen: true);

    AppBar appBar = AppBar(
      title: Text('TimeTable'),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: PopupMenuButton(
            icon: Icon(
              Icons.edit,
              size: 32,
            ), //don't specify icon if you want 3 dot menu
            color: Colors.blue,
            itemBuilder: (context) => [
              PopupMenuItem<int>(
                value: 0,
                child: Text(
                  "Monday",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              PopupMenuItem<int>(
                value: 1,
                child: Text(
                  "Tuesday",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              PopupMenuItem<int>(
                value: 2,
                child: Text(
                  "Wednesday",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              PopupMenuItem<int>(
                value: 3,
                child: Text(
                  "Thursday",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              PopupMenuItem<int>(
                value: 4,
                child: Text(
                  "Fryday",
                  style: TextStyle(color: Colors.white),
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
      drawer: MainDrawer(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8),
          height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
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
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              ...tiles(timeTableData, context),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

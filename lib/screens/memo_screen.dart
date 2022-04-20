import 'package:flutter/material.dart';
import 'package:nitechmap_c0de/materials/dayOfWeek.dart';
import 'package:nitechmap_c0de/providers/memoTable.dart';
import 'package:nitechmap_c0de/providers/timetable.dart';
import 'package:provider/provider.dart';

class MemoScreen extends StatefulWidget {
  static const id = "memo";

  @override
  State<MemoScreen> createState() => _MemoScreenState();
}

class _MemoScreenState extends State<MemoScreen> {
  bool initialized = false;
  ClassData? classData;
  String className = "no data";
  String dayOfWeekChar = "月";
  int classTime = 0;
  String classroom = "no data";

  List<Memo>? memoList;

  @override
  void didChangeDependencies() async {
    if (!initialized) {
      TimeTable timeTable = Provider.of<TimeTable>(context);
      await timeTable.getInitAndGetTimeTable();
      final classDataId = ModalRoute.of(context)!.settings.arguments;
      classData = timeTable.getClassDataByID(classDataId as int);
      className = classData!.className;
      dayOfWeekChar = getDayOfWeekStringByInt(classData!.day);
      classTime = classData!.time + 1;
      classroom = classData!.classroom;

      memoList = [
        Memo(id: 1, parentClassId: 21, title: "テスト形式", bodyText: "期末レポートがかされる"),
        Memo(id: 1, parentClassId: 21, title: "テスト形式", bodyText: "期末レポートがかされる"),
        Memo(id: 1, parentClassId: 21, title: "テスト形式", bodyText: "期末レポートがかされる"),
        Memo(id: 1, parentClassId: 21, title: "テスト形式", bodyText: "期末レポートがかされる"),
        Memo(id: 1, parentClassId: 21, title: "テスト形式", bodyText: "期末レポートがかされる"),
        Memo(id: 1, parentClassId: 21, title: "テスト形式", bodyText: "期末レポートがかされる"),
        Memo(id: 1, parentClassId: 21, title: "テスト形式", bodyText: "期末レポートがかされる"),
        Memo(id: 1, parentClassId: 21, title: "テスト形式", bodyText: "期末レポートがかされる"),
        Memo(id: 1, parentClassId: 21, title: "テスト形式", bodyText: "期末レポートがかされる"),
      ];
      initialized = true;
    }
    super.didChangeDependencies();
  }

  Widget memoItem(Memo memo) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
          child: Column(
            children: [
              Text(
                memo.title,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              Divider(
                thickness: 1,
              ),
              Text(memo.bodyText),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> memoItemList(List<Memo> memos) {
    return memos.map((memo) => memoItem(memo)).toList();
  }

  @override
  Widget build(BuildContext context) {
    AppBar appbar = AppBar(
      title: const Text(
        'Memo',
        style: TextStyle(
          fontWeight: FontWeight.w700,
          color: Colors.brown,
        ),
      ),
      elevation: 0,
      shadowColor: Colors.white,
      backgroundColor: Color(0x00ffffff),
      iconTheme: IconThemeData(color: Colors.brown),
    );
    return Scaffold(
      appBar: appbar,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: (MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top -
                      appbar.preferredSize.height) *
                  0.15,
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        spreadRadius: 1,
                        blurRadius: 2,
                        color: Colors.brown,
                        blurStyle: BlurStyle.outer,
                        offset: Offset(0, 4))
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      className,
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w500,
                          color: Colors.brown),
                    ),
                  ),
                  FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "$dayOfWeekChar曜 $classTimeコマ",
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "講義室: $classroom",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding:
                    EdgeInsets.only(top: 10, right: 5, left: 5, bottom: 10),
                height: (MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top -
                        appbar.preferredSize.height) *
                    0.85,
                child: GridView.count(
                  crossAxisCount: 2,
                  children: [...memoItemList(memoList!)],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.brown,
        child: Icon(
          Icons.note_add,
          color: Colors.white,
        ),
      ),
    );
  }
}

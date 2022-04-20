import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nitechmap_c0de/materials/dayOfWeek.dart';
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
      initialized = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                    color: Theme.of(context)
                        .scaffoldBackgroundColor
                        .withOpacity(0.8),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          spreadRadius: 1,
                          blurRadius: 2,
                          color: Colors.brown,
                          blurStyle: BlurStyle.outer,
                          offset: Offset(0, 2))
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
            ),
            Expanded(
              flex: 5,
              child: Container(),
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

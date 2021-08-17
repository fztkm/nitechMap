import 'package:flutter/material.dart';

class TimeTableScreen extends StatelessWidget {
  static String id = 'timetabele_screen';
  const TimeTableScreen({Key? key}) : super(key: key);

  List<Card> timetableCards() {
    return List.generate(
        5,
        (index) => Card(
              child: Text(''),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('時間割'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Card(
                child: Text('月'),
              ),
            ],
          )
        ],
      ),
    );
  }
}

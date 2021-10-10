import 'package:flutter/material.dart';

class InputListTile extends StatelessWidget {
  int classTime;
  Function(int, String?) setClassName;
  Function(int, String?) setClassroom;

  InputListTile(
      {required this.classTime,
      required this.setClassName,
      required this.setClassroom});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Text('$classTime限'), // 1限　とか
      ),
      title: Column(
        children: [
          TextFormField(
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(labelText: '講義名'),
            onSaved: (value) {
              setClassName(classTime, value); // 講義名を格納
            },
          ),
          TextFormField(
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(labelText: '講義室番号'),
            onSaved: (value) {
              setClassroom(classTime, value); // 講義室番号を格納
            },
          ),
        ],
      ),
    );
  }
}

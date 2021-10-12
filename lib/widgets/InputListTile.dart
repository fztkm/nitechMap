import 'package:flutter/material.dart';
import 'package:nitechmap_c0de/providers/timetable.dart';

class InputListTile extends StatelessWidget {
  final int classTime; // iコマ目なら１
  final Function(int, String?) setClassName;
  final Function(int, String?) setClassroom;
  final List<dynamic> initialData;

  InputListTile({
    required this.classTime,
    required this.setClassName,
    required this.setClassroom,
    required this.initialData,
  });

  String? getInitialName() {
    if (initialData[classTime - 1] is ClassData) {
      print('classData');
      return (initialData[classTime - 1] as ClassData).className;
    } else {
      print('initial is null');
      return null;
    }
  }

  String? getInitialRoomName() {
    if (initialData[classTime - 1] is ClassData) {
      return (initialData[classTime - 1] as ClassData).classroom;
    } else {
      return null;
    }
  }

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
            initialValue: getInitialName(),
            onSaved: (value) {
              setClassName(classTime, value); // 講義名を格納
            },
          ),
          TextFormField(
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(labelText: '講義室番号'),
            initialValue: getInitialRoomName(),
            onSaved: (value) {
              setClassroom(classTime, value); // 講義室番号を格納
            },
          ),
        ],
      ),
    );
  }
}

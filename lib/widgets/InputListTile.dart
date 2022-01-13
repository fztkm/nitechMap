import 'package:flutter/material.dart';
import 'package:nitechmap_c0de/providers/timetable.dart';

class InputListTile extends StatefulWidget {
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

  @override
  _InputListTileState createState() => _InputListTileState();
}

class _InputListTileState extends State<InputListTile> {
  String? getInitialName() {
    if (widget.initialData[widget.classTime - 1] is ClassData) {
      print('classData');
      return (widget.initialData[widget.classTime - 1] as ClassData).className;
    } else {
      print('initial is null');
      return null;
    }
  }

  String? getInitialRoomName() {
    if (widget.initialData[widget.classTime - 1] is ClassData) {
      return (widget.initialData[widget.classTime - 1] as ClassData).classroom;
    } else {
      return null;
    }
  }

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Text('${widget.classTime}限'), // 1限　とか
      ),
      title: Column(
        children: [
          TextFormField(
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(labelText: '講義名'),
            initialValue: getInitialName(),
            onSaved: (value) {
              widget.setClassName(widget.classTime, value); // 講義名を格納
            },
          ),
          TextFormField(
            textInputAction: TextInputAction.next,
            decoration:const InputDecoration(labelText: '講義室番号'),
            initialValue: getInitialRoomName(),
            onSaved: (value) {
              widget.setClassroom(widget.classTime, value); // 講義室番号を格納
            },
          ),
        ],
      ),
    );
  }
}

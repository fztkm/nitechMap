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
    FocusNode mFocusNodeClassName = FocusNode();
    FocusNode mFocusNodeClassRoom = FocusNode();
    return ListTile(
      leading: CircleAvatar(
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(
              '${widget.classTime}',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ), // 1コマ　とか
        backgroundColor: Theme.of(context).iconTheme.color,
      ),
      title: Column(
        children: [
          TextFormField(
            cursorColor: Colors.brown,
            textInputAction: TextInputAction.next,
            focusNode: mFocusNodeClassName,
            decoration: InputDecoration(
              labelText: '講義名',
              labelStyle: TextStyle(
                  color: mFocusNodeClassName.hasFocus
                      ? Colors.black
                      : Colors.brown),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.brown),
              ),
            ),
            initialValue: getInitialName(),
            onSaved: (value) {
              widget.setClassName(widget.classTime, value); // 講義名を格納
            },
          ),
          SizedBox(
            height: 15,
          ),
          TextFormField(
            cursorColor: Colors.brown,
            focusNode: mFocusNodeClassRoom,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              labelText: '講義室番号',
              labelStyle: TextStyle(color: Colors.brown),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.brown),
              ),
            ),
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

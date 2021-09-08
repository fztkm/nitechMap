import 'package:flutter/material.dart';

class EditTimeTableScreen extends StatefulWidget {
  static const routeName = '/edit_timetable_screen';

  @override
  _EditTimeTableScreenState createState() => _EditTimeTableScreenState();
}

class _EditTimeTableScreenState extends State<EditTimeTableScreen> {
  var _dayOfWeek = '月曜';

  var optionsDOW = ['月曜', '火曜', '水曜', '木曜', '金曜'];

  final _form = GlobalKey<FormState>();
  //ToDo provider<TimeTable>を取得して、saveで値を変更する.

  void _saveTimeTable() {
    final valid = _form.currentState!.validate();
    if (!valid) {
      return;
    }
    _form.currentState!.save(); //onSavedをトリガー
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('時間割編集'),
        actions: [
          IconButton(
            onPressed: _saveTimeTable,
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _form,
          autovalidate: true,
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('曜日'),
                  SizedBox(
                    width: 20,
                  ),
                  DropdownButton<String>(
                    value: _dayOfWeek,
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 30,
                    elevation: 16,
                    style: TextStyle(fontSize: 20, color: Colors.black),
                    underline: Container(
                      height: 2,
                      color: Colors.grey,
                    ),
                    onChanged: (newValue) {
                      setState(() {
                        _dayOfWeek = newValue as String;
                      });
                    },
                    items: optionsDOW
                        .map<DropdownMenuItem<String>>((e) =>
                            DropdownMenuItem<String>(value: e, child: Text(e)))
                        .toList(),
                  ),
                ],
              ),
              ListTile(
                leading: CircleAvatar(
                  child: Text('1限'),
                ),
                title: Column(
                  children: [
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(labelText: '講義名'),
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(labelText: '講義室番号'),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 1,
              ),
              ListTile(
                leading: CircleAvatar(
                  child: Text('2限'),
                ),
                title: Column(
                  children: [
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(labelText: '講義名'),
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(labelText: '講義室番号'),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 1,
              ),
              ListTile(
                leading: CircleAvatar(
                  child: Text('3限'),
                ),
                title: Column(
                  children: [
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(labelText: '講義名'),
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(labelText: '講義室番号'),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 1,
              ),
              ListTile(
                leading: CircleAvatar(
                  child: Text('4限'),
                ),
                title: Column(
                  children: [
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(labelText: '講義名'),
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(labelText: '講義室番号'),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 1,
              ),
              ListTile(
                leading: CircleAvatar(
                  child: Text('5限'),
                ),
                title: Column(
                  children: [
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(labelText: '講義名'),
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(labelText: '講義室番号'),
                      onFieldSubmitted: (_) {
                        _saveTimeTable();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

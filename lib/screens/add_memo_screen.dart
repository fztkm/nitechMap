import 'package:flutter/material.dart';
import 'package:nitechmap_c0de/providers/timetable.dart';

class AddMemoScreen extends StatefulWidget {
  const AddMemoScreen({Key? key}) : super(key: key);
  static const id = "add_memo";

  @override
  State<AddMemoScreen> createState() => _AddMemoScreenState();
}

class _AddMemoScreenState extends State<AddMemoScreen> {
  ClassData? classData;
  bool initialized = false;
  String className = "";
  String title = "";
  String body = "";

  @override
  void didChangeDependencies() {
    if (!initialized) {
      classData = ModalRoute.of(context)!.settings.arguments as ClassData;
      className = classData!.className;
      initialized = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Memo $className',
          overflow: TextOverflow.ellipsis,
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
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(hintText: "Title"),
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                onSubmitted: (value) {},
              ),
              Expanded(
                flex: 1,
                child: ListView(
                  children: [
                    TextFormField(
                      maxLines: 40,
                      decoration: InputDecoration(hintText: "Input body text"),
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                      ),
                      onFieldSubmitted: (value) {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.brown,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          if (title.isNotEmpty) {
            //Add Memo
          } else {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}

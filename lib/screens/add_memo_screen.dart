import 'package:flutter/material.dart';
import 'package:nitechmap_c0de/providers/memoTable.dart';
import 'package:nitechmap_c0de/providers/timetable.dart';
import 'package:provider/provider.dart';

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
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.brown,
          ),
        ),
        elevation: 0,
        shadowColor: Colors.white,
        backgroundColor: const Color(0x00ffffff),
        iconTheme: const IconThemeData(color: Colors.brown),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              TextFormField(
                maxLines: 1,
                decoration: const InputDecoration(hintText: "Title"),
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                onChanged: (value) {
                  title = value.toString();
                },
              ),
              Expanded(
                flex: 1,
                child: ListView(
                  children: [
                    TextFormField(
                      maxLines: 40,
                      decoration:
                          const InputDecoration(hintText: "Input body text"),
                      style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                      ),
                      onChanged: (value) {
                        body = value.toString();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        height: 50,
        width: 88,
        child: FloatingActionButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          backgroundColor: Colors.blue,
          child: FittedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.save,
                  color: Colors.white,
                ),
                SizedBox(width: 5),
                Text(
                  "保存",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          onPressed: () async {
            if (title.isNotEmpty || body.isNotEmpty) {
              final parentId = classData!.id();
              //Add Memo
              MemoDatabase db =
                  Provider.of<MemoDatabase>(context, listen: false);
              db.insertMemo(
                Memo(
                  parentClassId: parentId,
                  title: title,
                  bodyText: body,
                ),
              );
            }
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

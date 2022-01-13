import 'package:flutter/material.dart';

class EditCard extends StatefulWidget {
  const EditCard({Key? key}) : super(key: key);

  @override
  _EditCardState createState() => _EditCardState();
}

class _EditCardState extends State<EditCard> {
  Container inputField() {
    return Container(
      padding:const EdgeInsets.only(top: 10, bottom: 10, right: 20),
      width: MediaQuery.of(context).size.width * 0.65,
      child: Column(
        children: const [
          TextField(
            decoration: InputDecoration(labelText: '講義'),
          ),
          TextField(
            decoration: InputDecoration(labelText: '講義室番号'),
          ),
        ],
      ),
    );
  }

  List<Container> inputFieldList() {
    return List.generate(5, (index) {
      return inputField();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SingleChildScrollView(
        reverse: true,
        child: Container(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          alignment: Alignment.centerRight,
          child: Column(children: inputFieldList()),
        ),
      ),
    );
  }
}

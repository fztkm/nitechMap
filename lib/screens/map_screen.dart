import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import 'timetable_screen.dart';

class MapScreen extends StatefulWidget {
  static String id = 'welcome_screen';
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  var photo = 'images/nekochan0.jpg';
  var currentIndex = 0;

  void changePhoto(int index) {
    setState(() {
      photo = 'images/nekochan$index.jpg';
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: PhotoView(
            imageProvider: AssetImage(photo),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.arrow_drop_down_circle_outlined),
              label: 'Now',
              backgroundColor: Colors.red,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.navigate_next),
              label: 'Next',
              backgroundColor: Colors.pink,
            ),
          ],
          currentIndex: currentIndex,
          selectedItemColor: Colors.amber[800],
          onTap: (index) {
            changePhoto(index);
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, TimeTableScreen.id);
        },
        child: Icon(Icons.apps_rounded),
      ),
    );
  }
}

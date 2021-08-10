import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class MapScreen extends StatefulWidget {
  static String id = 'welcome_screen';
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: PhotoView(
            imageProvider: AssetImage('images/nekochan.jpg'),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nitechmap_c0de/map_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Nitech Map',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 60.0,
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, MapScreen.id);
            },
            child: Text('Log in'),
          ),
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, MapScreen.id);
              },
              child: Text('Sign in')),
        ],
      ),
    );
  }
}

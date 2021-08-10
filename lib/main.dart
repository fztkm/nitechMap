import 'package:flutter/material.dart';
import 'package:nitechmap_c0de/map_screen.dart';

import 'welcome_screen.dart';

void main() {
  runApp(NitechMap());
}

class NitechMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        MapScreen.id: (context) => MapScreen(),
      },
      home: WelcomeScreen(),
    );
  }
}

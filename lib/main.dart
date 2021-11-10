import 'package:flutter/material.dart';
import 'package:nitechmap_c0de/screens/databasetest_screen.dart';
import 'package:nitechmap_c0de/screens/edit_timetable_screen.dart';
import 'package:nitechmap_c0de/screens/map_screen.dart';
import 'package:nitechmap_c0de/screens/timetable_screen.dart';
import 'package:provider/provider.dart';
import 'providers/timetable.dart';
import 'screens/welcome_screen.dart';

void main() {
  runApp(NitechMap());
}

class NitechMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TimeTable>(
      create: (context) => TimeTable(),
      child: MaterialApp(
        theme: ThemeData(
          accentColor: Colors.amber[400],
        ),
        routes: {
          WelcomeScreen.id: (context) => WelcomeScreen(),
          MapScreen.id: (context) => MapScreen(),
          TimeTableScreen.id: (context) => TimeTableScreen(),
          EditTimeTableScreen.routeName: (context) => EditTimeTableScreen(),
          DatabaseTestScreen.id: (context) => DatabaseTestScreen(),
        },
        home: MapScreen(),
      ),
    );
  }
}

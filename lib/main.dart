import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'screens/databasetest_screen.dart';
import 'screens/edit_timetable_screen.dart';
import 'screens/map_screen.dart';
import 'screens/timetable_screen.dart';
import 'package:provider/provider.dart';
import 'providers/timetable.dart';
import 'screens/welcome_screen.dart';

void main() {
  runApp(NitechMap());
}

class NitechMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const locale = Locale("ja", "JP");
    return ChangeNotifierProvider<TimeTable>(
      create: (context) => TimeTable(),
      child: MaterialApp(
        theme: ThemeData(
          accentColor: Colors.amber[400],
        ),
        locale: locale,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          locale,
        ],
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

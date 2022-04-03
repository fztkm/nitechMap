import 'package:flutter/cupertino.dart';
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
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            accentColor: Color(0xff90e0ef),
            scaffoldBackgroundColor: Color(0xfff8edeb),
            iconTheme: IconThemeData(color: Color(0xff7f5539)),
            primaryColor: Color(0xffb08968),
            appBarTheme: AppBarTheme(backgroundColor: Color(0xffb08968)),
            fontFamily: 'Comfortaa'),
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

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:nitechmap_c0de/providers/memoTable.dart';
import 'package:nitechmap_c0de/screens/add_memo_screen.dart';
import 'package:nitechmap_c0de/screens/edit_memo_screen.dart';
import 'package:nitechmap_c0de/screens/memo_screen.dart';
import 'screens/databasetest_screen.dart';
import 'screens/edit_timetable_screen.dart';
import 'screens/map_screen.dart';
import 'screens/timetable_screen.dart';
import 'package:provider/provider.dart';
import 'providers/timetable.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //向き指定
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, //縦固定
  ]);
  runApp(NitechMap());
}

class NitechMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const locale = Locale("ja", "JP");
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TimeTable>(
          create: (context) => TimeTable(),
        ),
        ChangeNotifierProvider<MemoDatabase>(
          create: (context) => MemoDatabase(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            accentColor: Color(0xff84E8FC),
            scaffoldBackgroundColor: Color(0xfff8edeb),
            iconTheme: IconThemeData(color: Color(0xff7f5539)),
            primaryColor: Color(0xffb08968),
            appBarTheme: AppBarTheme(
                backgroundColor: Color(0xfff8edeb),
                iconTheme: IconThemeData(color: Colors.brown),
                titleTextStyle: TextStyle(
                    color: Colors.brown,
                    fontFamily: 'Comfortaa',
                    fontWeight: FontWeight.bold,
                    fontSize: 20)),
            fontFamily: 'MPLUSRounded1c'),
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
          MapScreen.id: (context) => MapScreen(),
          TimeTableScreen.id: (context) => TimeTableScreen(),
          EditTimeTableScreen.routeName: (context) => EditTimeTableScreen(),
          MemoScreen.id: (context) => MemoScreen(),
          AddMemoScreen.id: (context) => AddMemoScreen(),
          EditMemoScreen.id: (context) => EditMemoScreen(),
          DatabaseTestScreen.id: (context) => DatabaseTestScreen(),
        },
        home: MapScreen(),
      ),
    );
  }
}

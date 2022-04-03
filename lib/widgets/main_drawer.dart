import 'package:flutter/material.dart';
import 'package:nitechmap_c0de/screens/map_screen.dart';
import 'package:nitechmap_c0de/screens/timetable_screen.dart';
import 'package:package_info/package_info.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        children: [
          AppBar(
            title: Row(
              children: [
                Image.asset(
                  "images/app_icon_rounded.png",
                  width: AppBar().preferredSize.height * 0.85,
                ),
                const SizedBox(
                  width: 20,
                ),
                const Text(
                  "Nitech Map",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            automaticallyImplyLeading: false,
          ),
          const Divider(
            thickness: 1.0,
          ),
          TextButton.icon(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(MapScreen.id);
            },
            icon: Icon(
              Icons.map,
              size: 30,
              color: Theme.of(context).iconTheme.color,
            ),
            label: Text(
              'Map',
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: Theme.of(context).iconTheme.color,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          const Divider(
            thickness: 1.0,
          ),
          TextButton.icon(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(TimeTableScreen.id);
            },
            icon: Icon(
              Icons.apps_rounded,
              size: 30,
              color: Theme.of(context).iconTheme.color,
            ),
            label: Text(
              'TimeTable',
              style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: Theme.of(context).iconTheme.color,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(
            thickness: 1.0,
          ),
          TextButton.icon(
            onPressed: () async {
              final info = await PackageInfo.fromPlatform();
              showLicensePage(
                context: context,
                applicationName: "名工大Map",
                applicationVersion: info.version,
                applicationIcon: Image.asset(
                  "images/app_icon_rounded.png",
                  width: 80,
                ),
                applicationLegalese: "",
              );
            },
            icon: Icon(
              Icons.info,
              size: 30,
              color: Theme.of(context).iconTheme.color,
            ),
            label: Text(
              'Licenses',
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: Colors.grey,
                  ),
            ),
          ),
          const Divider(
            thickness: 1.0,
          ),
          const Spacer(
            flex: 3,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            margin: EdgeInsets.all(15),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "時間割",
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 17,
                      color: Theme.of(context).iconTheme.color),
                ),
                const Divider(
                  thickness: 0.8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TimeTableText(text: '1コマ'),
                    TimeTableText(text: "8:50 ~ 10:20")
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TimeTableText(text: "2コマ"),
                    TimeTableText(text: "10:30 ~ 12:00")
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TimeTableText(text: "3コマ"),
                    TimeTableText(text: "13:00 ~ 14:30")
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TimeTableText(text: "4コマ"),
                    TimeTableText(text: "14:40 ~ 16:10")
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TimeTableText(text: "5コマ"),
                    TimeTableText(text: "16:20 ~ 17:50")
                  ],
                ),
              ],
            ),
          ),
          const Spacer(flex: 2)
        ],
      ),
    );
  }
}

class TimeTableText extends StatelessWidget {
  final String text;
  const TimeTableText({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).iconTheme.color),
    );
  }
}

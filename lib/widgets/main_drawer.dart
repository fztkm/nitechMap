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
            title: Row(children: [
              Image.asset("images/app_icon_rounded.png", width: AppBar().preferredSize.height * 0.85,),
              const SizedBox(width: 20,),
              const Text("Nitech Map"),
            ],),
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
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Theme.of(context).iconTheme.color),
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
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Theme.of(context).iconTheme.color),
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
                applicationIcon: Image.asset("images/app_icon_rounded.png", width: 80,),
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
        ],
      ),
    );
  }
}

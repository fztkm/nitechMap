import 'package:flutter/material.dart';
import 'package:nitechmap_c0de/screens/map_screen.dart';
import 'package:nitechmap_c0de/screens/timetable_screen.dart';
import 'package:package_info/package_info.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Nitech Map'),
            automaticallyImplyLeading: false,
          ),
          Divider(
            thickness: 1.0,
          ),
          TextButton.icon(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(MapScreen.id);
            },
            icon: Icon(
              Icons.map,
              size: 30,
            ),
            label: Text(
              'Map',
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Theme.of(context).primaryColor),
            ),
          ),
          Divider(
            thickness: 1.0,
          ),
          TextButton.icon(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(TimeTableScreen.id);
            },
            icon: Icon(
              Icons.apps_rounded,
              size: 30,
            ),
            label: Text(
              'TimeTable',
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Theme.of(context).primaryColor),
            ),
          ),
          Divider(
            thickness: 1.0,
          ),
          TextButton.icon(
            onPressed: () async {
              final info = await PackageInfo.fromPlatform();
              showLicensePage(
                context: context,
                applicationName: info.appName,
                applicationVersion: info.version,
                applicationIcon: Icon(Icons.tag_faces),
                applicationLegalese: "ほげほげ",
              );
            },
            icon: Icon(
              Icons.info,
              size: 30,
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

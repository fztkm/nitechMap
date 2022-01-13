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
            title:const Text('Nitech Map'),
            automaticallyImplyLeading: false,
          ),
          const Divider(
            thickness: 1.0,
          ),
          TextButton.icon(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(MapScreen.id);
            },
            icon:const Icon(
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
          const Divider(
            thickness: 1.0,
          ),
          TextButton.icon(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(TimeTableScreen.id);
            },
            icon: const Icon(
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
          const Divider(
            thickness: 1.0,
          ),
          TextButton.icon(
            onPressed: () async {
              final info = await PackageInfo.fromPlatform();
              showLicensePage(
                context: context,
                applicationName: "Nitech Map",
                applicationVersion: info.version,
                applicationIcon: Icon(Icons.map),
                applicationLegalese: "",
              );
            },
            icon:const Icon(
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

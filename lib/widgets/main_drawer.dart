import 'package:flutter/material.dart';
import 'package:nitechmap_c0de/screens/map_screen.dart';
import 'package:nitechmap_c0de/screens/timetable_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('NitechApp'),
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
        ],
      ),
    );
  }
}

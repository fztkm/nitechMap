import 'package:flutter/material.dart';
import 'package:nitechmap_c0de/materials/nextClassData.dart';
import 'package:nitechmap_c0de/widgets/main_drawer.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'timetable_screen.dart';
import 'package:intl/intl.dart';

class MapScreen extends StatefulWidget {
  //initで現在時間を取得して、
  // 講義室番号と授業名とコマを取得。
  static String id = 'welcome_screen';
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  var svgPhoto = 'images/00gou.svg';
  var currentIndex = 0;
  NextClassData? next;
  bool initialized = false;

  void changePhoto(int index) {
    setState(() {
      String buildingNum = "00";
      if (index == 0) {
        buildingNum = (next!.getThisClassData()[1]).substring(0, 2);
      } else if (index == 1) {
        buildingNum = (next!.getNextClassData()[1]).substring(0, 2);
      }
      svgPhoto = 'images/${buildingNum}gou.svg';
      currentIndex = index;
    });
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   // Future.delayed(Duration.zero).then((_) {
  //   //   next = NextClassData(context);
  //   // });
  //   super.initState();
  // }

  @override
  void didChangeDependencies() {
    if (!initialized) {
      next = NextClassData(context);
      String buildingNum = (next!.getThisClassData()[1]).substring(0, 2);
      svgPhoto = 'images/${buildingNum}gou.svg';
      initialized = true;
    }
    super.didChangeDependencies();
  }

  //TODO : 適切でない講義室番号のときは00gou.svgを選択

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    // next = NextClassData(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Nitech Map'),
      ),
      drawer: MainDrawer(),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              child: PhotoView.customChild(
                child: SvgPicture.asset(svgPhoto),
                backgroundDecoration: BoxDecoration(color: Colors.white),
                customSize: MediaQuery.of(context).size * 2.2,
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0,
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: primaryColor, width: 2)),
                    child: Column(
                      children: [
                        Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: primaryColor),
                              ),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 3.0),
                              child: Text(
                                  '${next!.getToday()} - ${next?.getThisClassIdx()}コマ'),
                            )),
                        Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: primaryColor),
                              ),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 3.0),
                              child: Text(
                                  next?.getThisClassData()[0] as String), // 講義名
                            )),
                        Container(
                            // decoration: BoxDecoration(
                            //   border: Border(
                            //     bottom: BorderSide(color: primaryColor),
                            //   ),
                            // ),
                            child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 3.0),
                          child: Text(
                              next?.getThisClassData()[1] as String), // 講義室名
                        )),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.white,
          selectedIconTheme: IconThemeData(color: Colors.amber),
          selectedLabelStyle: TextStyle(color: Colors.amber),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.arrow_drop_down_circle_outlined),
              label: 'Now',
              backgroundColor: Colors.red,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.navigate_next),
              label: 'Next',
              backgroundColor: Colors.pink,
            ),
          ],
          currentIndex: currentIndex,
          selectedItemColor: Colors.amber[800],
          onTap: (index) {
            changePhoto(index);
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).accentColor,
        onPressed: () {
          Navigator.pushReplacementNamed(context, TimeTableScreen.id);
        },
        child: Icon(Icons.apps_rounded),
      ),
    );
  }
}

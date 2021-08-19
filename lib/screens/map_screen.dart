import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'timetable_screen.dart';

class MapScreen extends StatefulWidget {
  //initで現在時間を取得して、
  // 講義室番号と授業名とコマを取得。
  static String id = 'welcome_screen';
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  var svgPhoto = 'images/11gou.svg';
  var currentIndex = 0;

  void changePhoto(int index) {
    setState(() {
      svgPhoto = 'images/0${index}gou.svg';
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              child: PhotoView.customChild(
                child: SvgPicture.asset(svgPhoto),
                backgroundDecoration: BoxDecoration(color: Colors.white),
                customSize: MediaQuery.of(context).size * 1.8,
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
                              child: Text('8/19-1コマ'),
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
                              child: Text('プログラミング'),
                            )),
                        Container(
                            // decoration: BoxDecoration(
                            //   border: Border(
                            //     bottom: BorderSide(color: primaryColor),
                            //   ),
                            // ),
                            child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 3.0),
                          child: Text('0123'),
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
          Navigator.pushNamed(context, TimeTableScreen.id);
        },
        child: Icon(Icons.apps_rounded),
      ),
    );
  }
}

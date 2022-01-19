import 'package:flutter/material.dart';
import 'package:nitechmap_c0de/materials/consts.dart';
import 'package:nitechmap_c0de/materials/nextClassData.dart';
import 'package:nitechmap_c0de/widgets/main_drawer.dart';
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
  var svgPhoto = 'images/00gou.svg';
  var currentIndex = 0;
  NextClassData? next;
  bool initialized = false;
  String timeInfo = '';
  String name = '';
  String className = '';

  //講義室名から何号館のsvg画像が必要かをパスで返す
  String getImageString(String roomName) {
    var imageString;
    String buildingNum = roomName.substring(0, 2);
    //先頭の二文字がproperBuildingNumに含まれていれば、それが何号館に対応する
    if (c_properBuildingNum.contains(buildingNum)) {
      imageString = "images/${buildingNum}gou.svg";
    } else if (buildingNum == "4-" ||
        buildingNum == "4ー" ||
        buildingNum == "4 ") {
      imageString = "images/04gou.svg";
    } else if (buildingNum == "2-" ||
        buildingNum == "2ー" ||
        buildingNum == "2 ") {
      imageString = "images/02gou.svg";
    } else if (roomName.contains("講堂") || roomName.contains("ラーニングコモンズ")) {
      //講堂2階ラーニングコモンズ はNitechHallの画像
      imageString = "images/nithall.svg";
    } else {
      imageString = "images/00gou.svg";
      //デフォルトの画像 00gou.svg
    }
    return imageString;
  }

  void changePhoto(int index) {
    //next(index == 0)かnow(index == 1)かに応じて　テキスト情報を変える
    var classData;
    if (index == 0) {
      timeInfo = '${next!.getToday()} - ${next!.getThisClassIdx()}コマ';
      classData = next!.getThisClassData();
    }
    if (index == 1) {
      timeInfo = '${next!.getToday()} - ${next!.getNextClassIdx()}コマ';
      classData = next!.getNextClassData();
    }
    setState(() {
      name = classData[0];
      className = classData[1];
      svgPhoto = getImageString(className);
      print("svgphoto = $svgPhoto");
      currentIndex = index;
    });
  }

  /*初期化関数の役割
    時間割情報を取得する
  */
  @override
  void didChangeDependencies() async {
    //一度だけ実行される。実行後initializedはFalseになる
    if (!initialized) {
      next = NextClassData(context);
      await next!.setTimeTableFromDB();
      List<String> classData = next!.getThisClassData();
      String roomName = classData[1];
      svgPhoto = getImageString(roomName);

      timeInfo = '${next!.getToday()} - ${next!.getThisClassIdx()}コマ';
      setState(() {
        name = classData[0];
        className = roomName;
        print("This/Next class name = $name");
        print("classRoomNumber = $className\nsvg = $svgPhoto");
        super.didChangeDependencies();
        initialized = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: MediaQuery.of(context).orientation == Orientation.portrait
          ? AppBar(
              title: const Text('Nitech Map'),
            )
          : null,
      drawer: MainDrawer(),
      body: !initialized
          ? SafeArea(
              child: Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            ))
          : SafeArea(
              child: Stack(
                children: [
                  Container(
                    child: PhotoView.customChild(
                      child: SvgPicture.asset(svgPhoto),
                      backgroundDecoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor),
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
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: const Color(0xffB99679),
                              borderRadius: BorderRadius.circular(8),
                              border:
                                  Border.all(color: Colors.white38, width: 2)),
                          child: Column(
                            children: [
                              Container(
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(color: Colors.white),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 3.0),
                                    child: Text(timeInfo,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                  )),
                              Container(
                                  width: name.length > 10
                                      ? MediaQuery.of(context).size.width * 0.4
                                      : null,
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(color: Colors.white),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 3.0),
                                    child: Text(
                                      name,
                                      style: const TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ), // 講義名
                                  )),
                              Container(
                                  child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 3.0),
                                child: Text(className,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)), // 講義室名
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
          selectedIconTheme:
              IconThemeData(color: Theme.of(context).accentColor),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: const Icon(Icons.arrow_drop_down_circle_outlined),
              label: 'This Class',
              backgroundColor: Colors.red,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.navigate_next),
              label: 'Next Class',
              backgroundColor: Colors.pink,
            ),
          ],
          currentIndex: currentIndex,
          selectedItemColor: Theme.of(context).accentColor,
          onTap: (index) {
            changePhoto(index);
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).accentColor,
        onPressed: () {
          Navigator.pushReplacementNamed(context, TimeTableScreen.id);
        },
        child: Icon(
          Icons.apps_rounded,
          color: Theme.of(context).iconTheme.color,
        ),
      ),
    );
  }
}

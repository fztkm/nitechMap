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
  TextStyle? _selectedItemTextStyle;
  TextStyle? _notSelectedItemTextStyle;
  TextStyle? _thisClassTextStyle;
  TextStyle? _nextClassTextStyle;
  Color? _thisClassIconColor;
  Color? _nextClassIconColor;

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
      _thisClassTextStyle = _selectedItemTextStyle;
      _nextClassTextStyle = _notSelectedItemTextStyle;
      _thisClassIconColor = Theme.of(context).accentColor;
      _nextClassIconColor = Colors.white;
    }
    if (index == 1) {
      timeInfo = '${next!.getToday()} - ${next!.getNextClassIdx()}コマ';
      classData = next!.getNextClassData();
      _thisClassTextStyle = _notSelectedItemTextStyle;
      _nextClassTextStyle = _selectedItemTextStyle;
      _thisClassIconColor = Colors.white;
      _nextClassIconColor = Theme.of(context).accentColor;
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
      _selectedItemTextStyle = TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).accentColor,
      );
      _notSelectedItemTextStyle = TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      );
      _thisClassTextStyle = _selectedItemTextStyle;
      _nextClassTextStyle = _notSelectedItemTextStyle;
      _thisClassIconColor = Theme.of(context).accentColor;
      _nextClassIconColor = Colors.white;
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
      extendBody: true,
      appBar: MediaQuery.of(context).orientation == Orientation.portrait
          ? AppBar(
              title: const Text(
                'Nitech Map',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
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
                                            fontWeight: FontWeight.normal)),
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
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal),
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
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 6,
        color: Theme.of(context).primaryColor,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 0, right: 16, bottom: 8, left: 16),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  splashFactory: InkSplash.splashFactory,
                  primary: Colors.white,
                ),
                onPressed: () {
                  changePhoto(0);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_drop_down_circle_outlined,
                      color: _thisClassIconColor,
                    ),
                    SizedBox(width: 8),
                    Text(
                      "This Class",
                      style: _thisClassTextStyle,
                    ),
                  ],
                ),
              ),
              TextButton(
                  style: TextButton.styleFrom(
                    splashFactory: InkSplash.splashFactory,
                    primary: Colors.white,
                  ),
                  onPressed: () {
                    changePhoto(1);
                  },
                  child: Row(
                    children: [
                      Text(
                        "Next Class",
                        style: _nextClassTextStyle,
                      ),
                      Icon(
                        Icons.navigate_next,
                        color: _nextClassIconColor,
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

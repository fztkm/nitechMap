import 'package:flutter/material.dart';
import 'package:nitechmap_c0de/materials/consts.dart';
import 'package:nitechmap_c0de/materials/nextClassData.dart';
import 'package:nitechmap_c0de/providers/memoTable.dart';
import 'package:nitechmap_c0de/screens/memo_screen.dart';
import 'package:nitechmap_c0de/widgets/classInfoTextData_container.dart';
import 'package:nitechmap_c0de/widgets/main_drawer.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'timetable_screen.dart';

class MapScreen extends StatefulWidget {
  //initで現在時間を取得して、
  // 講義室番号と授業名とコマを取得。
  static String id = 'welcome_screen';

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> with WidgetsBindingObserver {
  var svgPhoto = 'images/00gou.svg';
  var currentIndex = 0;
  NextClassData? next;
  bool initialized = false;
  TextStyle _selectedItemTextStyle = TextStyle();
  TextStyle _notSelectedItemTextStyle = TextStyle();
  TextStyle _thisClassTextStyle = TextStyle();
  TextStyle _nextClassTextStyle = TextStyle();
  Color? _thisClassIconColor;
  Color? _nextClassIconColor;
  double _thisClassIconSize = 25;
  double _nextClassIconSize = 20;
  int? _thisParentIdForMemoScreen;
  int? _nextParentIdForMemoScreen;
  int? _parentIdForMemoScreen;

  //講義室名から何号館のsvg画像が必要かをパスで返す
  String getImageString(String? roomName) {
    var imageString = "images/00gou.svg"; //デフォルトの画像
    if (roomName != null && roomName.isNotEmpty && roomName.length >= 2) {
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
      } else if (roomName.contains("講堂") ||
          roomName.contains("ラーニング") ||
          roomName.toLowerCase().contains("nitech hall")) {
        //講堂2階ラーニングコモンズ はNitechHallの画像
        imageString = "images/nithall.svg";
      }
    }
    return imageString;
  }

  //例：[ "4/2 - 5コマ", "線形代数", "1121"]
  List<String> thisTimeData = [
    "no data",
    "no data",
    "no data",
  ];
  List<String> nextTimeData = [
    "no data",
    "no data",
    "no data",
  ];

  void initClassData() {
    thisTimeData[0] = '${next!.getToday()} - ${next!.getThisClassIdx()}コマ';
    thisTimeData[1] = next!.getThisClassData()[0];
    _thisParentIdForMemoScreen = next!.thisClassParentIdForMemoScreen();
    var thisClassRoom = next!.getThisClassData()[1];
    if (thisClassRoom.isEmpty && _thisParentIdForMemoScreen != null) {
      thisClassRoom = next!.parentClassRoom(_thisParentIdForMemoScreen!);
    }
    thisTimeData[2] = thisClassRoom;
    _parentIdForMemoScreen = _thisParentIdForMemoScreen;
    print("THIS IS: $_thisParentIdForMemoScreen");

    nextTimeData[0] = '${next!.getToday()} - ${next!.getNextClassIdx()}コマ';
    nextTimeData[1] = next!.getNextClassData()[0];
    _nextParentIdForMemoScreen = next!.nextClassParentIdForMemoScreen();
    var nextClassRoom = next!.getNextClassData()[1];
    if (nextClassRoom.isEmpty && _nextParentIdForMemoScreen != null) {
      nextClassRoom = next!.parentClassRoom(_nextParentIdForMemoScreen!);
    }
    nextTimeData[2] = nextClassRoom;
    print("NEXT IS: $_nextParentIdForMemoScreen");
  }

  void changePhoto(int index) {
    //this(index == 0)かnext(index == 1)かに応じて　ボトムバーのテキストスタイル・画像を変える
    var classNum;
    if (index == 0) {
      _thisClassTextStyle = _selectedItemTextStyle;
      _nextClassTextStyle = _notSelectedItemTextStyle;
      _thisClassIconSize = 25;
      _nextClassIconSize = 20;
      classNum = thisTimeData[2];
      _parentIdForMemoScreen = _thisParentIdForMemoScreen;
    }
    if (index == 1) {
      _thisClassTextStyle = _notSelectedItemTextStyle;
      _nextClassTextStyle = _selectedItemTextStyle;
      _thisClassIconSize = 20;
      _nextClassIconSize = 25;
      classNum = nextTimeData[2];
      _parentIdForMemoScreen = _nextParentIdForMemoScreen;
    }
    setState(() {
      svgPhoto = getImageString(classNum);
      print("svgphoto = $svgPhoto");
      print("parent Id idididid: $_parentIdForMemoScreen");
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
      initClassData();
      svgPhoto = getImageString(thisTimeData[2]);
      _selectedItemTextStyle = const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.bold,
        color: Colors.brown,
        fontFamily: 'Comfortaa',
      );
      _notSelectedItemTextStyle = const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Colors.brown,
        fontFamily: 'Comfortaa',
      );
      _thisClassTextStyle = _selectedItemTextStyle;
      _nextClassTextStyle = _notSelectedItemTextStyle;
      _thisClassIconColor = Colors.brown;
      _nextClassIconColor = Colors.brown;
      setState(() {
        super.didChangeDependencies();
        initialized = true;
      });
      print("Initialized");
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  //バックグラウンドから再開したときに初期化する.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("state = $state");
    if (state == AppLifecycleState.resumed) {
      initialized = false;
      didChangeDependencies();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: MediaQuery.of(context).orientation == Orientation.portrait
          ? AppBar(
              title: const Text(
                'Nitech Map',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.brown,
                ),
              ),
              elevation: 0,
              backgroundColor: Color(0x00ffffff),
              iconTheme: IconThemeData(color: Colors.brown),
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
                  PhotoView.customChild(
                    child: SvgPicture.asset(svgPhoto),
                    backgroundDecoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor),
                    customSize: MediaQuery.of(context).size * 2.2,
                  ),
                  Positioned(
                    top: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).orientation ==
                                        Orientation.portrait
                                    ? MediaQuery.of(context).size.width * 0.3
                                    : MediaQuery.of(context).size.width * 0.2),
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Color(0x99ffffff),
                                borderRadius: BorderRadius.circular(8),
                                border:
                                    Border.all(color: Colors.brown, width: 2)),
                            child: Column(
                              children: [
                                ClassInfoTextDataContainer(
                                  thisTimeData: thisTimeData[0],
                                  nextTimeData: nextTimeData[0],
                                  currentIndex: currentIndex,
                                  needBottomBorder: true,
                                ),
                                ClassInfoTextDataContainer(
                                  thisTimeData: thisTimeData[1],
                                  nextTimeData: nextTimeData[1],
                                  currentIndex: currentIndex,
                                  needBottomBorder: true,
                                ),
                                ClassInfoTextDataContainer(
                                  thisTimeData: thisTimeData[2],
                                  nextTimeData: nextTimeData[2],
                                  currentIndex: currentIndex,
                                  needBottomBorder: false,
                                ),
                              ],
                            ),
                          ),
                          if (_parentIdForMemoScreen != null)
                            TextButton(
                              onPressed: () async {
                                MemoDatabase db = Provider.of<MemoDatabase>(
                                  context,
                                  listen: false,
                                );
                                await db.getinitDatabase();
                                await db.settingMemosByClassID(
                                    _parentIdForMemoScreen!);
                                Navigator.of(context).pushNamed(MemoScreen.id,
                                    arguments: _parentIdForMemoScreen);
                              },
                              child: const CircleAvatar(
                                maxRadius: 18,
                                backgroundColor: Colors.blue,
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Icon(Icons.bookmark_add,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.brown,
        onPressed: () {
          Navigator.pushReplacementNamed(context, TimeTableScreen.id);
        },
        child: Icon(
          Icons.apps_rounded,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              spreadRadius: 8,
              offset: Offset(0, -3))
        ]),
        child: BottomAppBar(
          elevation: 20,
          shape: CircularNotchedRectangle(),
          notchMargin: 9,
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Padding(
            padding:
                const EdgeInsets.only(top: 4, right: 16, bottom: 8, left: 16),
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
                      AnimatedSize(
                        duration: Duration(milliseconds: 400),
                        child: Icon(
                          Icons.arrow_drop_down_circle_outlined,
                          color: _thisClassIconColor,
                          size: _thisClassIconSize,
                        ),
                      ),
                      SizedBox(width: 8),
                      AnimatedDefaultTextStyle(
                        style: _thisClassTextStyle,
                        duration: Duration(milliseconds: 300),
                        child: Text(
                          "This Class",
                        ),
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
                      AnimatedDefaultTextStyle(
                        style: _nextClassTextStyle,
                        duration: Duration(milliseconds: 300),
                        child: Text(
                          "Next Class",
                        ),
                      ),
                      AnimatedSize(
                        duration: Duration(milliseconds: 400),
                        child: Icon(
                          Icons.navigate_next,
                          color: _nextClassIconColor,
                          size: _nextClassIconSize,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

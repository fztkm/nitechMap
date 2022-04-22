import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Memo {
  int? id = 0;
  int parentClassId; //どの授業についてのメモであるかを判別。ClassDataのidをセット
  String title;
  String bodyText;
  Memo({
    this.id,
    required this.parentClassId,
    required this.title,
    required this.bodyText,
  });

  Map<String, dynamic> toMap() {
    return {
      "parent": parentClassId,
      "title": title,
      "body": bodyText,
    };
  }
}

class MemoDatabase with ChangeNotifier {
  int selectedClassID = 0;

  //この配列に現在表示したいメモ情報（授業ごとの）を格納する。
  List<Memo> _selectedMemoList = <Memo>[];
  //全てのメモを扱うための配列だが、現時点では未使用.
  List<Memo> _allMemoList = <Memo>[];

  List<Memo> getSelectedMemoList() {
    return _selectedMemoList;
  }

  List<Memo> getAllMemoList() {
    return _allMemoList;
  }

  var database;

  //一番最初にやる。データベースに接続する
  Future<void> getinitDatabase() async {
    database = await openMemoDatabase();
  }

  //データベースに接続 getinitDatabaseでdatabase変数に代入する
  Future<Database> openMemoDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'memo_databese.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE memo(id INTEGER PRIMARY KEY AUTOINCREMENT,parent INTEGER, title TEXT, body TEXT)",
        );
      },
      version: 1,
    );
  }

  //メモをデータベースに挿入
  Future<void> insertMemo(Memo memo) async {
    final Database db = await database;
    await db.insert(
      'memo',
      memo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    //idは自動生成なので、memo.id = null
    //_memoList.add(memo);　<- これだとダメ

    //更新されたメモリストをセットし直す.
    getMemosByClassID(memo.parentClassId);
    notifyListeners();
  }

  //全てのメモを取得し、_allMemoListに格納
  //使用されていない関数
  Future<void> settingAllMemos() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('memo');
    List<Memo> allMemos = List.generate(maps.length, (i) {
      return Memo(
          id: maps[i]['id'],
          parentClassId: maps[i]['parent'],
          title: maps[i]['title'],
          bodyText: maps[i]['body']);
    });
    _allMemoList = allMemos;
  }

  //TimeTableのIDから検索
  //授業ごとのメモのリストを_selectedMemoListに格納
  Future<void> getMemosByClassID(int parentId) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query('memo', where: "parent = ?", whereArgs: [parentId]);
    List<Memo> memo = List.generate(maps.length, (i) {
      return Memo(
        id: maps[i]['id'],
        parentClassId: maps[i]['parent'],
        title: maps[i]['title'],
        bodyText: maps[i]['body'],
      );
    });
    _selectedMemoList = memo;
  }

  //データの更新
  Future<void> updateMemo(Memo memo) async {
    // Get a reference to the database.
    final db = await database;
    await db.update(
      'memo',
      memo.toMap(),
      where: "id = ?",
      whereArgs: [memo.id],
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
    int index =
        _selectedMemoList.lastIndexWhere((element) => element.id == memo.id);
    print("memo.id ${memo.id} $index");
    _selectedMemoList.forEach((memo) {
      print(
          "${memo.id},${memo.title}, ${memo.bodyText}, ${memo.parentClassId}");
    });
    print("_memoList[index].id : ${_selectedMemoList[index].id}");
    _selectedMemoList[index] = memo;
    notifyListeners();
  }

  //データの削除
  Future<void> deleteMemo(int id) async {
    final db = await database;
    await db.delete(
      'memo',
      where: "id = ?",
      whereArgs: [id],
    );
    _selectedMemoList.removeWhere((memo) => memo.id == id);
    notifyListeners();
  }

  //TimeTableのIDで検索して削除する（ある授業に対応するメモを全て消す）
  Future<void> deleteAllMemoAtClass(int parentId) async {
    final db = await database;
    await db.delete(
      'memo',
      where: "parent = ?",
      whereArgs: [parentId],
    );
    notifyListeners();
  }
}

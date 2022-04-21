import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Memo {
  int id;
  int parentClassId; //どの授業についてのメモであるかを判別。ClassDataのidをセット
  String title;
  String bodyText;
  Memo({
    required this.id,
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
    notifyListeners();
  }

  //メモを取得
  Future<List<Memo>> getMemos() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('memo');
    return List.generate(maps.length, (i) {
      return Memo(
          id: maps[i]['id'],
          parentClassId: maps[i]['parent'],
          title: maps[i]['title'],
          bodyText: maps[i]['body']);
    });
  }

  //TimeTableのIDから検索(授業ごとのメモのリストを返す)
  Future<List<Memo>> getMemosByClassID(int parentId) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query('memo', where: "parent = ?", whereArgs: [parentId]);
    return List.generate(maps.length, (i) {
      return Memo(
        id: maps[i]['id'],
        parentClassId: maps[i]['parent'],
        title: maps[i]['title'],
        bodyText: maps[i]['body'],
      );
    });
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

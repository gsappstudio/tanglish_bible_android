import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tanglis_bible_mobileapp/model/bookmark_model.dart';

class bDatabaseProvider{
  bDatabaseProvider._();
  static final bDatabaseProvider bdb = bDatabaseProvider._();
  static Database? _database;

  Future<Database?> get database async{
    if(_database != null){
      return _database;
    }
    _database = await initDB();
    return _database;
  }
  initDB() async{
    return await openDatabase(join(await getDatabasesPath(),  "bookmark_app.db"),
        onCreate: (bdb, version) async {
          await bdb.execute('''
CREATE TABLE bookmark (bid INTEGER PRIMARY KEY AUTOINCREMENT, btitle TEXT, bbody TEXT)''');
        }, version: 1);
  }
  addNewBookmark(BookmarkModel note) async{
    final bdb = await database;
    bdb?.insert("bookmark", note.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }
  Future<dynamic> getBookmark() async{
    final bdb = await database;
    var res = await bdb?.query("bookmark");
    if(res?.length == 0)
    {
      return Null;
    }
    else{
      var resultMap = res?.toList();
      return resultMap;
    }
  }
  Future<int?> deleteBookmark(int bid) async{
    final bdb = await database;
    int? count = await bdb?.rawDelete("DELETE FROM bookmark WHERE bid = ?", [bid]);
    return count;
  }
}


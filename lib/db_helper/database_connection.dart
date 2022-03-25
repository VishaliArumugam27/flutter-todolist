import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:path/path.dart';

class DatabaseHelper {

  Future<Database> setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'db_todo');
    var database = await openDatabase(path,version: 1,onCreate: _createDatabase);
    return database;
  }

  Future<void> _createDatabase(Database database, int version) async{
    String sql =
        "CREATE TABLE task_table (Id INTEGER PRIMARY KEY, task TEXT);";
    await database.execute(sql);
  }
}
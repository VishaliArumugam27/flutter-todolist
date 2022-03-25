import 'package:sqflite/sqflite.dart';
import 'package:todo_sqflite/db_helper/database_connection.dart';

class SupportingHelper{

  late DatabaseHelper _databaseHelper;

  SupportingHelper(){
    _databaseHelper = DatabaseHelper();
  }

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _databaseHelper.setDatabase();
      return _database;
    }
  }

  //Insert data
  insertData(table, data) async {
    var connection = await database;
    return await connection?.insert(table, data);
  }

  //Fetch data
  fetchData(table) async{
    var connection = await database;
    return await connection?.query(table);
  }

  //Updata data
  updateData(table, data) async{
    var connection = await database;
    return await connection?.update(table, data, where: 'id=?', whereArgs: [data['id']]);
  }

  //Delete data
  deleteData(table, itemId) async{
    var connection = await database;
    return await connection?.rawDelete("delete from $table where id = $itemId");
  }

}
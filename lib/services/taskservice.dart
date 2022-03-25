import 'package:todo_sqflite/db_helper/repositary.dart';
import 'package:todo_sqflite/model/db_model.dart';

class TodoService{

  late SupportingHelper _supportingHelper;
  TodoService() {
    _supportingHelper = SupportingHelper();
  }

  //save todos
  saveTodo(Taskclass todo) async{
    return await _supportingHelper.insertData("task_table", todo.toMap());
  }

  //fetch todos
  fetchAllTodo() async{
    return await _supportingHelper.fetchData("task_table");
  }

  deleteTodo(todoId) async{
    return await _supportingHelper.deleteData("task_table", todoId);
  }

  updateTodo(Taskclass todo) async {
    return await _supportingHelper.updateData("task_table", todo.toMap());
  }

}
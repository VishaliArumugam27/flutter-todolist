import 'package:flutter/material.dart';
import 'package:todo_sqflite/model/db_model.dart';
import 'package:todo_sqflite/services/taskservice.dart';

class EditPage extends StatefulWidget {
  final Taskclass task;
  const EditPage({Key? key,required this.task}) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  TextEditingController updateController = TextEditingController();
  final _todoService = TodoService();

  @override
  void initState() {
    setState(() {
      updateController.text = widget.task.task ?? '';
    });
    super.initState();
  }

  updateTodo() async{
    var _todo = Taskclass();
    _todo.id = widget.task.id;
    _todo.task = updateController.text;
    var result = await _todoService.updateTodo(_todo);
    Navigator.pop(context,result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Text(
              'Enter Here:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: TextField(
              controller: updateController,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20, 50, 20, 10),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: ElevatedButton(
              onPressed: () {
                updateTodo();
              },
              child: const Text('EDIT'),
              style: ElevatedButton.styleFrom(
                primary: Colors.greenAccent[400],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

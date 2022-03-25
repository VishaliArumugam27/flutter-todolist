import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_sqflite/model/db_model.dart';
import 'package:todo_sqflite/services/taskservice.dart';
import 'package:todo_sqflite/pages/edit.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController addController = TextEditingController();

  final _todoService = TodoService();
  late List<Taskclass> _todoList;

  void addTodo() async{
    var _todo = Taskclass();
    _todo.task = addController.text;
    await _todoService.saveTodo(_todo);
    addController.clear();
    //print(result);
    getAllTodo();
  }
  getAllTodo() async{
    var item = await _todoService.fetchAllTodo();
    _todoList = <Taskclass>[];
    setState(() {
      item.forEach((note) {
        var todoModel = Taskclass();
        todoModel.id = note['Id'];
        todoModel.task = note['task'];
        _todoList.add(todoModel);
      });
    });
  }
  @override
  void initState() {
    getAllTodo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TODO APP',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
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
              controller: addController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(

                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: ElevatedButton(
              onPressed: () {
                addTodo();
              },
              child: const Text('ADD'),
              style: ElevatedButton.styleFrom(
                primary: Colors.greenAccent[400],
              ),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: _todoList.isEmpty
                   ?const Center(
                       child: Text(
                           'No Task',
                          style: TextStyle(fontSize: 30),
                ),
              ) :ListView.builder(
                itemCount: _todoList.length,
                itemBuilder: (context, position) {
                    return Card(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text('${_todoList[position].id}'),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(9.0),
                                child: Text(_todoList[position].task ?? '',
                                style: TextStyle(
                                  fontSize: 25.0,
                                ),),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(9.0),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    await Navigator.push(
                                        context, MaterialPageRoute(
                                        builder: (context) {
                                          return EditPage(
                                              task: _todoList[position]);
                                        }));
                                    getAllTodo();
                                  },
                                  child: const Text('EDIT',
                                    style: TextStyle(color: Colors.white),),
                                  style:  ElevatedButton.styleFrom(
                                    primary: Colors.blueAccent[100],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(9.0),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    var r = await _todoService.deleteTodo(_todoList[position].id);
                                    getAllTodo();
                                  },
                                  child: const Text('DELETE'),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );

                },
              ),
            ),
          ),
        ],
      ),

    );
  }
}

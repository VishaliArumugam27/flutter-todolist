import 'package:flutter/material.dart';
import 'package:todo_sqflite/pages/home.dart';

void main(){
  return runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TODO - SQFLITE',
      home: HomePage(),
    );
  }
}


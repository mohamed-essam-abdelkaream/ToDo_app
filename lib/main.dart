import 'package:flutter/material.dart';
import 'package:todo_app/presentation/addNotes.dart';
import 'package:todo_app/presentation/editNotes.dart';
import 'package:todo_app/presentation/homePage.dart';
void main(){
  runApp(TodoApp());
}
class TodoApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      routes: {
        'AddNotes':(context)=>AddNotes(),
        'EditNotes':(context)=>EditNotes(),
      },
    );
  }
}
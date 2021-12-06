import 'package:flutter/material.dart';
import 'package:flutter_not_keeper_app/screen/notes.dart';

void main() {
  runApp(myapp(

  ));
}

//
class myapp extends StatefulWidget {
  const myapp({Key? key}) : super(key: key);
  @override
  _myappState createState() => _myappState();
}

class _myappState extends State<myapp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        primaryColor: Colors.deepPurple,
      ),
      title: "note keepr app",
      home:Container(
      
        child:notes() ,
      ),
    );
  }
}

//performing ayncronus programing in Dart
 printContent() {
  Future<String>results= downloadfile();
  print("the furure value is->$results");
}

Future<String>downloadfile(){
  Future<String>results=Future.delayed(Duration(seconds: 6),(){
    return "String of delayed items";
  });
  return results;
}

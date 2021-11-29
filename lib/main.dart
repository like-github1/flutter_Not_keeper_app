import 'package:flutter/material.dart';
import 'package:flutter_not_keeper_app/screen/notes.dart';

void main(){
  runApp(myapp());
}
//
class myapp extends StatefulWidget {
  const myapp({Key? key}) : super(key: key);@override
  _myappState createState() => _myappState();
}

class _myappState extends State<myapp> {
  @override
  Widget build(BuildContext context) {



    return  MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          primaryColor: Colors.deepPurple,
      ),
        title: "note keepr app",
        home:notes(),
    );
  }

}

//
Future<String>printFutureString(){
  Future<String>result=Downloadfile();
  return result;
}
 Future<String>Downloadfile(){
  return Future.delayed(const Duration(seconds: 6),(){
    return "this is the Downloadedd string after 6 second";
  });
 }
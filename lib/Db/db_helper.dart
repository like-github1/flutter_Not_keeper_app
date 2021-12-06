import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_not_keeper_app/modelclass/databasemode.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class dbhelper {
  //singelton database instances
  static Database? _database;
  String tablename = "nottable";
  String colid = "colid";
  String coltitle = "title";
  String coldescription = "description";
  String coldate = "date";
  String colpri = "pri";

  dbhelper._privateConstructor();
  static final dbhelper instance = dbhelper._privateConstructor();
  factory dbhelper() {
    return instance;
  }
  Future<Database> initializedatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "note.db";
    var result = openDatabase(path, version: 1, onCreate: _create);
    return result;
  }

  void _create(Database db, int version) async {
    await db.execute(
        "Create Table $tablename($colid int PRIMERYKEY AUTOINCREMENT,$coltitle TEXT, $coldescription TEXT, $coldate Text, $colpri Text)");
  }

  //getter for database
  get database async {
    _database ??= await initializedatabase();
    return _database;
  }

//fetch all element from the database
  Future<List<Map<String, dynamic>>> getnotlist() {
    Database db = database;
    var result = db.rawQuery("SELECT * FROM $tablename order $colpri ASC");
    return result;
  }

  //database insert operations
  Future<int> insert(modelclass model) async {
    Database db = database;
    var result = await db.insert(tablename, model.map());
    return result;
  }

  Future<int> update(modelclass model) async {
    Database db = database;
    var result = await db.update(tablename, model.map(),
        where: "$colid=?", whereArgs: [model.id]);
    return result;
  }

  Future<int> delete(int id) async {
    Database db = database;
    var result = await db.rawDelete("DELETE FROM $tablename WHERE $colid=$id");
    return result;
  }

  //total number of item in the database
  //total  number of recored
  Future<int?> getcount(int id) async {
    Database db = database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT(*) FROM $tablename');
    int? result = Sqflite.firstIntValue(x);
    return result;
  }

  //converting database item to modelclass items
  Future<List<modelclass>> convert() async {
    List<Map<String, dynamic>> modellist = await getnotlist();
    int count = modellist.length;
    List<modelclass> notelist = <modelclass>[];
    for (int i = 0; i < count; i++) {
      notelist.add(modelclass.fromMap(modellist[i]));
    }
    return notelist;
  }
}

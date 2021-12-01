import 'dart:io';
import 'package:flutter_not_keeper_app/modelclass/databasemode.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
class dbhelper{
static  late dbhelper _dbhelper;
static late  Database _database;//singelton database
String tablename="notetable";
String colid="id";
String colTitle="title";
String colDescription="description";
String coldate="date";
String colpriority="priority";
dbhelper._CreateInstance();//private constructor to to creat a singelton class
 factory dbhelper(){
  _dbhelper ??= dbhelper._CreateInstance(); //instance of singelton class
  return _dbhelper;
 }
 //initialize the database which means find the path of the database
//open the database at that locations
//path where database is created
Future<Database>initializedatabase()async{
 Directory directory=await getApplicationDocumentsDirectory();//find the databas directory
 String path= directory.path+"notekeertdatabasr";

 Future<Database> notedatabase= openDatabase(path,version: 1,onCreate: _createDatabase);
 return notedatabase;

}
//Creating Table a given database
void _createDatabase(Database db,int version){
  db.execute("Create Table $tablename($colid INTIGER PRIMERY KEY AUTOINCREMENT,$colTitle TEXT, $colDescription Text, $colpriority Int,$coldate IntT )");
}
//getter for our database
Future<Database>get getdatabase async{
  _database ??= await initializedatabase();
  return _database;
}
//CRUD-OPERATION
//Fetch all data-from database
Future<List<Map<String,dynamic>>>getMapList()async{
  Database db= await getdatabase;
  var results= await db.query(tablename,orderBy: "$colpriority ASC");
  return results;
  
}
//inserting element to the database
Future<int>insertnote(notmodel note)async{
  Database db= await getdatabase;
  var result= db.insert(tablename, note.map());
  return result;
}
//update operations
Future<int>update(notmodel note)async{
  Database db= await getdatabase;
  var result= db.update(tablename, note.map(),where: "$colid=?",whereArgs: [note.id]);
  return result;
}
//delete operation
Future<int>Deleteobjetc(int id)async{
  Database db= await getdatabase;
  var results= db.rawDelete("DELETE FROM $tablename WHERE $colid= $id");
  return results;
}
//Finding the number of record in the database
gettotlaRecord()async{
  Database db= await getdatabase;
  List<Map<String, dynamic>>x= await db.rawQuery("SELECT COUNT(*) FROM $tablename");
   var results= Sqflite.firstIntValue(x);
   return results;
}
//get all list from database and conver to notlist object filed
 Future<List<notmodel>>getAlllistfromDtabase()async{
    var changednotlist= await getMapList();
    int count= changednotlist.length;
    List<notmodel>notelist= <notmodel>[];//empty notelist
for(int i=0;i<count;i++){
  notelist.add(notmodel.frommap(changednotlist[i]));

}
return notelist;
 }

}
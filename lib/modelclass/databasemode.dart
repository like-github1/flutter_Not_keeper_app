class modelclass{

  late int _id;
  late String _title;
  late String _description;
  late String _date;
  late int _priority;
  modelclass(this._title,this._date,this._priority,[this._description="your have no dec yet"]);
//adding seter and getter fot database model class
  //getter is used to get the value of the class fileld

  int get id=>_id;
  String get title=>_title;
  String get description=>_description;
  String get date=>_date;
  int get priority=>_priority;
  //setter is used to set the value of the class field
 set settitles(String newTitle){
   if(newTitle.length<=255){
     this._title= newTitle;
   }

 }
set description(String desc){
   if(desc!.isEmpty){
     this._description=desc;
   }
 }

 set priority(int pri){
    if(pri>=1&&pri<=2){
      this._priority=pri;
    }

  }

  set date(String newDate){
   this._date=newDate;
 }
 //let us create a method to add data to data base as map object
Map<String,dynamic>tomap(){
   var map= Map<String,dynamic>();
   if(id!=null){
     map['id']=this.id;
   }
   map['title']=this._title;
   map['desc']=this._description;
   map['date']=this._date;
   map['pri']=this._priority;
return map;
}
//inorder to retrive data from database youneed to conver map to simple data
 //Extract modelclass objetc from map object
  modelclass.fromMapobject(Map<String,dynamic>map){
   _id=map['id'];
   _title=map['title'];
   _description=map['desc'];
   _date=map['date'];
   _priority=map['pri'];

  }










}
//sqflite plugins only store data to a database in map form
//convert simple object in to map object
//to retrevie data you gan get in map form
//convert map to simple form
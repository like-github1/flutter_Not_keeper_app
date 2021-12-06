class modelclass{
  late int _id;
  late String _title;
  late String _description;
  late String _date;
  late int _priority;
  modelclass(this._id,this._title,this._description,this._date,this._priority);
  //getter
get id=>_id;
String get title=>_title;
String get description=>_description;
String get date=>_date;
int get priority=>_priority;
//setter is used to set value
set title(String newtitle){
  _title=newtitle;
}
  set description(String desc){
    _title=desc;
  }
  set date(String date){
    _title=date;
  }
  set priority(int pri){
  _priority=pri;
  }
  //tomap and from map
Map<String,dynamic>map(){
  var map=Map<String, dynamic>();
if(id!=null){
  map["id"]=_id;
  }
  map["title"]=_title;
  map["description"]=_description;
  map["date"]=_date;
  map['priority']=_priority;
  return map;
}
//frommap object
modelclass.fromMap(Map<String,dynamic>map){
  _id=map["id"];
  _title=map['title'];
  _description=map["description"];
  _date=map['date'];
  priority=map["pri"];

}
}
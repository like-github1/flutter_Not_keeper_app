class notmodel {

  late int _id;
  late String _title;
  late String _description;
  late String _date;
  late int _priority;
  notmodel(this._id, this._title,  this._date,this._priority, [this._description = "you haven't description yet"]);

  //setter and getter
//getter
  int get id => _id;
  String get title => _title;
  String get description => _description;
  String get date => _date;
  int get priority => _priority;
//setter
  set title(String newTitle) {
    if (newTitle.length <= 100) {
      _title = newTitle;
    }
  }

  set Description(String newDescription) {
    _title = newDescription;
  }

  set date(String Date) {
    _title = Date;
  }

  set priority(int newpriority) {
    _priority = newpriority;
  }

  //String to map-only mao from is added to the sqflite database
  Map<String, dynamic> map() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map["title"] = _title;
    map['description'] = _description;
    map["date"] = _date;
    map['priority'] = _priority;
    return map;
  }

//fetch form sqlf lite database
  notmodel.frommap(Map<String, dynamic> map) {
    _id = map['id'];
    _title = map["title"];
    _description = map["description"];
    _date = map['date'];
    _priority = map['priority'];
  }
}

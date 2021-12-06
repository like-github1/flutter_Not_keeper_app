import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_not_keeper_app/Db/db_helper.dart';
import 'package:flutter_not_keeper_app/modelclass/databasemode.dart';
import 'package:intl/intl.dart';

class notedetailspage extends StatefulWidget {
  final String title;
  final modelclass notes;

  notedetailspage(this.notes, this.title, {Key? key}) : super(key: key);

  @override
  _notedetailspageState createState() =>
      _notedetailspageState(this.notes, this.title);
}

class _notedetailspageState extends State<notedetailspage> {
  final List<String> _priority = <String>["high", "low"];
  dbhelper dbhelpers = dbhelper();
  String appbattitle;
  modelclass notes;
  _notedetailspageState(this.notes, this.appbattitle);
  String defaultvalue = "high";
  TextEditingController titletextEditingController = TextEditingController();
  TextEditingController descriptiontextEditingController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    titletextEditingController.text = notes.title;
    descriptiontextEditingController.text = notes.description;

    return Scaffold(
      appBar: AppBar(
        title: Text(appbattitle),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            movetoLastscreen();
          },
        ),
      ),
      body: getlistview(),
    );
  }

  //converting from String to Intiger Priority
  void updatePrioritynumberto(String value) {
    switch (value) {
      case "high":
        notes.priority = 1;
        break;
      case "low":
        notes.priority = 2;
        break;
      default:
    }
  }

  //converting from String to Intiger Priority
  String getPriority(int value) {
    late String Priority;
    switch (value) {
      case 1:
        Priority = _priority[0];
        break;
      case 2:
        Priority = _priority[1];
        break;
      default:
    }
    return Priority;
  }

  Widget getlistview() {
    Widget listview = ListView(
      children: <Widget>[
        // ListTile(
        //   title: DropdownButton<String>(
        //     items: _priority.map((e) {
        //       return DropdownMenuItem(
        //         child: Text(e),
        //         value: e,
        //       );
        //     }).toList(),
        //     value: getPriority(notes.priority)
        //     ),
        //     onChanged: (String? changedvalue) {
        //       setState(() {
        //         print(changedvalue);
        //         defaultvalue = changedvalue!;
        //       });
        //     },
        //   ),
        // )
        Padding(
          padding: EdgeInsets.all(8),
          child: TextField(
            controller: titletextEditingController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              labelText: "title",
            ),
            onChanged: (value) {
              updatetitle();
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: TextField(
            controller: titletextEditingController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              labelText: "Descriptions",
            ),
            onChanged: (value) {
              updateDescription();
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: ElevatedButton(
                  onPressed: () => _save(),
                  child: const Text("Save"),
                ),
              ),
              const SizedBox(
                width: 5.0,
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: ()=>_delete(),
                  child: const Text("Delete"),
                ),
              ),
            ],
          ),
        )
      ],
    );
    return listview;
  }

  void _save() async {
    movetoLastscreen();
    notes.date = DateFormat.yMMMd().format(DateTime.now());
    if (notes.id != null) {
      await dbhelpers.update(notes);
      _showAlerdialog("status", "saved sucessfully");
    } else {
      await dbhelpers.insert(notes);
      _showAlerdialog("status", "saved sucessfully");
    }
  }

  void updatetitle() {
    notes.title = titletextEditingController.text;
  }

  void updateDescription() {
    notes.description = descriptiontextEditingController.text;
  }

  movetoLastscreen() {
    Navigator.pop(context,true);
  }

  void _showAlerdialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  void _delete() async {
    movetoLastscreen();
    if (notes.id == null) {
      _showAlerdialog("status", "not not deleted");
      return;
    }
    int result = await dbhelpers.delete(notes.id);
    if (result != 0) {
      _showAlerdialog("status", "message deleted");
    } else {
      _showAlerdialog("status", "Erroe occure while deleting");
    }
  }
}

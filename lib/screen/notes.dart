import 'package:flutter/material.dart';
import 'package:flutter_not_keeper_app/Db/db_helper.dart';
import 'package:flutter_not_keeper_app/modelclass/databasemode.dart';
import 'package:sqflite/sqflite.dart';

import 'detailsscren.dart';

class notes extends StatefulWidget {
  const notes({Key? key}) : super(key: key);

  @override
  _notesState createState() => _notesState();
}

class _notesState extends State<notes> {
  dbhelper dbhelpers = dbhelper();
  List<modelclass> notelist = <modelclass>[]; //Empty list
  int count = 0;
  @override
  Widget build(BuildContext context) {
    if (notelist.isEmpty) {
      updatelistview();
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text("not keper ap"),
          centerTitle: true,
        ),
        resizeToAvoidBottomInset: false,
        body: getNotListView(),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            tooltip: "add it now",
            onPressed: () {
              routepage(modelclass(1, "", "", "",4), "add note");
            }));
  }

  void routepage(modelclass notemodels, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return notedetailspage(notemodels, title);
        },
      ),
    );
  }

  ListView getNotListView() {
    return ListView.builder(
        itemCount: 0,
        itemBuilder: (BuildContext context, index) {
          return Card(
            color: Colors.white,
            elevation: 3,
            child: ListTile(
              onTap: () {
                routepage(notelist[index], "Edit note");
              },
              title: Text(notelist[index].title),
              leading: CircleAvatar(
                  backgroundColor: getPrioritycolor(notelist[index].priority),
                  child: getPriorityIcon(notelist[index].priority)),
              subtitle: Text(notelist[index].date),
              trailing: GestureDetector(
                onTap: () {
                  _delete(context, notelist[index]);
                },
                child: const Icon(
                  Icons.delete,
                  color: Colors.grey,
                ),
              ),
            ),
          );
        });
  }

  //generating colors based on priority
  Color getPrioritycolor(int Priority) {
    switch (Priority) {
      case 1:
        return Colors.red;
        break;
      case 2:
        return Colors.yellow;
        break;
      default:
        return Colors.yellow;
    }
  }

//generatinf Icons based on priority
  Icon getPriorityIcon(int priority) {
    switch (priority) {
      case 1:
        return Icon(Icons.play_arrow);
        break;
      case 2:
        return Icon(Icons.keyboard_arrow_right);
        break;
      default:
        return Icon(Icons.keyboard_arrow_right);
    }
  }

  void _delete(BuildContext context, modelclass model) async {
    Future<int> result = dbhelpers.delete(model.id);
    if (result != 0) {
      _showsnackbar(context, 'item deleted successfully');
      updatelistview();
    }
  }

  void updatelistview() {
    Future<Database> dbfuture = dbhelpers.initializedatabase();
    dbfuture.then((Dtabase) {
      Future<List<modelclass>> notelist = dbhelpers.convert();
      notelist.then((notelist) {
        setState(() {
          notelist = notelist;
          count = notelist.length;
        });
      });
    });
  }

  void _showsnackbar(BuildContext context, String string) {
    final snackBar = SnackBar(content: Text(string));
    Scaffold.of(context).showSnackBar(snackBar);
  }
}

import 'package:flutter/material.dart';

import 'detailsscren.dart';

class notes extends StatefulWidget {
  
  const notes({Key? key}) : super(key: key);

  @override
  _notesState createState() => _notesState();
}

class _notesState extends State<notes> {
  List<String> items = <String>['tshome', 'zewede'];
  @override
  Widget build(BuildContext context) {
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
              routepage("add note");
            }));
  }

  void routepage(String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return notedetailspage(title);
        },
      ),
    );
  }

  ListView getNotListView() {
    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.white,
            elevation: 3,
            child: ListTile(
              onTap: () {
                routepage("Edit note");
              },
              title: Text(items[index]),
              leading: const CircleAvatar(
                backgroundColor: Colors.yellow,
                child: Icon(Icons.keyboard_arrow_right),
              ),
              subtitle: const Text('put your note here'),
              trailing: const Icon(
                Icons.delete,
                color: Colors.grey,
              ),
            ),
          );
        });
  }
}

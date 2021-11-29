import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class notedetailspage extends StatefulWidget {
  String title;
 notedetailspage(this.title,{Key? key}) : super(key: key);

  @override
  _notedetailspageState createState() => _notedetailspageState(this.title);
}
class _notedetailspageState extends State<notedetailspage> {
  String appbattitle;
  _notedetailspageState(this.appbattitle);
  String defaultvalue = "high";
  TextEditingController titletextEditingController = TextEditingController();
  TextEditingController descriptiontextEditingController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(appbattitle),
          centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: (){
            movetoLastscreen();
          },
        ),
        ),
        body: getlistview(),
      );

  }

  Widget getlistview() {
    Widget listview = ListView(
      children: <Widget>[
        ListTile(
          title: DropdownButton<String>(
            items: <String>["high", "low"].map((e) {
              return DropdownMenuItem(
                child: Text(e),
                value: e,
              );
            }).toList(),
            value: defaultvalue,
            onChanged: (String? changedvalue) {
              setState(() {
                print(changedvalue);
                defaultvalue = changedvalue!;
              });
            },
          ),
        ),
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
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text("Save"),
                ),
              ),
              const SizedBox(
                width: 5.0,
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
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

   movetoLastscreen() {
    Navigator.pop(context);

  }
}

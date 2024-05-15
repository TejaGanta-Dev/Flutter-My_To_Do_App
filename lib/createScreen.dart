import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_app/model.dart';
import 'package:to_do_app/utilities/utilities.dart';

class CreateTODO extends StatefulWidget {
  late String appbarTitle;
  late String title;
  late String description;
  late String selectedStatus;
  CreateTODO(
      this.appbarTitle, this.title, this.description, this.selectedStatus,
      {super.key});
  @override
  State<CreateTODO> createState() =>
      _CreateTODOState(appbarTitle, title, description, selectedStatus);
}

class _CreateTODOState extends State<CreateTODO> {
  List myStatusList = ['Pending', 'Completed'];
  Object? selectedStatus = 'Pending';
  String titleString = '';
  String descriptionString = '';
  String appbarTitle;
  late TextEditingController title = TextEditingController(text: titleString);
  late TextEditingController description =
      TextEditingController(text: descriptionString);

  _CreateTODOState(this.appbarTitle, this.titleString, this.descriptionString,
      this.selectedStatus);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appbarTitle),
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            DropdownButton(
                value: selectedStatus,
                items: myStatusList
                    .map((e) => DropdownMenuItem(
                          child: Text(e),
                          value: e,
                        ))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    selectedStatus = val;
                  });
                }),
            const SizedBox(
              height: 20.0,
            ),
            TextField(
              controller: title,
              decoration: const InputDecoration(
                  hintText: 'Enter Title',
                  labelText: 'Title',
                  border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextField(
              controller: description,
              decoration: const InputDecoration(
                  hintText: 'Enter Description',
                  labelText: 'Description',
                  border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 20.0,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    createToDo();
                  },
                  child: Text(
                    appbarTitle,
                    style: TextStyle(color: Colors.blue),
                  )),
            )
          ],
        ),
      ),
    );
  }

  createToDo() {
    validate(selectedStatus);
    print("${title.text} ${description.text} $selectedStatus");
  }

  validate(selectedStatus) {
    Navigator.pop(context, {
      'title': title.text,
      'description': description.text,
      'status': selectedStatus
    });
  }
}

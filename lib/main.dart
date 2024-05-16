import 'package:flutter/material.dart';
import 'package:to_do_app/createScreen.dart';
import 'package:to_do_app/model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomeApp(),
    );
  }
}

class MyHomeApp extends StatefulWidget {
  const MyHomeApp({super.key});
  @override
  State<MyHomeApp> createState() => _MyHomeAppState();
}

class _MyHomeAppState extends State<MyHomeApp> {
  List myToDoList = [
    {
      'title': 'title.text',
      'description': 'description.text',
      'status': 'Completed'
    },
    {
      'title': 'title.text',
      'description': 'description.text',
      'status': 'Pending'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My To Do List'),
        actions: <Widget>[
          Icon(Icons.share),
          SizedBox(width: 30.0),
          Icon(
            Icons.favorite,
            color: Colors.red,
          ),
          SizedBox(width: 20.0),
          PopupMenuButton(
              itemBuilder: (BuildContext context) => [
                    PopupMenuItem(
                      child: Text('Settings'),
                      value: 'Settings',
                    ),
                    PopupMenuItem(
                      child: Text('Logout'),
                      value: 'Logout',
                    )
                  ])
        ],
      ),
      body: getListTiles(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateTocreate(context, 'Create To Do');
        },
        tooltip: 'Create',
        child: const Icon(Icons.add),
      ),
    );
  }

  getListTiles() {
    return ListView.builder(
        itemCount: myToDoList.length,
        itemBuilder: (context, index) {
          return Card(
            color: myToDoList[index]['status'] == "Pending"
                ? Colors.red
                : Colors.green,
            child: GestureDetector(
              onTap: () {
                navigateToUpdate(index, "Update Item");
              },
              child: ListTile(
                leading: myToDoList[index]['status'] == "Pending"
                    ? Icon(Icons.warning, color: Colors.black)
                    : Icon(Icons.done_all, color: Colors.black),
                title: Text(myToDoList[index]['title']),
                subtitle: Text(myToDoList[index]['description']),
                trailing: myToDoList[index]['status'] == "Completed"
                    ? GestureDetector(
                        child: Icon(
                          Icons.delete,
                          color: Colors.black,
                        ),
                        onTap: () {
                          deleteItem(index);
                        },
                      )
                    : null,
              ),
            ),
          );
        });
  }

  deleteItem(index) {
    setState(() {
      myToDoList.removeAt(index);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Item Deleted Successfully")));
    });
  }

  navigateToUpdate(int index, String appBarTitle) async {
    Map<String, dynamic>? result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CreateTODO(
                appBarTitle,
                myToDoList[index]['title'],
                myToDoList[index]['description'],
                myToDoList[index]['status'])));
    if (result != null) {
      var data = result as Object;
      setState(() {
        myToDoList[index] = data;
      });
    }
  }

  navigateTocreate(context, appBarTitle) async {
    var title = '';
    Map<String, dynamic>? result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                CreateTODO(appBarTitle, title, title, 'Pending')));
    if (result != null) {
      print(result);
      var data = result as Object;
      setState(() {
        myToDoList.add(data);
      });
    }
  }
}

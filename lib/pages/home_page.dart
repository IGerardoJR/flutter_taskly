import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  HomePage();
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  late double _deviceWidth, _deviceHeigth;
  String? _newTaskContent;

  _HomePageState();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeigth = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.red,
          toolbarHeight: _deviceHeigth * 0.11,
          title: Container(
            alignment: Alignment.center,
            child: const Text(
              'Taskly',
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
          )),
      body: _taskView(),
      floatingActionButton: _addTaskButton(),
    );
  }

  // Tasks widget
  Widget _taskList() {
    return ListView(
      children: [
        ListTile(
            title: const Text("Do Laundry",
                style: TextStyle(decoration: TextDecoration.lineThrough)),
            subtitle: Text(DateTime.now().toString()),
            trailing: Icon(Icons.check_box_outlined, color: Colors.red)),
        ListTile(
            title: const Text("Do Laundry",
                style: TextStyle(decoration: TextDecoration.lineThrough)),
            subtitle: Text(DateTime.now().toString()),
            trailing: Icon(Icons.check_box_outlined, color: Colors.red)),
      ],
    );
  }

  Widget _taskView() {
    return FutureBuilder(
        future: Future.delayed(Duration(seconds: 2)),
        builder: (BuildContext _context, AsyncSnapshot _snapShot) {
          if (_snapShot.connectionState == ConnectionState.done) {
            return _taskList();
          } else {
            return Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator(
                  color: Colors.red,
                  strokeWidth: 6.0,
                  value: null,
                ));
          }
        });
  }

  Widget _addTaskButton() {
    return FloatingActionButton(
      onPressed: _displayTaskButtonPopup,
      backgroundColor: Colors.red,
      child: const Icon(Icons.add),
      foregroundColor: Colors.white,
    );
  }

  void _displayTaskButtonPopup() {
    showDialog(
        context: context,
        builder: (BuildContext _context) {
          return AlertDialog(
            title: const Text('Add new Task!'),
            content: TextField(
              onSubmitted: (_value) {},
              onChanged: (_value) {
                setState(() {
                  _newTaskContent = _value;
                });
              },
            ),
          );
        });
  }
}

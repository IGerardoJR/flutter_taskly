import 'package:f_taskly/models/task.dart';
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
  Box? _box;

  Task _newTask =
      Task(content: "Go to Gym!", timestamp: DateTime.now(), done: true);
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

  Widget _taskView() {
    return FutureBuilder(
        future: Future.delayed(Duration(seconds: 2)),
        builder: (BuildContext _context, AsyncSnapshot _snapShot) {
          if (_snapShot.connectionState == ConnectionState.done) {
            _box = _snapShot.data;
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

  // Tasks widget
  Widget _taskList() {
    _box?.add(_newTask.toMap());
    print('Task: ${_box!.values.toList()}');

    List tasks = _box!.values.toList();
    return ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (BuildContext _context, int index) {
          return ListTile(
              title: const Text("Do Laundry",
                  style: TextStyle(decoration: TextDecoration.lineThrough)),
              subtitle: Text(DateTime.now().toString()),
              trailing: Icon(Icons.check_box_outlined, color: Colors.red));
          ListTile(
              title: Text("Go to Market",
                  style: TextStyle(decoration: TextDecoration.lineThrough)),
              subtitle: Text(DateTime.now().toString()),
              trailing: Icon(Icons.check_box_outlined, color: Colors.red));
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

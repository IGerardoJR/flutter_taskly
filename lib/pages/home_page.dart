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
        // future: Future.delayed(Duration(seconds: 2)),
        future: Hive.openBox('tasks'),
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
    // Task _newTask =
    //     Task(content: "Ir al super!", timestamp: DateTime.now(), done: true);
    // _box?.add(_newTask.toMap());
    // print('Task: ${_box!.values.toList()}');

    // List tasks = List.empty(growable: true);
    List tasks = _box!.values.toList();

    return ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (BuildContext _context, int index) {
          var task = Task.fromMap(tasks[index]);
          print(task);
          return ListTile(
              title: Text(task.content,
                  style: TextStyle(
                      decoration:
                          task.done ? TextDecoration.lineThrough : null)),
              subtitle: Text(task.timestamp.toString()),
              trailing: Icon(
                  task.done
                      ? Icons.check_box_outlined
                      : Icons.check_box_outline_blank_outlined,
                  color: Colors.red));
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
              onSubmitted: (_) {
                if (_newTaskContent != null) {
                  var _task = Task(
                      content: _newTaskContent!,
                      timestamp: DateTime.now(),
                      done: false);
                  _box!.add(_task.toMap());

                  setState(() {
                    _newTaskContent = _task.content;
                  });
                }
              },
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

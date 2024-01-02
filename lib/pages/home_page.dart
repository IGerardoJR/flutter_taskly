import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage();
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  late double _deviceWidth, _deviceHeigth;

  _HomePageState();

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
      body: _taskList(),
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

  Widget _addTaskButton() {
    return FloatingActionButton(
      onPressed: () {
        print("Pressed button!");
      },
      backgroundColor: Colors.red,
      child: const Icon(Icons.add),
      foregroundColor: Colors.white,
    );
  }
}

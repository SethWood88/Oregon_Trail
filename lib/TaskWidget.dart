import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:oregon_trail/ClosestLocationWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskWidget extends StatefulWidget {
  const TaskWidget();

  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  List<String> _tasks = [];
  List<bool> _taskStatus = [];
  List<String> _completedTasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _tasks = prefs.getStringList('tasks') ?? [];
      _taskStatus =
          json.decode(prefs.getString('taskStatus') ?? '[]').cast<bool>();
      _completedTasks = prefs.getStringList('completedTasks') ?? [];
    });
    if (_tasks.isEmpty) {
      _generateTasks();
    }
  }

  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('tasks', _tasks);
    prefs.setString('taskStatus', json.encode(_taskStatus));
    prefs.setStringList('completedTasks', _completedTasks);
  }

  void _generateTasks() async {
    String locationNickname =
        await ClosestLocationWidget.getClosestLocationNickname();
    List<String> tasks =
        await ClosestLocationWidget.getTasksForLocation(locationNickname);
    setState(() {
      _tasks = tasks;
      _taskStatus = List.generate(_tasks.length, (index) => false);
    });
  }

  void _handleTaskCheckboxChanged(bool value, int index) {
    setState(() {
      _taskStatus[index] = value;
      if (value) {
        _completedTasks.add(_tasks[index]);
        _tasks.removeAt(index);
        _taskStatus.removeAt(index);
      }
    });
    _saveTasks();
  }

  void _handleCompletedTaskTap(int index) {
    showDeleteDialog(index);
  }

  void showDeleteDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Task'),
          content: Text('Are you sure you want to delete this task?'),
          actions: <Widget>[
            TextButton(
              child: Text('CANCEL'),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text('DELETE'),
              onPressed: () {
                setState(() {
                  _completedTasks.removeAt(index);
                });
                _saveTasks();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _handleCompletedTaskLongPress(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Task'),
          content: Text('Are you sure you want to delete this task?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                setState(() {
                  _completedTasks.removeAt(index);
                });
                _saveTasks();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(color: Colors.black, thickness: 3),
        Text(
          'Tasks to Do',
          style: TextStyle(
            fontSize: 24.0,
            color: Colors.green[900],
            fontWeight: FontWeight.bold,
          ),
        ),
        Divider(color: Colors.black, thickness: 3),
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            physics: BouncingScrollPhysics(),
            itemCount: _tasks.length,
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                key: Key(_tasks[index]),
                child: CheckboxListTile(
                  checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
                  title: Text(_tasks[index], style: TextStyle(color: Colors.brown[700], fontSize: 22)),
                  value: _taskStatus[index],
                  onChanged: (bool value) =>
                      _handleTaskCheckboxChanged(value, index),
                ),
                onDismissed: (direction) =>
                    _handleCompletedTaskLongPress(index),
                background: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                    SizedBox(width: 10),
                  ],
                ),
              );
            },
          ),
        ),
        Divider(color: Colors.black, thickness: 3),
        Text(
          'Completed Tasks',
          style: TextStyle(
            fontSize: 24.0,
            color: Colors.green[900],
            fontWeight: FontWeight.bold,
          ),
        ),
        Divider(color: Colors.black, thickness: 3),
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            physics: BouncingScrollPhysics(),
            itemCount: _completedTasks.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(_completedTasks[index], style: TextStyle(color: Colors.brown[700], fontSize: 22)),
                trailing: Icon(Icons.check, color: Colors.green[900],size: 28),
                onTap: () => _handleCompletedTaskTap(index),
              );
            },
          ),
        ),
      ],
    );
  }
}

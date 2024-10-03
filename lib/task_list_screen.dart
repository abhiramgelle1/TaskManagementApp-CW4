import 'package:flutter/material.dart';
import 'task.dart';

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<Task> tasks = [];

  void _addTask(String taskName) {
    setState(() {
      tasks.add(Task(name: taskName));
    });
  }

  void _toggleTaskCompletion(int index) {
    setState(() {
      tasks[index].isCompleted = !tasks[index].isCompleted;
    });
  }

  void _removeTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Manager'),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            onSubmitted: (value) => _addTask(value),
            decoration: InputDecoration(
              labelText: 'Enter Task Name',
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (_, index) => ListTile(
                title: Text(tasks[index].name),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _removeTask(index),
                ),
                leading: Checkbox(
                  value: tasks[index].isCompleted,
                  onChanged: (_) => _toggleTaskCompletion(index),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

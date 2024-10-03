import 'package:flutter/material.dart';
import 'task.dart'; // Ensure you have a Task model with name, isCompleted, and priority attributes.

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<Task> tasks = [];
  final TextEditingController _taskNameController = TextEditingController();
  String _selectedPriority = 'Low';

  // Helper method to map priority to a numerical value for sorting.
  int _priorityValue(String priority) {
    switch (priority) {
      case 'High':
        return 1;
      case 'Medium':
        return 2;
      case 'Low':
        return 3;
      default:
        return 3; // Default to Low if unknown.
    }
  }

  // Method to add tasks
  void _addTask() {
    final String taskName = _taskNameController.text;
    if (taskName.isNotEmpty) {
      setState(() {
        tasks.add(Task(
            name: taskName, isCompleted: false, priority: _selectedPriority));
        _taskNameController.clear();
        _sortTasks();
      });
    }
  }

  // Method to sort tasks by priority
  void _sortTasks() {
    tasks.sort((a, b) =>
        _priorityValue(a.priority).compareTo(_priorityValue(b.priority)));
  }

  // Method to toggle completion status
  void _toggleTaskCompletion(int index) {
    setState(() {
      tasks[index].isCompleted = !tasks[index].isCompleted;
    });
  }

  // Method to remove tasks
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _taskNameController,
              decoration: InputDecoration(
                labelText: 'Enter Task Name',
                suffixIcon: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedPriority,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedPriority = newValue!;
                      });
                    },
                    items: <String>['Low', 'Medium', 'High']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return ListTile(
                  title: Text(task.name),
                  subtitle: Text('Priority: ${task.priority}'),
                  leading: Checkbox(
                    value: task.isCompleted,
                    onChanged: (bool? value) {
                      _toggleTaskCompletion(index);
                    },
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _removeTask(index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        tooltip: 'Add Task',
        child: Icon(Icons.add),
      ),
    );
  }
}

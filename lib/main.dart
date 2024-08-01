import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(const TodoListApp());
}

class TodoListApp extends StatelessWidget {
  const TodoListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TodoListPage(),
    );
  }
}

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final List<Task> _tasks = [];
  final TextEditingController _textController = TextEditingController();

  void _addTask(String title) {
    if (title.trim().isEmpty) {
      return;
    }
    setState(() {
      _tasks.add(Task(title: title, isComplete: false));
    });
    _textController.clear();
  }

  void _toggleTaskCompletion(Task task) {
    setState(() {
      task.isComplete = !task.isComplete;
    });
  }

  void _deleteTask(Task task) {
    setState(() {
      if(!task.isComplete) {
        _tasks.remove(task);
      }
      else{
        Fluttertoast.showToast(
            msg: "You can't delete the completed task",
            backgroundColor: Colors.grey.shade400,
            // fontSize: 20,
            // gravity: ToastGravity.CENTER,
            textColor: Colors.black
        );
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Expanded(
              child: AlertDialog(
                title: Text('Hey User!'),
                content: Text('Are you sure you want to exit?'),
                actions: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('No'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      exit(0);
                    },
                    child: Text('Yes'),
                  ),
                ],
              ),
            );
          },
        );
            return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('To-Do List'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 18.0, left: 18.0, right: 18.0, bottom: 2),
              child: TextField(
                controller: _textController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.black)),
                  labelText: 'New Task',
                ),
                onSubmitted: (value) {
                  _addTask(value);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_textController.text.isNotEmpty) {
                        _addTask(_textController.text);
                      }
                      else{
                        Fluttertoast.showToast(
                                  msg: "Please Enter Task",
                                  backgroundColor: Colors.grey.shade400,
                                  // fontSize: 20,
                                  // gravity: ToastGravity.CENTER,
                                  textColor: Colors.black
                                );
                      }
                    },
                    style: const ButtonStyle(
                        minimumSize: MaterialStatePropertyAll(Size(150, 35))),
                    child: const Text('Add Task'),
                  )
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Table(
                    border: TableBorder.all(),
                    columnWidths: const {
                      0: FixedColumnWidth(120),
                      1: FixedColumnWidth(120),
                      2: FixedColumnWidth(120),
                    },
                    children: [
                      const TableRow(
                        children: [
                          TableCell(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Title Of The Task',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Completion Status',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Is Complete',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                      ..._tasks.map((task) {
                        return TableRow(
                          decoration: BoxDecoration(
                              color: task.isComplete
                                  ? Colors.green.shade300
                                  : Colors.yellow.shade300),
                          children: [
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        task.title,
                                        style: TextStyle(
                                          decoration: task.isComplete
                                              ? TextDecoration.lineThrough
                                              : TextDecoration.none,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () {
                                        _deleteTask(task);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    task.isComplete ? 'Completed' : 'Pending',
                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Center(
                                child: Checkbox(
                                  value: task.isComplete,
                                  onChanged: (value) {
                                    _toggleTaskCompletion(task);
                                  },
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Task {
  String title;
  bool isComplete;

  Task({required this.title, this.isComplete = false});
}

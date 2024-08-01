// import 'package:flutter/material.dart';
//
// class TodoListApp extends StatelessWidget {
//   const TodoListApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'To-Do List',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: TodoListPage(),
//     );
//   }
// }
//
// class TodoListPage extends StatefulWidget {
//   @override
//   _TodoListPageState createState() => _TodoListPageState();
// }
//
// class _TodoListPageState extends State<TodoListPage> {
//   final List<Task> _tasks = [];
//   final TextEditingController _textController = TextEditingController();
//
//   void _addTask(String title) {
//     if (title.trim().isEmpty) {
//       return;
//     }
//     setState(() {
//       _tasks.add(Task(title: title, isComplete: false));
//     });
//     _textController.clear();
//   }
//
//   void _toggleTaskCompletion(Task task) {
//     setState(() {
//       task.isComplete = !task.isComplete;
//     });
//   }
//
//   void _deleteTask(Task task) {
//     setState(() {
//       _tasks.remove(task);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('To-Do List'),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(
//                 top: 18.0, left: 18.0, right: 18.0, bottom: 2),
//             child: Expanded(
//               child: TextField(
//                 controller: _textController,
//                 decoration: const InputDecoration(
//                   contentPadding: EdgeInsets.all(10),
//                   border: OutlineInputBorder(
//                       borderSide: BorderSide(width: 3, color: Colors.black)),
//                   labelText: 'New Task',
//                 ),
//                 onSubmitted: (value) {
//                   _addTask(value);
//                 },
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(right: 18.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     if (_textController.text.isNotEmpty) {
//                       _addTask(_textController.text);
//                     }
//                   },
//                   style: const ButtonStyle(
//                       minimumSize: MaterialStatePropertyAll(Size(150, 35))),
//                   child: const Text('Add Task'),
//                 )
//               ],
//             ),
//           ),
//           Expanded(
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.all(18.0),
//                 child: Table(
//                   border: TableBorder.all(),
//                   columnWidths: const {
//                     0: FixedColumnWidth(100),
//                     1: FixedColumnWidth(150),
//                     2: FixedColumnWidth(100),
//                     3: FixedColumnWidth(50),
//                   },
//                   children: [
//                     TableRow(
//                       children: [
//                         TableCell(
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text(
//                               'Title Of The Task',
//                               style: TextStyle(fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                         ),
//                         TableCell(
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text(
//                               'Completion Status',
//                               style: TextStyle(fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                         ),
//                         TableCell(
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text(
//                               'Is Complete',
//                               style: TextStyle(fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                         ),
//                         TableCell(
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text(
//                               'Delete',
//                               style: TextStyle(fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     ..._tasks.map((task) {
//                       return TableRow(
//                         decoration: BoxDecoration(
//                             color: task.isComplete
//                                 ? Colors.green.shade300
//                                 : Colors.yellow.shade300),
//                         children: [
//                           TableCell(
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Center(
//                                 child: Text(
//                                   task.title,
//                                   style: TextStyle(
//                                     decoration: task.isComplete
//                                         ? TextDecoration.lineThrough
//                                         : TextDecoration.none,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           TableCell(
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Center(
//                                 child: Text(
//                                   task.isComplete ? 'Completed' : 'Pending',
//                                 ),
//                               ),
//                             ),
//                           ),
//                           TableCell(
//                             child: Center(
//                               child: Checkbox(
//                                 value: task.isComplete,
//                                 onChanged: (value) {
//                                   _toggleTaskCompletion(task);
//                                 },
//                               ),
//                             ),
//                           ),
//                           TableCell(
//                             child: Center(
//                               child: IconButton(
//                                 icon: const Icon(Icons.delete),
//                                 onPressed: () {
//                                   _deleteTask(task);
//                                 },
//                               ),
//                             ),
//                           ),
//                         ],
//                       );
//                     }).toList(),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class Task {
//   String title;
//   bool isComplete;
//
//   Task({required this.title, this.isComplete = false});
// }
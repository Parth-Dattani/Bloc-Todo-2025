import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_bloc/blocs/task/task_bloc.dart';
import 'package:todo_bloc/blocs/task/task_event.dart';
import 'package:todo_bloc/blocs/task/task_state.dart';
import 'package:todo_bloc/models/task_response.dart';

import '../../blocs/login/login_bloc.dart';
import '../../blocs/login/login_event.dart';


class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  List<TaskResponse> tasks = [];

  final titleController = TextEditingController();
  final subTitleController = TextEditingController();
  final userController = TextEditingController();
  DateTime? selectedDate;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  void _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) setState(() => selectedDate = picked);
  }

  // void _addTaskDialog() {
  //   // Capture bloc from the current (root) context BEFORE opening bottom sheet.
  //   final taskBloc = context.read<TaskBloc>();
  //
  //   // local controllers (we already have titleController & subTitleController as class members)
  //   // ensure subTitleController declared in class: final subTitleController = TextEditingController();
  //
  //   // open sheet
  //   showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
  //     ),
  //     builder: (ctx) {
  //       bool status = false;
  //       DateTime? localSelectedDate = selectedDate; // start from current selectedDate if any
  //
  //       return StatefulBuilder(
  //         builder: (contextSB, setStateSB) {
  //           return Padding(
  //             padding: EdgeInsets.only(
  //               left: 16,
  //               right: 16,
  //               top: 16,
  //               bottom: MediaQuery.of(ctx).viewInsets.bottom + 16,
  //             ),
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 Text("Add New Task", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
  //                 SizedBox(height: 12),
  //
  //                 // Title
  //                 TextField(
  //                   controller: titleController,
  //                   decoration: InputDecoration(labelText: 'Task Title', border: OutlineInputBorder()),
  //                 ),
  //                 SizedBox(height: 12),
  //
  //                 // Subtitle
  //                 TextField(
  //                   controller: subTitleController,
  //                   decoration: InputDecoration(labelText: 'Task Subtitle', border: OutlineInputBorder()),
  //                 ),
  //                 SizedBox(height: 12),
  //
  //                 // Date row
  //                 Row(
  //                   children: [
  //                     Expanded(
  //                       child: Text(
  //                         localSelectedDate == null
  //                             ? "No Date Selected"
  //                             : "Date: ${localSelectedDate!.day}/${localSelectedDate!.month}/${localSelectedDate!.year}",
  //                       ),
  //                     ),
  //                     TextButton(
  //                       onPressed: () async {
  //                         final picked = await showDatePicker(
  //                           context: ctx,
  //                           initialDate: localSelectedDate ?? DateTime.now(),
  //                           firstDate: DateTime(2000),
  //                           lastDate: DateTime(2100),
  //                         );
  //                         if (picked != null) {
  //                           setStateSB(() => localSelectedDate = picked);
  //                         }
  //                       },
  //                       child: Text("Pick Date"),
  //                     ),
  //                   ],
  //                 ),
  //
  //                 SizedBox(height: 12),
  //
  //                 // Status checkbox
  //                 Row(
  //                   children: [
  //                     Checkbox(
  //                       value: status,
  //                       onChanged: (v) => setStateSB(() => status = v ?? false),
  //                     ),
  //                     const Text("Completed"),
  //                   ],
  //                 ),
  //
  //                 SizedBox(height: 16),
  //
  //                 ElevatedButton(
  //                   style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
  //                   onPressed: () {
  //                     // validation
  //                     if (titleController.text.trim().isEmpty || subTitleController.text.trim().isEmpty || localSelectedDate == null) {
  //                       // show a small message
  //                       ScaffoldMessenger.of(context).showSnackBar(
  //                         SnackBar(content: Text('Please fill title, subtitle and pick a date')),
  //                       );
  //                       return;
  //                     }
  //
  //                     // build task (auto id)
  //                     final newTask = TaskResponse(
  //                       taskID: DateTime.now().millisecondsSinceEpoch.toString(),
  //                       taskTitle: titleController.text.trim(),
  //                       taskSubTitle: subTitleController.text.trim(),
  //                       date: localSelectedDate!,
  //                       status: status,
  //                     );
  //
  //                     // DEBUG: print to console so we know it runs
  //                     print('Dispatching AddTask -> $newTask');
  //
  //                     // dispatch using captured bloc
  //                     taskBloc.add(AddTask(newTask));
  //
  //                     // clear and pop
  //                     titleController.clear();
  //                     subTitleController.clear();
  //                     setStateSB(() => localSelectedDate = null);
  //                     Navigator.of(ctx).pop();
  //                   },
  //                   child: Text("Add Task"),
  //                 ),
  //               ],
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }

  void _editTaskDialog(TaskResponse? existingTask, int? index) {
    // Capture bloc from the current (root) context BEFORE opening bottom sheet.
    final taskBloc = context.read<TaskBloc>();

    // Pre-fill controllers and variables if editing
    titleController.text = existingTask?.taskTitle ?? '';
    subTitleController.text = existingTask?.taskSubTitle ?? '';
    DateTime? localSelectedDate = existingTask?.date ?? selectedDate;
    bool status = existingTask?.status ?? false;

    // local controllers (we already have titleController & subTitleController as class members)
    // ensure subTitleController declared in class: final subTitleController = TextEditingController();

    // open sheet
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        // bool status = false;
        // DateTimeateTime? localSelectedDate = selectedDate; // start from current selectedDate if any

        return StatefulBuilder(
          builder: (contextSB, setStateSB) {
            return Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                      existingTask == null ?
                      "Add New Task" :
                          "Edit Task", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 12),

                  // Title
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(labelText: 'Task Title', border: OutlineInputBorder()),
                  ),
                  SizedBox(height: 12),

                  // Subtitle
                  TextField(
                    controller: subTitleController,
                    decoration: InputDecoration(labelText: 'Task Subtitle', border: OutlineInputBorder()),
                  ),
                  SizedBox(height: 12),

                  // Date row
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          localSelectedDate == null
                              ? "No Date Selected"
                              : "Date: ${localSelectedDate!.day}/${localSelectedDate!.month}/${localSelectedDate!.year}",
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          final picked = await showDatePicker(
                            context: ctx,
                            initialDate: localSelectedDate ?? DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );
                          if (picked != null) {
                            setStateSB(() => localSelectedDate = picked);
                          }
                        },
                        child: Text("Pick Date"),
                      ),
                    ],
                  ),

                  SizedBox(height: 12),

                  // Status checkbox
                  Row(
                    children: [
                      Checkbox(
                        value: status,
                        onChanged: (v) => setStateSB(() => status = v ?? false),
                      ),
                      const Text("Completed"),
                    ],
                  ),

                  SizedBox(height: 16),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                    onPressed: () {
                      // validation
                      if (titleController.text.trim().isEmpty || subTitleController.text.trim().isEmpty || localSelectedDate == null) {
                        // show a small message
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please fill title, subtitle and pick a date')),
                        );
                        return;
                      }

                      // build task (auto id)
                      final newTask = TaskResponse(
                        taskID: DateTime.now().millisecondsSinceEpoch.toString(),
                        taskTitle: titleController.text.trim(),
                        taskSubTitle: subTitleController.text.trim(),
                        date: localSelectedDate!,
                        status: status,
                      );

                      // DEBUG: print to console so we know it runs
                      print('Dispatching AddTask -> $newTask');


                      if(existingTask == null) {
                        // dispatch using captured bloc
                        taskBloc.add(AddTask(newTask));
                      }
                      else{
                        taskBloc.add(UpdateTask(index!, newTask));
                      }
                      // clear and pop
                      titleController.clear();
                      subTitleController.clear();
                      setStateSB(() => localSelectedDate = null);
                      Navigator.of(ctx).pop();
                    },
                    child: Text("Add Task"),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildTaskCard(TaskResponse task, int index) {
    bool isCompleted = task.status;

    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isCompleted
              ? [Colors.green.shade100, Colors.green.shade50]
              : [Colors.amber.shade100, Colors.amber.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: ListTile(
        leading: Icon(
          isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
          color: isCompleted ? Colors.green : Colors.grey,
          size: 28,
        ),
        title: Text(
          task.taskTitle,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            decoration: isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(task.taskSubTitle.toString(), style: TextStyle(fontSize: 14)),
            SizedBox(height: 2),
            Text(
              "Date • ${task.date.day}/${task.date.month}/${task.date.year}",
              style: TextStyle(fontSize: 12, color: Colors.grey[700]),
            ),
          ],
        ),
        trailing:
        PopupMenuButton<String>(
          onSelected: (value){
            if(value == "edit"){
              print("object");
              _editTaskDialog(task, index);
            }
            else if(value == "delete"){
              print("Delete Task Id: ${task.taskID}");
              context.read<TaskBloc>().add(DeleteTask(index));
            }
          } ,

          itemBuilder: (context) {
           return [
             PopupMenuItem(
               value: "edit",
               child: Text("Edit"),
             ),
             PopupMenuItem(
                 value: "delete",
                 child: Text("Delete")
             )
           ];
          },
          icon: Icon(Icons.more_vert_rounded),

        ),
        onTap: () => context.read<TaskBloc>().add(ToggleTaskStatus(index)),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<TaskBloc>().add(LoadTasks());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.white10,
        elevation: 0,
        title: const Text(
          'Your Tasks',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: (){
                context.read<LoginBloc>().add(LogoutRequested());
                context.go('/login');
              },
              icon: Icon(Icons.settings, color: Colors.white,))
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.grey.shade900],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            if (state.tasks.isEmpty) {
              return Center(child: Text("No task found...", style: TextStyle(color: Colors.amberAccent),));
            }
            else {
              return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: state.tasks.length,
              itemBuilder: (context, index) {
                 return
                   _buildTaskCard(state.tasks[index], index);
              });
            }
          }
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber.shade400,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        onPressed: ()=> _editTaskDialog(null,null),
        child: const Icon(Icons.add),
      ),
    );
  }
}


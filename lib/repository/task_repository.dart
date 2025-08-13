// // lib/repository/task_repository.dart
//
// import '../models/task_response.dart.dart';
//
// abstract class TaskRepository {
//   Future<List<TaskResponse>> getTask();
//   Future<void> addTask(TaskResponse task);
//   Future<void> updateTask(TaskResponse task);
//   Future<void> deleteTask(String taskID);
// }
//
//
// // lib/repository/task_repository_impl.dart
//
// import 'task_repository.dart';
// import '../models/task_response.dart.dart';
//
// class TaskRepositoryImpl implements TaskRepository {
//   List<TaskResponse> _tasks = [];
//
//   @override
//   Future<List<TaskResponse>> getTask() async {
//     return _tasks; // or load from storage/API
//   }
//
//   @override
//   Future<void> addTask(TaskResponse task) async {
//     _tasks.add(task);
//   }
//
//   @override
//   Future<void> updateTask(TaskResponse task) async {
//     _tasks = _tasks.map((t) => t.taskID == task.taskID ? task : t).toList();
//   }
//
//   @override
//   Future<void> deleteTask(String taskID) async {
//     _tasks.removeWhere((t) => t.taskID == taskID);
//   }
// }

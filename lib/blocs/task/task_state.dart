import 'package:equatable/equatable.dart';
import '../../models/task_response.dart';

class TaskState extends Equatable {
  final List<TaskResponse> tasks;

  const TaskState({this.tasks = const []});

  TaskState copyWith({List<TaskResponse>? tasks}) {
    return TaskState(tasks: tasks ?? this.tasks);
  }

  @override
  List<Object?> get props => [tasks];
}


// import 'package:equatable/equatable.dart';
// import '.../models/task_response.dart.dart';
//
// abstract class TasksState extends Equatable {
//   const TasksState();
//
//   @override
//   List<Object> get props => [];
// }
//
// class TasksLoading extends TasksState {}
//
// class TasksLoaded extends TasksState {
//   final List<TaskResponse> tasks;
//
//   const TasksLoaded({this.tasks = const <TaskResponse>[]});
//
//   @override
//   List<Object> get props => [tasks];
// }
//
// class TasksError extends TasksState {
//   final String message;
//
//   const TasksError(this.message);
//
//   @override
//   List<Object> get props => [message];
// }

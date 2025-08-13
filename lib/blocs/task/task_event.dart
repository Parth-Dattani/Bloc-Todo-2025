  import 'package:equatable/equatable.dart';
  import '../../models/task_response.dart';

  abstract class TaskEvent extends Equatable {
    @override
    List<Object?> get props => [];
  }

  class LoadTasks extends TaskEvent {}

  class AddTask extends TaskEvent {
    final TaskResponse task;
    AddTask(this.task);

    @override
    List<Object?> get props => [task];
  }

  class DeleteTask extends TaskEvent{
    final int index;
    DeleteTask(this.index);

    @override
    List<Object?> get props => [index];
  }

  class UpdateTask extends TaskEvent{
    final int index;
    final TaskResponse updateTask;

    UpdateTask(this.index, this.updateTask);

    @override
    List<Object?> get props => [index];
  }

  class ToggleTaskStatus extends TaskEvent {
    final int index;
    ToggleTaskStatus(this.index);

    @override
    List<Object?> get props => [index];
  }


// import 'package:equatable/equatable.dart';
// import '../models/task_response.dart.dart';
//
// abstract class TaskEvent extends Equatable {
//   const TaskEvent();
//
//   @override
//   List<Object> get props => [];
// }
//
// class LoadTask extends TaskEvent {
//   final List<TaskResponse> tasks;
//
//   const LoadTask({this.tasks = const <TaskResponse>[]});
//
//   @override
//   List<Object> get props => [tasks];
// }
//
// class AddTask extends TaskEvent {
//   final TaskResponse task;
//
//   const AddTask({required this.task});
//
//   @override
//   List<Object> get props => [task];
// }
//
// class UpdateTask extends TaskEvent {
//   final TaskResponse task;
//
//   const UpdateTask({required this.task});
//
//   @override
//   List<Object> get props => [task];
// }
//
// class DeleteTask extends TaskEvent {
//   final TaskResponse task;
//
//   const DeleteTask({required this.task});
//
//   @override
//   List<Object> get props => [task];
// }

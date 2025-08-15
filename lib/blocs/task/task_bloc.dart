import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/utils/task_storage.dart';
import 'task_event.dart';
import 'task_state.dart';
import '../../models/task_response.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super( TaskState(tasks:  [])) {

    on<LoadTasks>((event, emit) async {
      final task = await TaskStorage.loadTasks();
      emit(state.copyWith(tasks: task));
    });

    on<AddTask>((event, emit) async {
      final updatedTasks = List<TaskResponse>.from(state.tasks)..add(event.task);
      emit(state.copyWith(tasks: updatedTasks));
      await TaskStorage.saveTasks(updatedTasks);

    });

    // on<ToggleTaskStatus>((event, emit) {
    //   final updatedTasks = List<TaskResponse>.from(state.tasks);
    //   updatedTasks[event.index].status = !updatedTasks[event.index].status;
    //   emit(state.copyWith(tasks: updatedTasks));
    // });

    on<DeleteTask>((event, emit){
      final deleteTask = List<TaskResponse>.from(state.tasks)
        ..removeAt(event.index);
      emit(state.copyWith(tasks: deleteTask));
    });

    on<UpdateTask>((event, emit) {
      final updatedTasks = List<TaskResponse>.from(state.tasks);
      updatedTasks[event.index] = event.updateTask;
      emit(state.copyWith(tasks: updatedTasks));
    });


    on<ToggleTaskStatus>((event, emit) {
      final updatedTasks = List<TaskResponse>.from(state.tasks);

      final task = updatedTasks[event.index];
      updatedTasks[event.index] = TaskResponse(
        taskTitle: task.taskTitle,
        taskID: task.taskID,
        status: !task.status,
      );
      emit(state.copyWith(tasks: updatedTasks));
    });

  }

  @override
  TaskState? fromJson(Map<String, dynamic> json) {
    try {
      final tasksJson = json['tasks'] as List<dynamic>;
      final tasks = tasksJson
          .map((task) => TaskResponse.fromJson(task as Map<String, dynamic>))
          .toList();
      return TaskState(tasks: tasks);
    } catch (_) {
      return TaskState(tasks: []);
    }
  }

  @override
  Map<String, dynamic>? toJson(TaskState state) {
    return {
      'tasks': state.tasks.map((task) => task.toJson()).toList(),
    };
  }
}


// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:todo_bloc/blocs/task/task_event.dart';
// import 'package:todo_bloc/blocs/task/task_state.dart';
// import '../../repository/task_repository.dart';
//
//
// class TasksBloc extends Bloc<TaskEvent, TasksState> {
//   final TaskRepository _taskRepository;
//
//   TasksBloc(this._taskRepository) : super(TasksLoading()) {
//     on<LoadTask>(_onLoadTask);
//     on<AddTask>(_onAddTask);
//     on<DeleteTask>(_onDeleteTask);
//     on<UpdateTask>(_onUpdateTask);
//   }
//
//   Future<void> _onLoadTask(LoadTask event, Emitter<TasksState> emit) async {
//     emit(TasksLoading());
//     try {
//       final tasks = await _taskRepository.getTask();
//       emit(TasksLoaded(tasks: tasks));
//     } catch (e) {
//       emit(TasksError(e.toString()));
//     }
//   }
//
//   void _onAddTask(AddTask event, Emitter<TasksState> emit) {
//     final state = this.state;
//     if (state is TasksLoaded) {
//       emit(TasksLoaded(tasks: List.from(state.tasks)..add(event.task)));
//     }
//   }
//
//   void _onDeleteTask(DeleteTask event, Emitter<TasksState> emit) {
//     final state = this.state;
//     if (state is TasksLoaded) {
//       List<TaskResponse> tasks = state.tasks.where((task) {
//         return task.taskID != event.task.taskID;
//       }).toList();
//       emit(TasksLoaded(tasks: tasks));
//     }
//   }
//
//   void _onUpdateTask(UpdateTask event, Emitter<TasksState> emit) {
//     final state = this.state;
//     if (state is TasksLoaded) {
//       List<TaskResponse> tasks = (state.tasks.map((task) {
//         return task!.taskID == event.task.taskID ? event.task : task;
//       })).toList();
//       emit(TasksLoaded(tasks: tasks));
//     }
//   }
// }

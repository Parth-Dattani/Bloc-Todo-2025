import 'package:flutter_bloc/flutter_bloc.dart';
import 'task_event.dart';
import 'task_state.dart';
import '../../models/task_response.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(const TaskState()) {

    on<LoadTasks>((event, emit) {
      emit(TaskState(tasks: [
        // TaskResponse(taskTitle: "delectus aut autem", taskID: "User 1", status: false),
        // TaskResponse(taskTitle: "fugiat veniam minus", taskID: "User 1", status: true),
      ]));
    });

    on<AddTask>((event, emit) {
      final updatedTasks = List<TaskResponse>.from(state.tasks)..add(event.task);
      emit(state.copyWith(tasks: updatedTasks));
    });

    // on<ToggleTaskStatus>((event, emit) {
    //   final updatedTasks = List<TaskResponse>.from(state.tasks);
    //   updatedTasks[event.index].status = !updatedTasks[event.index].status;
    //   emit(state.copyWith(tasks: updatedTasks));
    // });

    on<DeleteTask>((event, emit){
      final deleteTask = List<TaskResponse>.from(state.tasks)..removeAt(event.index);
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

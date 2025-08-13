import 'package:uuid/uuid.dart';

class TaskResponse {
  final String taskID;
  final String taskTitle;
  final String? taskSubTitle;
  bool status;
  final DateTime date;

  TaskResponse({
    String? taskID,
    required this.taskTitle,
    this.taskSubTitle,
    this.status = false,
    DateTime? date,
  })  : taskID = taskID ?? const Uuid().v4(),
        date = date ?? DateTime.now();

  factory TaskResponse.fromJson(Map<String, dynamic> json) {
    return TaskResponse(
      taskID: json['taskID'] as String?,
      taskTitle: json['taskTitle'] as String? ?? '',
      taskSubTitle: json['taskSubTitle'] as String?,
      status: json['status'] as bool? ?? false,
      date: json['date'] != null
          ? DateTime.parse(json['date'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'taskID': taskID,
      'taskTitle': taskTitle,
      'taskSubTitle': taskSubTitle,
      'status': status,
      'date': date.toIso8601String(),
    };
  }

  TaskResponse copyWith({
    String? taskID,
    String? taskTitle,
    String? taskSubTitle,
    bool? status,
    DateTime? date,
  }) {
    return TaskResponse(
      taskID: taskID ?? this.taskID,
      taskTitle: taskTitle ?? this.taskTitle,
      taskSubTitle: taskSubTitle ?? this.taskSubTitle,
      status: status ?? this.status,
      date: date ?? this.date,
    );
  }

  @override
  String toString() {
    return 'TaskResponse(taskID: $taskID, taskTitle: $taskTitle, taskSubTitle: $taskSubTitle, status: $status, date: $date)';
  }
}

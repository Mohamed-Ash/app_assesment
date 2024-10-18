// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'task_data_bloc.dart';

class TaskDataEvent {}

class IndexDataEvent extends TaskDataEvent {}
class StoreDataEvent extends TaskDataEvent {
  String? modelKey;

  final int taskId;
  final Map<String, dynamic> data;
  
  StoreDataEvent({
    required this.taskId,
    required this.data,
  });
}

class UpDateDataEvent extends TaskDataEvent{
  String? modelKey;
  
  final int taskId;
  final Map<String, dynamic> data;

  UpDateDataEvent({
    required this.taskId,
    this.modelKey,
    required this.data,
  });
}

class DeleteTask extends TaskDataEvent {
  final String taskId;
  String? modelKey;

  DeleteTask({
    required this.taskId,
    this.modelKey,
  });
}

class SyncTasks extends TaskDataEvent {
  final Map<String, dynamic> data;
  SyncTasks({
    required this.data,
  });
}

class AddTasks extends TaskDataEvent {
  final Map<String, dynamic> data;

  AddTasks({required this.data});
}


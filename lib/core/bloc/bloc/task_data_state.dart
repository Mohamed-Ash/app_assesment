part of 'task_data_bloc.dart';

@immutable
sealed class TaskDataState {}

class TaskDataInitialState extends TaskDataState {}

class TaskDataLoadingState extends TaskDataState {}

class TaskDataLoadedState extends TaskDataState {}

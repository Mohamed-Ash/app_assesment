// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'task_data_bloc.dart';

sealed class TaskDataState {}

class TaskDataInitialState extends TaskDataState {}

class TaskDataLoadingState extends TaskDataState {}

class TaskDataLoadedState<T> extends TaskDataState {
  final T data;
  TaskDataLoadedState({
    required this.data,
  });
}

class TaskDataProgressState extends TaskDataState {}

class TaskDataErrorState extends TaskDataState {

  final String error;

  TaskDataErrorState({
    required this.error,
  });

}

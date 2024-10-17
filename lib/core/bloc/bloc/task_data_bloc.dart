import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'task_data_event.dart';
part 'task_data_state.dart';

class TaskDataBloc extends Bloc<TaskDataEvent, TaskDataState> {
  TaskDataBloc() : super(TaskDataInitialState()) {
    on<TaskDataEvent>((event, emit) {
    });
  }
}

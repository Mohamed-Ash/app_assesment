 
import 'package:app_assesment/core/helper/internet_connectivity_helper.dart';
import 'package:app_assesment/core/service/hive_service.dart';
import 'package:bloc/bloc.dart'; 

part 'task_data_event.dart';
part 'task_data_state.dart';

class TaskDataBloc<T> extends Bloc<TaskDataEvent, TaskDataState> {
  HiveService hiveService = HiveService(); 

  String? collectionName;
  Function? factory;

  Type get type => T;
  Future<bool> connectivity =  checkInternetConnectivityHelper();
  
  TaskDataBloc() : super(TaskDataInitialState()) {
    on<IndexDataEvent>(_index);
    on<StoreDataEvent>(_store);
  }

    /* Stream<TaskDataEvent> mapEventToState(TaskDataEvent event) async* {
      if (event is AddTask) {
    } */


  void _index(IndexDataEvent event, Emitter<TaskDataState> emit) async {
    emit(TaskDataLoadingState());

    // late List<Map<String, dynamic>> getTasks;
    late List<dynamic> getTasks;
    if ( await connectivity != false) {
      getTasks = hiveService.getAllTasks();
      print('[_index] [response] [Type] $type [${getTasks.runtimeType}] [connectivity status]  [local] [local ${getTasks}]');
    } else {
      print('[_index] [response] [Type] $type [connectivity status]  [Cluoud]');

    }
    emit(TaskDataLoadedState(data: getTasks));

  }
  void _store(StoreDataEvent event, Emitter<TaskDataState> emit)  async {
    emit(TaskDataProgressState());
    try {
      
      if ( await connectivity != false) {
        await hiveService.insertTask(event.taskId, event.data);

        print('[_store] [request] [Type] $type [connectivity status]  [local] ${event.data}');
      } else {
        print('[_store] [request] [Type] $type [connectivity status]  [Cluoud] ${event.data}');
        
      }
      
// بعد إدخال المهمة في Hive، قم بجلب قائمة المهام المحدثة
      List<dynamic> updatedTasks = hiveService.getAllTasks();
      
      // إرسال حالة جديدة لعرض المهام المحدثة
      emit(TaskDataLoadedState(data: updatedTasks));
      // emit(TaskDataLoadedState<T>(data: factory!.call(event.data)));
    } catch (e) {
      emit(TaskDataErrorState(error: e.toString()));
      throw Exception(e.toString()); 
    }
  }
}

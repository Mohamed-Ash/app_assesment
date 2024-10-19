import 'package:app_assesment/core/helper/internet_connectivity_helper.dart';
import 'package:app_assesment/core/model/_model_interface.dart';
import 'package:app_assesment/core/service/hive_service.dart';
import 'package:bloc/bloc.dart'; 

part 'task_data_event.dart';
part 'task_data_state.dart';

class TaskDataBloc<T> extends Bloc<TaskDataEvent, TaskDataState> {
  HiveService hiveService = HiveService(); 

  String? collectionName;
  Function? factory;
  String? modelName;

  Type get type => T;
  Future<bool> connectivity =  checkInternetConnectivityHelper();
  
  TaskDataBloc({Function? initFactory}) : super(TaskDataInitialState()) {
    on<IndexDataEvent>(_index);
    on<StoreDataEvent>(_store);
    on<DeleteDataEvent>(_delete);


        
    ModelClass? modelClass = ModelInterface.getModelClass(type);
      modelName = ModelInterface.getModelName(type);
    // type? ModelNames = ModelInterface.getModelType(ModelName);


    if (modelClass != null && modelName != null) {
      collectionName = modelClass.collectionName;
      factory = modelClass.factory;
    }

     if (factory == null) {
      if (initFactory != null) {
        factory = initFactory;
      } else {
        throw Exception('No Found Factory (From Json) for $type');
      }
    } 
  }
    
    /* Stream<TaskDataEvent> mapEventToState(TaskDataEvent event) async* {
      if (event is AddTask) {
    } */

  void _index(IndexDataEvent event, Emitter<TaskDataState> emit) async {
    try {
      emit(TaskDataLoadingState());
            
      List<T> getModelData = await _getData();
      
      emit(TaskDataLoadedState<List<T>>(data: getModelData));
    } catch (e) {
      emit(TaskDataErrorState(error: e.toString()));
      throw Exception(e.toString());
    }
  }

  /* void _index(IndexDataEvent event, Emitter<TaskDataState> emit) async {
    try {
      
      emit(TaskDataLoadingState());

      List<Map<dynamic, dynamic>> getMapTask = hiveService.getAllTasks() as List<Map<dynamic, dynamic>>;
      List<T> getListTasks = [];
      if ( await connectivity != false) {
        for (var element in getMapTask) {
          // Map<String, dynamic> task = 
          getListTasks.add(factory?.call(Map<String, dynamic>.from(element)));
        }
        print('[_index] [response] [Type] $type [${getListTasks.runtimeType}] [connectivity status]  [local] [local $getListTasks]');
      } else {
        print('[_index] [response] [Type] $type [connectivity status]  [remote]');

      }
      emit(TaskDataLoadedState<List<T>>(data: getListTasks));
    } catch (e) {
      emit(TaskDataErrorState(error: e.toString()));
      throw Exception(e.toString()); 
    }

  } */
  void _store(StoreDataEvent event, Emitter<TaskDataState> emit)  async {
    emit(TaskDataProgressState());
    try {
    List<T> getListTasks = [];

      if ( await connectivity != false) {
        await hiveService.insertTask(event.taskId, event.data);

        print('[_store] [request] [model] [$modelName] [Type] $type [connectivity status]  [local] ${event.data}');
      } else {
        print('[_store] [request] [model] [$modelName]  [Type] $type [connectivity status]  [remote] ${event.data}');
        
      }
    List<T> getModelData = await _getData();
      // إرسال حالة جديدة لعرض المهام المحدثة
      emit(TaskDataLoadedState<List<T>>(data: getModelData));
      // emit(TaskDataLoadedState<T>(data: factory!.call(event.data)));
    } catch (e) {
      emit(TaskDataErrorState(error: e.toString()));
      throw Exception(e.toString()); 
    }
  }
  void _delete(DeleteDataEvent event, Emitter<TaskDataState> emit) async {
    emit(TaskDataProgressState());

    if (await connectivity != false) {
      try{

      hiveService.deleteTask(int.parse(event.taskId));
      List<T> getModelData = await _getData();

      emit(TaskDataLoadedState<List<T>>(data: getModelData));
      } catch (e) {
      emit(TaskDataErrorState(error: e.toString()));
      throw Exception(e.toString()); 
    }
    }
  }

  Future<List<T>> _getData(/* {required List<Map<dynamic, dynamic>> getData} */) async {
    List<Map<dynamic, dynamic>> getMapTask =  hiveService.getAllTasks() as List<Map<dynamic, dynamic>>;
    List<T> getListTasks = [];

    if (await connectivity != false) {
      for (var element in getMapTask) {
        // التحقق من أن العنصر ليس null قبل تحويله
        try {
          Map<String, dynamic> task = Map<String, dynamic>.from(element);
          getListTasks.add(factory?.call(task));
        } catch (e) {
          print("Error converting element: $element, error: $e");
        }
      }
        print('[_index] [response] [model] [$modelName] [Type] $type [${getListTasks.runtimeType}] [connectivity status]  [local] [local $getListTasks]');
    } else {
      print('[_index] [response] [model] [$modelName] [Type] $type [connectivity status]  [remote]');
    }
    return getListTasks;
  }
}

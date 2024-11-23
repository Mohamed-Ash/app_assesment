import 'package:app_assesment/core/helper/internet_connectivity_helper.dart';
import 'package:app_assesment/core/models/_model_interface.dart';
import 'package:app_assesment/core/service/hive_service.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart'; 

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
    on<UpDateDataEvent>(_update);
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
  
  void _store(StoreDataEvent event, Emitter<TaskDataState> emit)  async {
    emit(TaskDataProgressState());
    try {
    // List<T> getListTasks = [];

      if ( await connectivity == false) {
        await hiveService.insertTask(event.taskId, event.data);

        debugPrint('[_store] [request] [model] [$modelName] [Type] $type [connectivity status]  [local] ${event.data}');
      } else {
              
      final collectionData = FirebaseFirestore.instance.collection(collectionName!);
      DocumentReference<Map<String, dynamic>> result = await collectionData.add(event.data);
     
        debugPrint('[_store] [request] [model] [$modelName]  [Type] $type [Entry] ${result.runtimeType} [connectivity status]  [remote] ${event.data}');
        
      }
    // List<T> getModelData = await _getData();
      // إرسال حالة جديدة لعرض المهام المحدثة
      // emit(TaskDataLoadedState<List<T>>(data: getModelData));
      // emit(TaskDataLoadedState<T>(data: factory!.call(event.data)));
    } catch (e) {
      emit(TaskDataErrorState(error: e.toString()));
      throw Exception(e.toString()); 
    }
  }

  void _update(UpDateDataEvent event, Emitter<TaskDataState> emit) async {
    emit(TaskDataProgressState()); 
      try{ 
        if ( await connectivity == false) {
        await hiveService.insertTask(event.taskId, event.data);

        debugPrint('[_store] [request] [model] [$modelName] [Type] $type [connectivity status]  [local] ${event.data}');
        
        } else { 
        Query<Map<String, dynamic>> collection = FirebaseFirestore.instance.collection(collectionName!);

          final collectionData = await collection.get();
          
          // QueryDocumentSnapshot<Map<String, dynamic>>? doc = collectionData.docs.first;
          QueryDocumentSnapshot<Map<String, dynamic>>? doc = collectionData.docs.firstWhere((element) {
            debugPrint('element id is ${element.data()[event.modelKey]} && event id is ${event.taskId}');
            return element.data()[event.modelKey] == event.taskId;
          },);

          final updateData =  FirebaseFirestore.instance.collection(collectionName!);
          await updateData.doc(doc.id).update(event.data);
          
        
          debugPrint('[_store] [request] [model] [$modelName]  [Type] $type [connectivity status]  [remote] ${event.data}');
          
        }
        // await hiveService.insertTask(event.taskId, event.data);
        List<T> getModelData = await _getData();

          emit(TaskDataLoadedState<List<T>>(data: getModelData));
        } catch (e) {
        emit(TaskDataErrorState(error: e.toString()));
        throw Exception(e.toString()); 
      } 
  }

  void _delete(DeleteDataEvent event, Emitter<TaskDataState> emit) async {
    emit(TaskDataProgressState());

    if (await connectivity == false) {
      try{

        hiveService.deleteTask(int.parse(event.taskId));
        List<T> getModelData = await _getData();

        emit(TaskDataLoadedState<List<T>>(data: getModelData));
        } catch (e) {
        emit(TaskDataErrorState(error: e.toString()));
        throw Exception(e.toString()); 
      }
    } else {
      // final collection = FirebaseFirestore.instance.collection(collectionName!);

      // final collectionData = await collection.get();
      
      // QueryDocumentSnapshot<Map<String, dynamic>>? doc = collectionData.docs.first;
      // QueryDocumentSnapshot<Map<String, dynamic>>? doc = collectionData.docs.firstWhere((element) {
      //   debugPrint('element id is ${element.data()[event.modelKey]} && event id is ${event.taskId}');
      //   return element.data()[event.modelKey] == event.taskId;
      // },);
       final collection = FirebaseFirestore.instance.collection(collectionName!).where(event.modelKey! ,isEqualTo: event.taskId);

          final collectionData = await collection.get();
          
          // QueryDocumentSnapshot<Map<String, dynamic>>? doc = collectionData.docs.first;
        var doc = collectionData.docs.firstWhereOrNull(
          (element) {
            debugPrint('element id is ${element.data()[event.modelKey]} && event id is ${event.taskId}');
            return element.data()[event.modelKey] == event.taskId;
          }, 
        );

          
      if (doc != null) {
 
        await FirebaseFirestore.instance.collection(collectionName!).doc(doc.id).delete();

      } else {
        debugPrint('Document with ID ${event.taskId} not found.');
        emit(TaskDataErrorState(error: 'Document not found'));
        return;
      }
      
    
      List<T> getModelData = await _getData();
      debugPrint('[_store] [request] [model] [$modelName]  [Type] $type [connectivity status]  [remote] $getModelData');

      emit(TaskDataLoadedState<List<T>>(data: getModelData)); 
    }
  }

  Future<List<T>> _getData(/* {required List<Map<dynamic, dynamic>> getData} */) async {
    List<Map<dynamic, dynamic>> getMapTask =  hiveService.getAllTasks() as List<Map<dynamic, dynamic>>;
    List<T> getListTasks = [];
  
    if (await connectivity == false) {
      for (var element in getMapTask) {

        try {
          Map<String, dynamic> task = Map<String, dynamic>.from(element);
          getListTasks.add(factory?.call(task));
        } catch (e) {
          debugPrint("Error converting element: $element, error: $e");
        }
      }
        debugPrint('[_index] [response] [model] [$modelName] [Type] $type [${getListTasks.runtimeType}] [connectivity status]  [local] [local $getListTasks]');
    } else {
      Query<Map<String, dynamic>> collection = FirebaseFirestore.instance.collection(collectionName!);

      final collectionData = await collection.get();

      for (var element in collectionData.docs) {
        getListTasks.add(factory?.call(element.data()));
      }
      debugPrint('[_index] [response] [model] [$modelName] [Type] $type [connectivity status]  [remote] $getListTasks');
    }
    return getListTasks;
  }
}

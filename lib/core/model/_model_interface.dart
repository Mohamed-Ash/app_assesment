import 'package:app_assesment/core/model/task_model.dart'; 
import 'package:collection/collection.dart';
class ModelClass {
  final String collectionName;
  final Function factory;

  ModelClass({
    required this.collectionName,
    required this.factory,
  });
}

class ModelInterface {
  static ModelClass? getModelClass(Type type) {
    return _models.entries.firstWhereOrNull((element) => element.key == type,)?.value;
  }

  static String getModelName(Type type) {
    return _models.entries.firstWhere((element) => element.key == type).value.collectionName;
  }

  static Type getModelType(String type) {
    return _models.entries.firstWhere((element) => element.value.collectionName == type).key;
  } 

  static final Map<Type, ModelClass> _models = {
    TaskModel : ModelClass(collectionName: 'task_model', factory: TaskModel.fromJson)
  };

}
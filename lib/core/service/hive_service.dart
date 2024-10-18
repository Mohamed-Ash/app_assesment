import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  // 2. الصندوق الذي سنستخدمه
  Box? _taskBox;

     // 5. تهيئة Hive وفتح صندوق البيانات
  Future initialize() async {
    // تأكد من تهيئة Hive فقط مرة واحدة
    await Hive.initFlutter();

    // فتح صندوق البيانات
    _taskBox = await Hive.openBox<Map>('tasksBox');
  }
  

  // 6. إضافة بيانات إلى الصندوق
 // إدخال مهمة جديدة (Map)
  Future<void> insertTask(int key, Map<String, dynamic> task) async {
    await _taskBox?.put(key, task);
  }
  
  // 7. جلب جميع المهام من الصندوق
   // جلب جميع المهام
  List getAllTasks() {
    return _taskBox?.values.toList() ?? [];
  }
  
  Map<String, dynamic>? getTask(int key) {
    return _taskBox?.get(key);
  }
  // 8. حذف مهمة باستخدام الفهرس (index)
  Future<void> deleteTask(int key) async {
    await _taskBox?.deleteAt(key);
  }

  // 9. إغلاق الصندوق عند انتهاء استخدام التطبيق
  Future<void> close() async {
    await _taskBox?.close();
  }
   
 //singleton
  HiveService.init();
  static HiveService? _instance;
  factory HiveService() => _instance ??= HiveService.init();
}
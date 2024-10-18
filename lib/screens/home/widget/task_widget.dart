import 'package:app_assesment/core/service/hive_service.dart';
import 'package:app_assesment/screens/home/widget/task_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TaskWidget  extends StatefulWidget {
  final List<dynamic> tasks; 
    

  const TaskWidget({super.key, required this.tasks});

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
 

  @override
  void initState() {
    super.initState();
    createIndexTasks(widget.tasks as List<Map<dynamic, dynamic>>);
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        if(widget.tasks != null || widget.tasks.isEmpty)
        ...List.generate(
          widget.tasks.length,
          (index) { 
            Map<dynamic,dynamic> mapTasks = widget.tasks.where((element) => element['task_key'] == widget.tasks[index]['task_key']).elementAt(index);
            print('widget.tasks $mapTasks');
            // return TaskItemWidget(tasks: widget.tasks.where((element) => element['task_key'] == widget.tasks[index]['task_key']),  taskIndex: index,);
            return const SizedBox.shrink();

            // return TaskItemWidget(tasks: widget.tasks.firstWhere((element) => element['task_key'] == widget.tasks[index]['task_key'],),taskIndex: index,);
          }
        ),
      ],
    );
  } 
  List<Map<dynamic, dynamic>> createIndexTasks( List<dynamic> tasks){
    List<Map<dynamic, dynamic>> indexTasks = [];
    // Map<String,dynamic> mapTask = {};
    for (var element in tasks) {
      if (element.containsKey(element['task_key'])) {
        // mapTask[element['task_key']]['tasks'].add(element);
        indexTasks.add(element);
      } 
    }
      print('objects added indexTasks for element $indexTasks');
      print('objects added indexTasks for element ${indexTasks.length}');
    return indexTasks ?? [];
  }
  
}
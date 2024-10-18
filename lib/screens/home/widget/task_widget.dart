import 'package:app_assesment/core/bloc/bloc/task_data_bloc.dart';
import 'package:app_assesment/core/model/task_model.dart';
import 'package:app_assesment/screens/home/widget/task_item_widget.dart';
import 'package:flutter/material.dart';

class TaskWidget  extends StatelessWidget {
  final List<dynamic> tasks; 
  
  const TaskWidget({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        if(tasks != null || tasks.isEmpty)
        ...List.generate(
          tasks.length,
          (index) => TaskItemWidget(tasks: listIndexTasks(tasks as List<Map<dynamic, dynamic>>).elementAt(index), taskIndex: index,)
        ),
      ],
    );
  } 

  List<Map<String, dynamic>> listIndexTasks( List<Map<dynamic, dynamic>> tasks){
    List<Map<String, dynamic>> indexTasks = [];
    
    for (var element in tasks) {
      indexTasks.add(Map.from(element));
    }

    return indexTasks;
  }
}
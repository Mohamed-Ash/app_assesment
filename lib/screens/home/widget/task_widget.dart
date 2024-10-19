import 'package:app_assesment/core/bloc/bloc/task_data_bloc.dart';
import 'package:app_assesment/core/model/task_model.dart';
import 'package:app_assesment/screens/home/widget/task_item_widget.dart';
import 'package:flutter/material.dart';

class TaskWidget  extends StatelessWidget {
  final List<TaskModel> tasks; 
  final TaskDataBloc<TaskModel> taskBloc;

  const TaskWidget({super.key, required this.tasks, required this.taskBloc});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        if(tasks != null || tasks.isEmpty)
        ...List.generate(
          tasks.length,
          (index) => TaskItemWidget(taskModel: tasks.elementAt(index), taskIndex: index,taskBloc: taskBloc, )
        ),
      ],
    );
  }  
}
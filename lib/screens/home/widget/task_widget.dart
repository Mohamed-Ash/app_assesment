import 'package:app_assesment/core/bloc/bloc/task_data_bloc.dart';
import 'package:app_assesment/core/models/task_model.dart';
import 'package:app_assesment/core/themes/app_text_style.dart';
import 'package:app_assesment/core/widgets/icon_widget.dart';
import 'package:app_assesment/screens/home/widget/task_item_widget.dart';
import 'package:flutter/material.dart';

class TaskWidget extends StatelessWidget {
  final List<TaskModel> tasks;
  final TaskDataBloc<TaskModel> taskBloc;

  const TaskWidget({super.key, required this.tasks, required this.taskBloc});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Wrap(
          children: [
            if (tasks.isNotEmpty)
              ...List.generate(
                tasks.length,
                (index) => TaskItemWidget(
                  taskModel: tasks.elementAt(index),
                  taskIndex: index,
                  taskBloc: taskBloc,
                ),
              ),
          ],
        ),
        if (tasks.isEmpty) 
          Center( 
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SvgImageWidget(
                  iconName: 'Empty_task',
                  color: Color(0xff4ECB71),
                  height: 222,
                  width: double.infinity,
                ),
                const SizedBox(height: 22),
                Text(
                  'No tasks found',
                  style:AppTextStyles.bodyLarge(),
                ),
              ],
            ),
          )
      ],
    );
  }
}
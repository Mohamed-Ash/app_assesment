import 'package:app_assesment/core/bloc/bloc/task_data_bloc.dart';
import 'package:app_assesment/core/models/task_model.dart';
import 'package:app_assesment/core/widgets/icon_widget.dart';
import 'package:app_assesment/screens/home/widget/task_item_widget.dart';
import 'package:flutter/material.dart';

class TaskWidget extends StatelessWidget {
  final List<TaskModel> tasks;
  final TaskDataBloc<TaskModel> taskBloc;

  const TaskWidget({super.key, required this.tasks, required this.taskBloc});

  @override
  Widget build(BuildContext context) {
    return Wrap( // Use Stack as the root widget
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
          const Center( 
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgImageWidget(
                  iconName: 'Empty_task',
                  color: Color(0xff4ECB71),
                  height: 222,
                  width: double.infinity,
                ),
                SizedBox(height: 22),
                Text(
                  'No tasks found',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          )
      ],
    );
  }
}

/* 

Widget buildTasksWidget(){
    if (tasks.isNotEmpty){
      return Wrap(
          children: [
              ...List.generate(
                tasks.length,
                (index) => TaskItemWidget(
                  taskModel: tasks.elementAt(index),
                  taskIndex: index,
                  taskBloc: taskBloc,
                ),
              ),
          ],
        );
    } else {
      return const Center( 
            child: const Column(
              mainAxisSize: MainAxisSize.min, // Adjust size based on content
              children: [
                const SvgImageWidget(
                  iconName: 'Empty_task',
                  color: const Color(0xff4ECB71),
                  height: 222,
                  width: double.infinity,
                ),
                const SizedBox(height: 22),
                const Text(
                  'No tasks found',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
     }
  }
 */
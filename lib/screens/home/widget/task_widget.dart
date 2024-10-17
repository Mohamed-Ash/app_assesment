import 'package:app_assesment/core/service/hive_service.dart';
import 'package:app_assesment/screens/home/widget/task_item_widget.dart';
import 'package:flutter/material.dart';

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
    
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        if(widget.tasks != null || widget.tasks.isEmpty)
        ...List.generate(
          widget.tasks.length,
          (index) { 
            print('widget.tasks [${widget.tasks[index]}]');
            return TaskItemWidget(tasks: widget.tasks.firstWhere((element) => element['task_key'] == widget.tasks[index]['task_key'],));
          }
        ),
      ],
    );
  }

  
}
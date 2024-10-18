import 'package:app_assesment/core/service/hive_service.dart';
import 'package:app_assesment/core/widgets/custom_button_widget.dart';
import 'package:app_assesment/core/widgets/custom_card_widget.dart';
import 'package:app_assesment/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TaskItemWidget extends StatefulWidget{
  Map<dynamic, dynamic> tasks;
  final int taskIndex;

  TaskItemWidget({super.key, required this.tasks, required this.taskIndex});

  @override
  State<TaskItemWidget> createState() => _TaskItemWidgetState();
}

class _TaskItemWidgetState extends State<TaskItemWidget> {
  // late List<dynamic> taskList;

  final titleController = TextEditingController();

  final dateController = TextEditingController();
  
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  
  @override
  void initState() {
    super.initState();
      // taskList = widget.tasks;
    print('taskList taskList taskList ${widget.tasks}');
    // Initialize controllers with the current task data
    titleController.text = widget.tasks['title'] ?? '';

    dateController.text = widget.tasks['date'] ?? '';
  }

 

  @override
  Widget build(BuildContext context) {
    return  Builder(
      builder: (context) {
        if (widget.tasks.isNotEmpty) { 
        return Slidable(
          key: ValueKey(widget.taskIndex), 
          startActionPane: ActionPane(
          motion: const ScrollMotion(),
        
          // A pane can dismiss the Slidable.
            dismissible: DismissiblePane(onDismissed: () {}), 
            children: [
              SlidableAction(
                onPressed: _deleteTask,
                backgroundColor: const Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ],
          ),
          child: InkWell(
            onTap: () => _showCreateTaskBottomSheet(context),
            child: customCardTaskWidget(
              context: context,
              date: widget.tasks ['data'] ?? '', 
              title: widget.tasks ['title'] ?? '', 
            ),
          ),
        );
      } 
      else {
        return  const SizedBox.shrink();
        }
      }
    );
  }

  void _showCreateTaskBottomSheet(BuildContext context) {
 
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      // barrierColor: const Color.fromARGB(195, 255, 255, 255),
      isScrollControlled: true,
      // backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Create New Task',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.red),
                      onPressed: () {
                        appRouter.pop();
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: titleController,
                  validator: (value) {
                    
                  },
                  decoration: InputDecoration(
                    hintText: 'Task title',
                    filled: true,
                    labelText: widget.tasks['title'],
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Due Date',
                    filled: true,
                    labelText: widget.tasks['date'],
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                customButtonWidget(
                  context: context, 
                  title: 'Edit Task', 
                  onPressed: (){
                    _editTask();
                  }
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _deleteTask(BuildContext context) async {

    print('_deleteTask ${widget.tasks.remove(widget.taskIndex)}');
    print('_deleteTasks ${widget.tasks.remove(widget.taskIndex)}');
    await HiveService().deleteTask(widget.taskIndex);
    setState(() { 
      widget.tasks.clear();
    });
  }

  Future<void> _editTask() async {
    await HiveService().insertTask(
      widget.tasks['task_key'],
      {
        'task_key': widget.tasks['task_key'],
        'title': titleController.text,
        'date': dateController.text,
        'status': widget.tasks['status'],
      },
    );

    setState(() {
      widget.tasks['title'] = titleController.text;
      widget.tasks['date'] = dateController.text;
    });
    appRouter.pop();
  }

}
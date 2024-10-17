import 'package:app_assesment/core/service/hive_service.dart';
import 'package:app_assesment/core/widgets/custom_button_widget.dart';
import 'package:app_assesment/core/widgets/custom_card_widget.dart';
import 'package:flutter/material.dart';

class TaskItemWidget extends StatefulWidget{
  dynamic tasks;

  TaskItemWidget({super.key, required this.tasks});

  @override
  State<TaskItemWidget> createState() => _TaskItemWidgetState();
}

class _TaskItemWidgetState extends State<TaskItemWidget> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();

  final dateController = TextEditingController();
  @override
  void initState() {
    super.initState();
 
    // Initialize controllers with the current task data
    titleController.text = widget.tasks['title'] ?? '';
    
    dateController.text = widget.tasks['date'] ?? '';
  }
  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: () => _showCreateTaskBottomSheet(context),
      child: customCardTaskWidget(
        context: context,
        date: widget.tasks ['data'] ?? '', 
        title: widget.tasks ['title'] ?? '', 
      ),
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
                        Navigator.of(context).pop();
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
                    HiveService().insertTask(
                      titleController.text.hashCode, 
                      {
                        'title': titleController.text.toString(), 
                        'date': titleController.text.toString(),
                        'status': 'not_done'
                      }
                    );
                  }
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
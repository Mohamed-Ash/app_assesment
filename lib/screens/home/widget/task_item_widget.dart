import 'package:app_assesment/core/bloc/bloc/task_data_bloc.dart';
import 'package:app_assesment/core/model/task_model.dart';
import 'package:app_assesment/core/widgets/custom_button_widget.dart';
import 'package:app_assesment/core/widgets/custom_card_widget.dart';
import 'package:app_assesment/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TaskItemWidget extends StatefulWidget {
  final TaskModel taskModel;
  final int taskIndex;
  final TaskDataBloc<TaskModel> taskBloc;
  
  const TaskItemWidget({
    super.key,
    required this.taskModel,
    required this.taskIndex, required this.taskBloc,
  });

  @override
  State<TaskItemWidget> createState() => _TaskItemWidgetState();
}

class _TaskItemWidgetState extends State<TaskItemWidget> {
  final titleController = TextEditingController();
  final dateController = TextEditingController();


  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.taskModel.title;
    dateController.text = widget.taskModel.cearetedAt.toString();

  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: widget.taskBloc,
      builder: (context, state) {
        if (state is TaskDataLoadingState) {
          return const Center(child: CircularProgressIndicator(),);
        } else if (state is TaskDataErrorState) {
          return const Center(child: Text('Error loading task data'));
        } else if (state is TaskDataLoadedState<List<TaskModel>>) {
          return Slidable(
            key: ValueKey(widget.taskIndex),
            startActionPane: ActionPane(
              motion: const ScrollMotion(),
              dragDismissible: false,
              // A pane can dismiss the Slidable.
              dismissible: DismissiblePane(onDismissed: () {
                _deleteTask(context);
              }),
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
                date: widget.taskModel.title,
                title: widget.taskModel.cearetedAt.toIso8601String(),
              ),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
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
                  validator: (value) {},
                  decoration: InputDecoration(
                    hintText: 'Task title',
                    filled: true,
                    labelText: widget.taskModel.title,
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
                    labelText: widget.taskModel.cearetedAt.toIso8601String(),
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
                    onPressed: () {
                      _editTask();
                    }),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _deleteTask(BuildContext context) async {
    // bool connectivity = await checkInternetConnectivityHelper();

    widget.taskBloc.add(DeleteDataEvent(taskId: widget.taskIndex.toString()));
    widget.taskBloc.add(IndexDataEvent()); // print('_deleteTask ${widget.taskModel.remove(widget.taskIndex)}');
    // print('_deleteTasks ${widget.taskModel.remove(widget.taskIndex)}');
    // await HiveService().deleteTask(widget.taskIndex);
    // setState(() {
    //   widget.taskModel.clear();
    // });
  }

  Future<void> _editTask() async {
    // await HiveService().insertTask(
    //   widget.taskModel['task_key'],
    //   {
    //     'task_key': widget.taskModel['task_key'],
    //     'title': titleController.text,
    //     'date': dateController.text,
    //     'status': widget.taskModel['status'],
    //   },
    // );

    // setState(() {
    //   widget.taskModel['title'] = titleController.text;
    //   widget.taskModel['date'] = dateController.text;
    // });
    // appRouter.pop();
  }
  void storeTask() async {
    int taskId = DateTime.now().hashCode;
    /* TaskModel taskModel = TaskModel(
      taskId: taskId,
      title: titleController.text,
      status: 'not_done',
      cearetedAt: DateTime.now(),
    ); */
    // bool connectivity = await checkInternetConnectivityHelper();
    TaskModel taskModel = TaskModel(
      taskId: taskId,
      title: titleController.text,
      status: 'not_done',
      // connectivityStatus: con  nectivity == false ? 'local' : 'remote',
      cearetedAt: DateTime.now(),
    );
    widget.taskBloc.add(StoreDataEvent(taskId: taskId, data: taskModel.toJson()));
    widget.taskBloc.add(IndexDataEvent());
    appRouter.pop();
  }
}

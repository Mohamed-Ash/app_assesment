import 'package:app_assesment/core/bloc/bloc/task_data_bloc.dart';
import 'package:app_assesment/core/helper/internet_connectivity_helper.dart';
import 'package:app_assesment/core/models/task_model.dart';
import 'package:app_assesment/core/widgets/custom_button_widget.dart';
import 'package:app_assesment/core/widgets/custom_card_widget.dart';
import 'package:app_assesment/core/widgets/custom_show_buttom_sheet.dart';
import 'package:app_assesment/core/widgets/show_task_dialog.dart';
import 'package:app_assesment/global.dart';
import 'package:date_field/date_field.dart';
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

  DateTime? selectedDate;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.taskModel.title;
    dateController.text = widget.taskModel.date.toString();
    selectedDate = widget.taskModel.date;
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
          return   Container(
            margin: const EdgeInsets.only(top: 12),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),),
            child: Slidable(
              closeOnScroll: true,
              key: ValueKey(widget.taskIndex),
              startActionPane: ActionPane(
                motion: const DrawerMotion(),
                dragDismissible: false,
                children: [
                  SlidableAction(
                    onPressed: _deleteTask,
                    backgroundColor: const Color(0xFFFE4A49),
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    autoClose: true,
                    padding: const EdgeInsets.all(2),
                    label: 'Delete',
                  ),
                  // if(widget.taskModel.status != 'done')
                  SlidableAction(
                    onPressed: _doneTask,
                    backgroundColor: const Color(0xff00c95c),
                    foregroundColor: Colors.white,
                    autoClose: true,
                    padding: const EdgeInsets.all(2),
                    icon:  widget.taskModel.status == 'done' ? Icons.radio_button_unchecked : Icons.task_alt_rounded,
                    label: widget.taskModel.status == 'done' ? 'Not Done' :' Done',
                  ),
                ],
              ),
              child: GestureDetector(
                
                onTap: () {
                  if (MediaQuery.of(context).size.width < 600) {
                    print('object');
                    showCreateTaskBottomSheet(
                      context: context,
                      labelText: widget.taskModel.title, 
                      dateLabelText: widget.taskModel.date.toIso8601String(), 
                      hintTitle: 'Task title', 
                      hintdate: 'Due Date',
                      titleButton: 'Edit Task', 
                      onPressed:  () {
                        if (formKey.currentState!.validate()) {
                          _editTask();
                        }
                      },
                    );
                   /*  showCreateTaskBottomSheet(
                      context: context, 
                      labelText: widget.taskModel.title, 
                      dateLabelText: widget.taskModel.cearetedAt.toIso8601String(), 
                      hintTitle: 'Task title',
                      hintdate: 'Due Date',
                      titleButton:'Edit Task',
                      titleController: titleController, 
                      subTitleController: dateController, 
                      onPressed: ()=> _editTask(), 
                    ); */
                  } else {
                    showTaskDialog(
                      context: context, 
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: const Icon(Icons.close, color: Colors.red),
                          ),
                        ),
                        const Text(
                          'Create New Task',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        // Task Title Input
                        TextFormField(
                          controller: titleController,
                          decoration: InputDecoration(
                            labelText: 'Task title',
                            fillColor: Colors.grey[200],
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Due Date Input
                        DateTimeFormField(
                          decoration: const InputDecoration(
                            labelText: 'Enter Date',
                          ),
                          autovalidateMode: AutovalidateMode.always,
                          materialDatePickerOptions: const MaterialDatePickerOptions(fieldLabelText: 'title Task',helpText: 'asdasd',),
                          hideDefaultSuffixIcon: true,
                          // pickerPlatform: DateTimeFieldPickerPlatform.adaptive,
                          
                          firstDate: DateTime.now().add(const Duration(days: 10)),
                          lastDate: DateTime.now().add(const Duration(days: 40)),
                          initialPickerDateTime: DateTime.now().add(const Duration(days: 20)),
                          mode: DateTimeFieldPickerMode.date,
                          initialValue: selectedDate,
                          /* onSaved: (newValue) {
                            selectedDate = newValue;
                            
                          }, */
                          onChanged: (DateTime? value) {
                            selectedDate = value;
                          },
                        ),
                        const Spacer(),
                        customButtonWidgetWeb(
                          context: context,
                          onPressed: () {
                            _editTask( ); 
                          },
                          title: 'Save Task'
                        ),
                      ]
                    );
                  }
                },
                child: customCardTaskWidget(
                  context: context,
                  title: widget.taskModel.title,
                  date: widget.taskModel.date,
                  status: widget.taskModel.status,
                ),
              ),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );

    
  }

  Future<void> _deleteTask(BuildContext context) async {
    widget.taskBloc.add(DeleteDataEvent(taskId: widget.taskIndex.toString()));
    widget.taskBloc.add(IndexDataEvent());
  }

  void _editTask() async {
    bool connectivity = await checkInternetConnectivityHelper();
    
    TaskModel taskModel = TaskModel(
      taskId: widget.taskModel.taskId,
      date: selectedDate ?? widget.taskModel.date,
      title: titleController.text,
      status: 'not_done',
      connectivityStatus: connectivity == false ? 'local' : 'remote',
      // cearetedAt: DateTime.now(),
    );
    widget.taskBloc.add(UpDateDataEvent(taskId: widget.taskModel.taskId, data: taskModel.toJson()));
    widget.taskBloc.add(IndexDataEvent());
    appRouter.pop();
  }
  void _doneTask(BuildContext context) async {
    bool connectivity = await checkInternetConnectivityHelper();
    
    TaskModel taskModel = TaskModel(
      taskId: widget.taskModel.taskId,
      date: DateTime.now(),
      title: titleController.text,
      status: widget.taskModel.status == 'done' ? 'not_done' : 'done',
      connectivityStatus: connectivity == false ? 'local' : 'remote',
      // cearetedAt: DateTime.now(),
    );
    widget.taskBloc.add(UpDateDataEvent(taskId: widget.taskModel.taskId, data: taskModel.toJson()));
    widget.taskBloc.add(IndexDataEvent());
  }
}



/* 



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


 */
import 'package:app_assesment/core/bloc/bloc/task_data_bloc.dart';
import 'package:app_assesment/core/form_fields/custom_text_form_field.dart';
import 'package:app_assesment/core/form_fields/date_picker_form_field.dart';
import 'package:app_assesment/core/helper/internet_connectivity_helper.dart';
import 'package:app_assesment/core/models/task_model.dart';
import 'package:app_assesment/core/themes/app_text_style.dart';
import 'package:app_assesment/core/themes/colors/app_colors.dart';
import 'package:app_assesment/core/widgets/custom_button_widget.dart';
import 'package:app_assesment/core/widgets/custom_card_widget.dart';
import 'package:app_assesment/core/widgets/custom_show_buttom_sheet.dart';
import 'package:app_assesment/core/widgets/show_task_dialog.dart';
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
 
  DateTime? selectedDate;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.taskModel.title;
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
                    backgroundColor: AppColors.redColor,
                    foregroundColor: AppColors.whiteColor,
                    icon: Icons.delete,
                    autoClose: true,
                    padding: const EdgeInsets.all(2),
                    label: 'Delete',
                  ),
                  // if(widget.taskModel.status != 'done')
                  SlidableAction(
                    onPressed: _doneTask,
                    backgroundColor: const Color(0xff00c95c),
                    foregroundColor: AppColors.whiteColor,
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
                    formKey: formKey,
                    labelText: 'Task title', 
                    controller: titleController,
                    selectedDate: selectedDate,
                    dateLabelText: 'Due Date',
                    hintTitle: 'Task title', 
                    hintdate: 'Due Date',
                    titleButton: 'Save Task', 
                    onPressed:  () {
                      if (formKey.currentState!.validate()) {
                        _editTask();
                      }
                    },
                  );
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
                            child: const Icon(Icons.close, color: AppColors.redColor),
                          ),
                        ),
                        Text(
                          'Create New Task',
                          style: AppTextStyles.bodyLarge(),
                        ),
                        const SizedBox(height: 10),
                          CustomTextFormField(
                            controller: titleController,
                            hintText: 'Task Title',
                            labelText: 'Task Title',
                          ),
                        const SizedBox(height: 25),
                        DatePicerFormField(
                          firstDate: DateTime.now().add(const Duration(days: 10)),
                          lastDate: DateTime.now().add(const Duration(days: 40)),
                          initialPickerDateTime: DateTime.now().add(const Duration(days: 20)),
                          selectedDate: selectedDate,
                          labelText: 'Enter Date',
                          hintText: 'Due Date',
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
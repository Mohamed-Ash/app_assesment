import 'package:app_assesment/core/bloc/bloc/task_data_bloc.dart';
import 'package:app_assesment/core/helper/internet_connectivity_helper.dart';
import 'package:app_assesment/core/models/task_model.dart';
import 'package:app_assesment/core/widgets/custom_button_widget.dart';
import 'package:app_assesment/core/widgets/icon_widget.dart';
import 'package:app_assesment/core/widgets/show_task_dialog.dart';
import 'package:app_assesment/global.dart';
import 'package:app_assesment/screens/home/page/home_page.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';

class ShowFloatingActionButton extends StatefulWidget {
  final TaskDataBloc<TaskModel> taskBloc;

  const ShowFloatingActionButton({super.key, required this.taskBloc,});

  @override
  State<ShowFloatingActionButton> createState() => _ShowFloatingActionButtonState();
}

class _ShowFloatingActionButtonState extends State<ShowFloatingActionButton> {
  DateTime? selectedDate;

  final titleController = TextEditingController();
  // late final TaskDataBloc<TaskModel> taskBloc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 22),
      child: FloatingActionButton(
        onPressed: ()=> showTaskDialog(
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
              onChanged: (DateTime? value) {
                selectedDate = value;
              },
            ),
            const Spacer(),
            customButtonWidgetWeb(
              context: context,
              onPressed: ()=> _storeTask(),
              title: 'Save Task'
            ),
          ]
        ),
        mini: true,
        clipBehavior: Clip.antiAlias,
        backgroundColor: const Color(0xff00CA5D), 
        child: const SvgImageWidget(
          width: 35,
          height: 35,
          iconName: 'fluent_add', 
          color: Colors.white,
        ),
      ),
    );
  }

  void _storeTask() async {
    bool connectivity = await checkInternetConnectivityHelper();
    
    int taskId = DateTime.now().hashCode;
    
    TaskModel taskModel = TaskModel(
      title: titleController.text,
      date: selectedDate!,
      taskId: taskId,
      status: 'not_done',
      connectivityStatus: connectivity != false ? 'local' : 'remote' ,
      cearetedAt: DateTime.now(), 
    );

    widget.taskBloc.add(StoreDataEvent(taskId: taskId, data: taskModel.toJson()));
    
    widget.taskBloc.add(IndexDataEvent());
    appRouter.pop();
  }
}
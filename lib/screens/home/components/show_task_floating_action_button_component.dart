import 'package:app_assesment/core/bloc/bloc/task_data_bloc.dart';
import 'package:app_assesment/core/form_fields/custom_text_form_field.dart';
import 'package:app_assesment/core/form_fields/date_picker_form_field.dart';
import 'package:app_assesment/core/helper/internet_connectivity_helper.dart';
import 'package:app_assesment/core/models/task_model.dart';
import 'package:app_assesment/core/themes/app_text_style.dart';
import 'package:app_assesment/core/themes/colors/app_colors.dart';
import 'package:app_assesment/core/widgets/custom_button_widget.dart';
import 'package:app_assesment/core/widgets/icon_widget.dart';
import 'package:app_assesment/core/widgets/show_task_dialog.dart';
import 'package:app_assesment/global.dart';
import 'package:flutter/material.dart';

class ShowTaskFloatingActionButtonComponent extends StatelessWidget {
  final int? taskId;
  
  final TaskDataBloc<TaskModel> taskBloc;

  ShowTaskFloatingActionButtonComponent({super.key, required this.taskBloc, this.taskId});

  DateTime? selectedDate;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();

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
                  child: const Icon(Icons.close, color: AppColors.redColor),
                ),
              ),
                Text(
                'Create New Task',
                style: AppTextStyles.bodyLarge() // TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              // Task Title Input
                CustomTextFormField(
              controller: titleController,
              hintText: 'Task Title',
              labelText: 'Task Title',
            ),
              const SizedBox(height: 10),
              // Due Date Input
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
              /* DateTimeFormField(
                decoration:   InputDecoration(
                  labelText: 'Enter Date',
                  hintText: 'Due Date',
                  filled: true,
                  fillColor: AppColors.greyColor, // Background color of the field
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none, // No border by default
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: AppColors.greyColor, width: 2.0), // Border when focused
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0), // Padding inside the field
                ),
                autovalidateMode: AutovalidateMode.always,
                materialDatePickerOptions: const MaterialDatePickerOptions(fieldLabelText: 'title Task',helpText: 'asdasd',),
                hideDefaultSuffixIcon: true,
                // pickerPlatform: DateTimeFieldPickerPlatform.adaptive,
                validator: (value) {
                  if (value == null) {
                    return 'Please select a date';
                  }
                  return null; 
                },
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
              ), */
              const Spacer(),
              customButtonWidgetWeb(
                context: context,
                onPressed: () {
                  if (taskId == null ) {
                      _storeTask();
                    // if (formKey.currentState!.validate()){
                    // }                    
                  }else if (taskId != null) {
                    _editTask(taskId!);
                  }
                },
                title: 'Save Task'
              ),
            ]
          ),
          mini: true,
          clipBehavior: Clip.antiAlias,
          backgroundColor: AppColors.primaryColor, 
          child: const SvgImageWidget(
            width: 35,
            height: 35,
            iconName: 'fluent_add', 
            color: AppColors.whiteColor,
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
      connectivityStatus: connectivity == false ? 'local' : 'remote' ,
      // cearetedAt: DateTime.now(), 
    );

    taskBloc.add(StoreDataEvent(taskId: taskId, data: taskModel.toJson()));
    
    taskBloc.add(IndexDataEvent());
    appRouter.pop();
  }

  void _editTask(int taskId) async {
    bool connectivity = await checkInternetConnectivityHelper();
    
    TaskModel taskModel = TaskModel(
      taskId: taskId,
      date: selectedDate!,
      title: titleController.text,
      status: 'not_done',
      connectivityStatus: connectivity == false ? 'local' : 'remote',
      // cearetedAt: DateTime.now(),
    );
    taskBloc.add(UpDateDataEvent(taskId: taskId, data: taskModel.toJson()));
    taskBloc.add(IndexDataEvent());
    appRouter.pop();
  }
}
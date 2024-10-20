import 'package:app_assesment/core/form_fields/custom_text_form_field.dart';
import 'package:app_assesment/core/form_fields/date_picker_form_field.dart';
import 'package:app_assesment/core/themes/app_text_style.dart';
import 'package:app_assesment/core/themes/colors/app_colors.dart';
import 'package:app_assesment/core/widgets/custom_button_widget.dart';
import 'package:flutter/material.dart';



void showCreateTaskBottomSheet({
  required BuildContext context,
   required GlobalKey<FormState> formKey,
required TextEditingController controller,
  required String labelText,
  required String dateLabelText,
  required String hintTitle,
  DateTime? selectedDate, 
  required String hintdate,
  required String titleButton,
  required Function()? onPressed,
}){
  showModalBottomSheet(
    
    context: context, 
    builder: (context) => ShowTaskButtomSheetComponent(
      formKey: formKey,
      labelText: labelText, 
      dateLabelText: dateLabelText, 
      hintTitle: hintTitle, 
      controller: controller,
      hintdate: hintdate, selectedDate: selectedDate,
      titleButton: titleButton, 
      onPressed: onPressed
    ),
  );
}

// ignore: must_be_immutable
class ShowTaskButtomSheetComponent extends StatelessWidget {
  final String labelText;

  final String dateLabelText;

  final String hintTitle;
  
  final TextEditingController controller;
  
  final String hintdate;
  
  DateTime? selectedDate;
  
  final String titleButton;
  
  GlobalKey<FormState> formKey;

  final Function()? onPressed;

  ShowTaskButtomSheetComponent({
    super.key, 
    required this.formKey, 
    required this.labelText, 
    required this.dateLabelText, 
    required this.hintTitle, 
    required this.hintdate, 
    required this.titleButton,
    required this.onPressed,
    required this.selectedDate,
    required this.controller,

  });
 
 

  @override
  Widget build(BuildContext context) {
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
                Text(
                  'Create New Task',
                  style: AppTextStyles.headline3() 
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: AppColors.redColor),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            CustomTextFormField(
              controller: controller,
              hintText: hintTitle,
              labelText: labelText,
            ),
            const SizedBox(height: 10),
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
            const SizedBox(height: 20),
            customButtonWidget(
              context: context,
              title: titleButton,
              onPressed: onPressed,
            ),
          ],
        ),
      ),
    );
  }
}
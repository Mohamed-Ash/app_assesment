import 'package:app_assesment/core/themes/colors/app_colors.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
 
class DatePicerFormField extends StatelessWidget {
  final DateTime? selectedDate;
  final ValueChanged<DateTime?>? onChanged;
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime initialPickerDateTime;
  final String? labelText;
  final String? hintText;

  const DatePicerFormField({
    super.key,
    this.selectedDate,
    this.onChanged,
    required this.firstDate,
    required this.lastDate,
    required this.initialPickerDateTime,
    this.labelText,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return DateTimeFormField(
      decoration: InputDecoration(
        labelText: labelText ?? 'Enter Date',
        hintText: hintText ?? 'Due Date',
        filled: true,
        fillColor: const Color(0xffD9D9D9),
        focusColor: AppColors.whiteColor,
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none, // بدون حدود افتراضية
        ),
        enabledBorder:OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none, // بدون حدود افتراضية
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none, // بدون حدود افتراضية
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Color(0xff00CA5D), width: 2.0), // Border عند التركيز
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none, // بدون حدود افتراضية
        ),
        alignLabelWithHint: false,
        contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0), // Padding داخل الحقل
      ),
      autovalidateMode: AutovalidateMode.disabled,
      
      materialDatePickerOptions: const MaterialDatePickerOptions(
        fieldLabelText: 'Task Title',
        helpText: 'Please choose a date',
      ),
      hideDefaultSuffixIcon: true,
      validator: (value) {
        if (value == null) {
          return 'Please select a date';
        }
        return null;
      },
      firstDate: firstDate,
      lastDate: lastDate,
      initialPickerDateTime: selectedDate,
      
      mode: DateTimeFieldPickerMode.dateAndTime,
      initialValue: selectedDate,
      onChanged: onChanged,
    );
  }
}

import 'package:app_assesment/core/widgets/custom_button_widget.dart';
import 'package:app_assesment/global.dart';
import 'package:flutter/material.dart';

void showCreateTaskBottomSheet({
  Key? formKey,
  required BuildContext context,
  required String labelText,
  required String dateLabelText,
  required String hintTitle,
  required String hintdate,
  required String titleButton,
  required TextEditingController? titleController,
  required TextEditingController? subTitleController,
  String? Function(String?)? validator,
  required Function()? onPressed,

}) {
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
                    return validator!(value);
                  },
                  decoration: InputDecoration(
                    hintText: hintTitle,
                    filled: true,
                    labelText: labelText,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: subTitleController,
                  decoration: InputDecoration(
                    hintText: dateLabelText,
                    filled: true,
                    labelText: dateLabelText,
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
                    title: titleButton,
                    onPressed: onPressed
                ),
              ],
            ),
          ),
        );
      },
    );
  }
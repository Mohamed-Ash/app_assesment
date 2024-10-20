import 'package:app_assesment/core/widgets/custom_button_widget.dart';
import 'package:flutter/material.dart';



void showCreateTaskBottomSheet({
  required BuildContext context,
  required String labelText,
  required String dateLabelText,
  required String hintTitle,
  required String hintdate,
  required String titleButton,
  required Function()? onPressed,
}){
  showModalBottomSheet(
    
    context: context, 
    builder: (context) => ShowTaskButtomSheetComponent(
      labelText: labelText, 
      dateLabelText: dateLabelText, 
      hintTitle: hintTitle, 
      hintdate: hintdate, 
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

  final String hintdate;

  final String titleButton;

  final Function()? onPressed;

  ShowTaskButtomSheetComponent({
    super.key, 
    required this.labelText, 
    required this.dateLabelText, 
    required this.hintTitle, 
    required this.hintdate, 
    required this.titleButton,
    required this.onPressed,

  });

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();

  TextEditingController subTitleController = TextEditingController();
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
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: titleController,
              validator: (value) {
                if (formKey.currentState!.validate()) {
                  return 'Please enter a value';
                } else {
                  return null;
                }
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
                hintText: hintdate,
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
              onPressed: onPressed,
            ),
          ],
        ),
      ),
    );
  }
}
/* 
void showCreateTaskBottomSheett({
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
                if (formKey.currentState!.validate()) {
                  return 'Please enter a value';
                } else {
                  return null;
                }
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
  } */
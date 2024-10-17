import 'package:app_assesment/core/layout/responsive_layout.dart';
import 'package:app_assesment/core/widgets/custom_button_widget.dart';
import 'package:app_assesment/core/widgets/icon_widget.dart';
import 'package:app_assesment/screens/home/widget/home_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class HomePage extends ResponsiveLayout {
  static String get pageName => 'home_page';
  static GoRoute get pageRoute => GoRoute(
    name: pageName,
    path: '/home_page',
    builder: (_,__) =>   HomePage(),
  );
  final _taskController = TextEditingController();
  DateTime? _selectedDate;
    HomePage({super.key});
  
  @override
  Widget buildBody(BuildContext context) {
    return const HomeWidget();
  }
  
  @override
  Widget showFloatingActionButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 22),
      child: FloatingActionButton(
        onPressed: ()=> _showTaskPopup(context),
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


  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      // barrierColor: const Color(0xff00CA5D),
      

    );
    /* if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      }); */
  }

  void _showTaskPopup(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            height: 250,
            width: 350,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Close button
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
                TextField(
                  controller: _taskController,
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
                GestureDetector(
                  onTap: () => _selectDate(context),
                  child: AbsorbPointer(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: _selectedDate == null
                            ? 'Due Date'
                            : DateFormat('yyyy-MM-dd').format(_selectedDate!),
                        fillColor: Colors.grey[200],
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                customButtonWidget(
                  context: context,
                  onPressed: (){},
                  title: 'Save Task'
                ),
                // const Spacer(),
                // SizedBox(
                //   width: double.infinity,
                //   child: ElevatedButton(
                //     onPressed: () {
                //       if (_taskController.text.isNotEmpty && _selectedDate != null) {
                //         // Handle task saving logic here
                //         print('Task: ${_taskController.text}, Date: $_selectedDate');
                //         Navigator.of(context).pop(); // Close the dialog
                //       }
                //     },
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: const Color(0xff00c95c),
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(10),
                //       ),
                //       padding: const EdgeInsets.symmetric(vertical: 15),
                //     ),
                //     child: const Text(
                //       'Save Task',
                //       style: TextStyle(
                //         fontSize: 16,
                //       color: Colors.white),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}



/* SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_taskController.text.isNotEmpty && _selectedDate != null) {
                        // Handle task saving logic here
                        print('Task: ${_taskController.text}, Date: $_selectedDate');
                        Navigator.of(context).pop(); // Close the dialog
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff00c95c),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Text(
                      'Save Task',
                      style: TextStyle(
                        fontSize: 16,
                      color: Colors.white),
                    ),
                  ),
                ), */
import 'package:app_assesment/app.dart';
import 'package:app_assesment/core/bloc/bloc/task_data_bloc.dart';
import 'package:app_assesment/core/helper/internet_connectivity_helper.dart';
import 'package:app_assesment/core/models/task_model.dart';
import 'package:app_assesment/core/themes/app_text_style.dart';
import 'package:app_assesment/core/themes/colors/app_colors.dart';
import 'package:app_assesment/core/widgets/custom_button_widget.dart';
import 'package:app_assesment/core/widgets/custom_show_buttom_sheet.dart';
import 'package:app_assesment/global.dart';
import 'package:app_assesment/screens/home/widget/task_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeWidget extends StatefulWidget {
  final TaskDataBloc<TaskModel> taskBloc;

  const HomeWidget({super.key, required this.taskBloc});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget>
    with SingleTickerProviderStateMixin {
  late TabController? tabcontroller;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final titleController = TextEditingController(); 
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    tabcontroller = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: widget.taskBloc,
      builder: (context, state) {
        if (state is TaskDataLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is TaskDataErrorState) {
          return const Center(child: Text('Error loading task data'));
        } else if (state is TaskDataLoadedState<List<TaskModel>>) {
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverToBoxAdapter(
                    child: Text(
                      'Good Morning',
                      style: AppTextStyles.headline1(color: AppColors.blackColor)
                    ),
                  ),
                  SliverToBoxAdapter(
                      child: TabBar(
                    controller: tabcontroller,
                    dividerColor: Colors.transparent,
                    labelColor: AppColors.whiteColor,
                    unselectedLabelStyle: AppTextStyles.bodySmall(),
                    labelStyle: AppTextStyles.hintStyle(),
                    unselectedLabelColor: AppColors.primaryColor,
                    indicatorSize: TabBarIndicatorSize.label,
                    isScrollable: true,
                    indicator: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22),
                      ),
                      color: AppColors.primaryColor,
                    ),
                    tabAlignment: TabAlignment.start,
                    overlayColor: WidgetStateProperty.all<Color?>(
                      const Color(0x1900c95c),
                    ),
                    tabs: [
                      tabBarWidget('All'),
                      tabBarWidget('Not Done'),
                      tabBarWidget('Done'),
                    ],
                  ))
                ],
                body: ScrollConfiguration(
                  behavior: MyCusomScrollBehavior().copyWith(scrollbars: false),
                  child: TabBarView(
                    controller: tabcontroller,
                    children: [
                      TaskWidget(tasks: state.data, taskBloc: widget.taskBloc,),
                      TaskWidget(
                        tasks: state.data.where((element) {
                          return element.status != null 
                            && element.status == 'not_done';
                        }).toList(),
                        taskBloc: widget.taskBloc,
                      ),
                      TaskWidget(
                        taskBloc: widget.taskBloc,
                        tasks: state.data.where((element) {
                          return element.status != null 
                            && element.status == 'done';
                        }).toList(),
                      ),
                    ]
                  ),
                ),
              ),
              customButtonWidget(
                context: context,
                onPressed: () {
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
                    onDateSelected: (DateTime? value) {
                      selectedDate = value;
                    },
                    onPressed:  () {
                      if (formKey.currentState!.validate()) {
                        _storeTask();
                      }
                    },
                  );
                },
                title: 'Create Task'
              ),
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  // void _showCreateTaskBottomSheet(BuildContext context) {
  //   showModalBottomSheet(
  //     context: context,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(15.0),
  //     ),
  //     isScrollControlled: true,
  //     builder: (BuildContext context) {
  //       return Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
  //         child: Form(
  //           key: formKey,
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   const Text(
  //                     'Create New Task',
  //                     style: TextStyle(
  //                       fontSize: 20,
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                   ),
  //                   IconButton(
  //                     icon: const Icon(Icons.close, color: AppColors.red),
  //                     onPressed: () {
  //                       Navigator.of(context).pop();
  //                     },
  //                   ),
  //                 ],
  //               ),
  //               const SizedBox(height: 10),
  //               TextFormField(
  //                 controller: titleController,
  //                 validator: (value) {
  //                   if (value == null || value.isEmpty) {
  //                     return 'Please enter a task title';
  //                   }
  //                   return null;
  //                 },
  //                 decoration: InputDecoration(
  //                   hintText: 'Task title',
  //                   filled: true,
  //                   fillColor: AppColors.greyColor,
  //                   border: OutlineInputBorder(
  //                     borderRadius: BorderRadius.circular(10),
  //                     borderSide: BorderSide.none,
  //                   ),
  //                 ),
  //               ),
  //               const SizedBox(height: 10),
  //               TextFormField(
  //                 validator: (value) {
  //                   if (value == null || value.isEmpty) {
  //                     return 'Please enter a Due Date';
  //                   }
  //                   return null;
  //                 },
  //                 controller: dateController,
  //                 decoration: InputDecoration(
  //                   hintText: 'Due Date',
  //                   filled: true,
  //                   fillColor: AppColors.greyColor,
  //                   border: OutlineInputBorder(
  //                     borderRadius: BorderRadius.circular(10),
  //                     borderSide: BorderSide.none,
  //                   ),
  //                 ),
  //               ),
  //               const SizedBox(height: 20),
  //               customButtonWidget(
  //                 context: context,
  //                 title: 'Save Task',
  //                 onPressed: () { 
  //                     _validateAndStoreTask();
                   
  //                 }, 
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  Widget tabBarWidget(String? text) {
    return Container(
      width: 75,
      height: 26,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0x1900c95c),
      ),
      child: Tab(
        text: text,
        height: 25,
      ),
    );
  }
 
  // void _storeTask() async {
  //   bool connectivity = await checkInternetConnectivityHelper();

  //   int taskId = DateTime.now().hashCode;

  //   TaskModel taskModel = TaskModel(
  //     title: titleController.text,
  //     date: selectedDate!,
  //     taskId: taskId,
  //     status: 'not_done',
  //     connectivityStatus: connectivity == false ? 'local' : 'remote',
  //     // cearetedAt: DateTime.now(),
  //   );

  //   widget.taskBloc.add(StoreDataEvent(taskId: taskId, data: taskModel.toJson()));

  //   widget.taskBloc.add(IndexDataEvent());
  //   appRouter.pop();
  // }
    void _storeTask() async {
    bool connectivity = await checkInternetConnectivityHelper();
    
    int taskId = DateTime.now().hashCode;
     
    TaskModel taskModel = TaskModel(
      taskId: taskId,
      date: selectedDate!,
      title: titleController.text,
      status: 'not_done',
      connectivityStatus: connectivity == false ? 'local' : 'remote',
      // cearetedAt: DateTime.now(),
    );
    widget.taskBloc.add(StoreDataEvent(taskId: taskId, data: taskModel.toJson()));
    
    widget.taskBloc.add(IndexDataEvent());
    appRouter.pop();
  }
}

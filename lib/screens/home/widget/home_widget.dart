import 'package:app_assesment/app.dart';
import 'package:app_assesment/core/bloc/bloc/task_data_bloc.dart';
import 'package:app_assesment/core/helper/internet_connectivity_helper.dart';
import 'package:app_assesment/core/models/task_model.dart';
import 'package:app_assesment/core/widgets/custom_button_widget.dart';
import 'package:app_assesment/global.dart';
import 'package:app_assesment/screens/home/widget/task_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget>
    with SingleTickerProviderStateMixin {
  late TabController? tabcontroller;
  late final TaskDataBloc<TaskModel> taskBloc;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    taskBloc = TaskDataBloc<TaskModel>()..add(IndexDataEvent());
    tabcontroller = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: taskBloc,
      builder: (context, state) {
        if (state is TaskDataLoadingState) {
          return const Center(child: CircularProgressIndicator(),);
        } else if (state is TaskDataErrorState) {
          return const Center(child: Text('Error loading task data'));
        } else if (state is TaskDataLoadedState<List<TaskModel>>) {
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  const SliverToBoxAdapter(
                    child: Text(
                      'Good Morning',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                      child: TabBar(
                    controller: tabcontroller,
                    dividerColor: Colors.transparent,
                    labelColor: Colors.white,
                    unselectedLabelStyle: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                    labelStyle: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                    unselectedLabelColor: const Color(0xff00CA5D),
                    indicatorSize: TabBarIndicatorSize.label,
                    isScrollable: true,
                    indicator: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22),
                      ),
                      color: const Color(0xff00CA5D),
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
                  child: TabBarView(controller: tabcontroller, children: [
                    TaskWidget(tasks: state.data, taskBloc: taskBloc,),
                    TaskWidget(
                      tasks: state.data.where((element) {
                        return element.status != null &&
                            element.status == 'not_done';
                      }).toList(),
                      taskBloc: taskBloc,
                    ),
                    TaskWidget(
                      taskBloc: taskBloc,
                      tasks: state.data.where((element) {
                        return element.status != null &&
                            element.status == 'done';
                      }).toList(),
                    ),
                  ]),
                ),
              ),
              customButtonWidget(
                  context: context,
                  onPressed: () => _showCreateTaskBottomSheet(context),
                  title: 'Creadste Task'),
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  } 

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
                        Navigator.of(context).pop();
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
                  title: 'Save Task',
                  onPressed: () => _storeTask()
                ),
              ],
            ),
          ),
        );
      },
    );
  }
Widget tabBarWidget(String? text){
  return Container(
    width: 75,
    height: 26,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0x1900c95c)),
    child: Tab(
      text: text,
      height: 25,
    ),
  );
}
  void _storeTask() async {
    bool connectivity = await checkInternetConnectivityHelper();
    
    int taskId = DateTime.now().hashCode;
    
    TaskModel taskModel = TaskModel(
      title: titleController.text,
      date: DateTime.now(),
      taskId: taskId,
      status: 'not_done',
      connectivityStatus: connectivity != false ? 'local' : 'remote' ,
      cearetedAt: DateTime.now(), 
    );

    taskBloc.add(StoreDataEvent(taskId: taskId, data: taskModel.toJson()));
    
    taskBloc.add(IndexDataEvent());
    appRouter.pop();
  }
}

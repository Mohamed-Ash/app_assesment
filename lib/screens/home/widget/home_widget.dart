import 'package:app_assesment/app.dart';
import 'package:app_assesment/core/service/hive_service.dart';
import 'package:app_assesment/core/widgets/custom_button_widget.dart';
import 'package:app_assesment/screens/home/widget/task_widget.dart';
import 'package:flutter/material.dart';

class HomeWidget extends StatefulWidget  {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> with SingleTickerProviderStateMixin{
  late TabController? tabcontroller;
 
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    tabcontroller = TabController(length: 3, vsync: this);    
    getStatusTask();
  }


  @override
  Widget build(BuildContext context) {
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
                overlayColor: WidgetStateProperty.all<Color?>(const Color(0x1900c95c),),
                tabs:  [
                  Container(
                    width: 75,
                    height: 26,
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), 
                      color: const Color(0x1900c95c)
                    ),
                    child: const Tab(text: 'All',height: 25,),
                  ),
                  Container(
                    width: 75,
                    height: 26,
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), 
                      color: const Color(0x1900c95c)
                    ),
                    child: const Tab(text: 'Not Done', height: 25, ),
                  ),
                  Container(
                    width: 75,
                    height: 26,
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), 
                      color: const Color(0x1900c95c)
                    ),
                    child: const Tab(text: ' Done ', height: 25, ),
                  ), 
                ],
              )
        
            )
          ], 
          body: ScrollConfiguration(
            behavior: MyCusomScrollBehavior().copyWith(scrollbars: false), 
            child: TabBarView(
              controller: tabcontroller,
              children: [
                TaskWidget(
                  tasks: getStatusTask()
                ),
                // TaskWidget(
                //   tasks: HiveService().getAllTasks().where((element) {
                //     return element['status'] != null && element['status'] == 'not_done';
                //   }).toList(),
                // ),
                // TaskWidget(
                //   tasks: HiveService().getAllTasks().where((element) {
                //     return element['status'] != null && element['status'] == 'done';
                //   }).toList(),
                // ),
              ]
            ),
          ),
        ),
        customButtonWidget(context: context, onPressed: (){_showCreateTaskBottomSheet(context);}, title: 'Creadste Task'),
        
      ],
    );
  }
  
  List<Map<String,dynamic>> getStatusTask(){
    var getAllTasks = HiveService().getAllTasks();
    List<Map<String,dynamic>> listTasks = [];
    for (var element in getAllTasks) {
    Map<String,dynamic> mapTasks = Map.from(element);
    listTasks.add(mapTasks);
    print('getStatusTask getStatusTask element element ${mapTasks.runtimeType}');
    print('getStatusTask getStatusTask element element ${mapTasks}');
    
    }
    return listTasks;
    // return HiveService().getAllTasks().where((element) {
    //   return element['status']!= null && element['status'] == 'done';
    // }).length;

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
                validator: (value) {
                  
                },
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
                onPressed: (){
                  HiveService().insertTask(
                    titleController.text.hashCode, 
                    { 
                      'task_key': titleController.text.hashCode,
                      'title': titleController.text.toString(), 
                      'date': titleController.text.toString(),
                      'status': 'not_done'
                    }
                  );
                }
              ),
            ],
          ),
        ),
      );
    },
  );
}

}
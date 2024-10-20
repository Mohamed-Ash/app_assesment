import 'package:app_assesment/core/bloc/bloc/task_data_bloc.dart';
import 'package:app_assesment/core/layout/responsive_layout.dart';
import 'package:app_assesment/core/models/task_model.dart';
import 'package:app_assesment/screens/home/components/show_task_floating_action_button_component.dart';
import 'package:app_assesment/screens/home/widget/home_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePage extends ResponsiveLayout {
  static String get pageName => 'home_page';
  static GoRoute get pageRoute => GoRoute(
    name: pageName,
    path: '/home_page',
    builder: (_, __) => HomePage(),
  );
  late final TaskDataBloc<TaskModel> taskBloc;

  HomePage({super.key}){
    taskBloc = TaskDataBloc<TaskModel>()..add(IndexDataEvent());
  }

  @override
  Widget buildBody(BuildContext context) {
    return BlocBuilder(
      bloc: taskBloc,
      builder: (context, state) {
        if (state is TaskDataLoadingState) {
          return const Center(child: CircularProgressIndicator(),);
        } else if (state is TaskDataErrorState) {
          return const Center(child: Text('Error loading task data'));
        } else if (state is TaskDataLoadedState<List<TaskModel>>) {
        return HomeWidget(taskBloc: taskBloc,);
        }
        return const SizedBox.shrink();
      },
    );
  }

  /*  create as components buttom sheet and dialog */
  @override
  Widget showFloatingActionButton(BuildContext context) {
    return ShowTaskFloatingActionButtonComponent(taskBloc: taskBloc,);
  }

  
}

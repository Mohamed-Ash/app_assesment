import 'package:app_assesment/app.dart';
import 'package:app_assesment/app_router.dart';
import 'package:app_assesment/core/service/hive_service.dart';
import 'package:app_assesment/global.dart';
import 'package:app_assesment/screens/home/page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() async {
  debugPrint('[app_assesment] Starting App');

    
  debugPrint('[app_assesment] Initializing Services');
  await HiveService().initialize();
    
  navigatorKey = GlobalKey<NavigatorState>();
  appRouter = GoRouter(
    initialLocation: HomePage.pageRoute.path,
    routes: AppRoute.getRouter,
    navigatorKey: navigatorKey,
    debugLogDiagnostics: true,
  );


  
  runApp(const App());
  debugPrint('[app_assesment]  App Started');
}
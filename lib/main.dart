import 'package:app_assesment/app.dart';
import 'package:app_assesment/app_router.dart';
import 'package:app_assesment/global.dart';
import 'package:app_assesment/screens/home/page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {

  debugPrint('[Sportera] Initializing Reflections');
  navigatorKey = GlobalKey<NavigatorState>();
  
  appRouter = GoRouter(
    initialLocation: HomePage.pageRoute.path,
    routes: AppRoute.getRouter,
    navigatorKey: navigatorKey,
    debugLogDiagnostics: true,
  );


  
  debugPrint('[Sportera] Starting App');
  runApp(const App());
  debugPrint('[Sportera]  App Started');
}
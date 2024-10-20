import 'dart:ui';

import 'package:app_assesment/core/themes/colors/app_colors.dart';
import 'package:app_assesment/global.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      scrollBehavior: MyCusomScrollBehavior(),
      title: name,
      theme: ThemeData(
    primaryColor: AppColors.primaryColor,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: AppColors.primaryColor,
      secondary: AppColors.secondaryColor,
      error: AppColors.redColor,
      surface: AppColors.whiteColor,

    ),

 
      ),
      color: AppColors.primaryColor,
        
    );
  }
}

class MyCusomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.invertedStylus,
    PointerDeviceKind.mouse,
    PointerDeviceKind.touch,
    PointerDeviceKind.trackpad,
    PointerDeviceKind.unknown,
    PointerDeviceKind.stylus,

    


  };
}
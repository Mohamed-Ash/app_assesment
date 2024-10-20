import 'dart:ui';

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
      color: const Color(0xff00CA5D),
        
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
import 'package:flutter/material.dart';

abstract class LayoutInterface extends StatelessWidget {
  final Color backgroundColor = Colors.white; 

  const LayoutInterface({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      body: body(context),
      floatingActionButton: floatingActionButton(context),
    );
  }

  Widget body(BuildContext context);
  Widget floatingActionButton(BuildContext context);

}
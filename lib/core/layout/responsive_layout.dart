import 'package:app_assesment/core/layout/layout_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

abstract class ResponsiveLayout extends LayoutInterface {
  const ResponsiveLayout({super.key});

   

  @override
  Widget body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 33, 22, 0),
      child: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context);
}
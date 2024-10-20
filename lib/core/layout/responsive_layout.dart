import 'package:app_assesment/core/layout/layout_interface.dart';
import 'package:flutter/material.dart';

abstract class ResponsiveLayout extends LayoutInterface {
  const ResponsiveLayout({super.key});
  
  @override
  Widget body(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).size.width > 600 ? const EdgeInsets.fromLTRB(70, 60, 70, 0) : const EdgeInsets.fromLTRB(22, 31, 22, 0),
      child: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context);

  @override
  Widget floatingActionButton(BuildContext context) {
    if (MediaQuery.of(context).size.width > 600){
      return showFloatingActionButton(context);
    }
    return const SizedBox.shrink();
  }

  Widget showFloatingActionButton(BuildContext context);
}
import 'package:app_assesment/core/widgets/custom_card_widget.dart';
import 'package:flutter/material.dart';

class TaskWidget  extends StatelessWidget {
  const TaskWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        customCardTaskWidget(context),
        customCardTaskWidget(context),
        customCardTaskWidget(context), 
      ],
    );
  }
}
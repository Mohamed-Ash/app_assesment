
import 'package:flutter/material.dart';

void showTaskDialog({required BuildContext context, required List<Widget> children }) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          height: 350,
          width: 350,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children
          ),
        ),
      );
    },
  );
}
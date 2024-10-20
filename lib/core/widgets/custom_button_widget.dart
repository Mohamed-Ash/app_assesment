 
import 'package:app_assesment/core/themes/app_text_style.dart';
import 'package:flutter/material.dart';

Widget customButtonWidget ({
  required BuildContext context,
  required String title,
  required void Function()? onPressed,
  Color? backgroundColor,
  TextStyle? titleStyle,
}){
  return MediaQuery.of(context).size.width > 600 ? const SizedBox.shrink() : Card(
    margin: const EdgeInsets.symmetric(vertical: 15),
    elevation: 0,
    child: SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 53,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? const Color(0xff00c95c),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(vertical: 15),
        ),
        child: Text(
          title,
          style: titleStyle ?? AppTextStyles.buttonText()
        ),
      ),
    ),
  );
}

Widget customButtonWidgetWeb ({
  required BuildContext context,
  required String title,
  required void Function()? onPressed,
  Color? backgroundColor,
  TextStyle? titleStyle,
}){
  return Card(
    margin: const EdgeInsets.symmetric(vertical: 15),
    elevation: 0,
    child: SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 53,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? const Color(0xff00c95c),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(vertical: 15),
        ),
        child: Text(
          title,
          style: titleStyle ?? AppTextStyles.buttonText(),
        ),
      ),
    ),
  );
}
import 'package:app_assesment/core/themes/colors/app_colors.dart';
import 'package:flutter/material.dart'; 

class AppTextStyles {
  // الخط الأساسي
  static const String _fontFamily = 'Inter';

  // نمط العناوين الكبيرة مع إمكانية تخصيص اللون
  static TextStyle headline1({Color color = AppColors.blackColor}) {
    return TextStyle(
      fontFamily: _fontFamily,
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: color,
    );
  }

  // نمط العناوين المتوسطة مع إمكانية تخصيص اللون
  static TextStyle headline2({Color color = AppColors.blackColor}) {
    return TextStyle(
      fontFamily: _fontFamily,
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: color,
    );
  }

  // نمط العناوين الصغيرة مع إمكانية تخصيص اللون
  static TextStyle headline3({Color color = AppColors.blackColor}) {
    return TextStyle(
      fontFamily: _fontFamily,
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: color,
    );
  }

  // النص العادي بحجم كبير مع إمكانية تخصيص اللون
  static TextStyle bodyLarge({Color color = AppColors.blackColor}) {
    return TextStyle(
      fontFamily: _fontFamily,
      fontSize: 18,
      fontWeight: FontWeight.normal,
      color: color,
    );
  }

  // النص العادي بحجم متوسط مع إمكانية تخصيص اللون
  static TextStyle bodyMedium({Color color = AppColors.blackColor}) {
    return TextStyle(
      fontFamily: _fontFamily,
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: color,
    );
  }

  // النص العادي بحجم صغير مع إمكانية تخصيص اللون
  static TextStyle bodySmall({Color color = AppColors.blackColor}) {
    return TextStyle(
      fontFamily: _fontFamily,
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: color,
    );
  }

  // نمط تلميحات (Hint Text) مع إمكانية تخصيص اللون
  static TextStyle hintStyle({Color color = AppColors.blackColor}) {
    return TextStyle(
      fontFamily: _fontFamily,
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: color,
    );
  }

  // نمط للأزرار مع إمكانية تخصيص اللون
  static TextStyle buttonText({Color color = AppColors.whiteColor}) {
    return TextStyle(
      fontFamily: _fontFamily,
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: color,
    );
  }
}

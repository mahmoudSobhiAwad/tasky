import 'package:flutter/material.dart';
import 'package:tasky/core/utils/theme/app_colors.dart';
import 'package:tasky/core/utils/theme/app_fonts.dart';

void showCustomSnackBar(BuildContext context, String message,
    {Color backgroundColor = AppColor.green,
    Duration duration = const Duration(milliseconds: 1500)}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      
      content: Text(
        message,
        style: AppFontStyle.bold16.copyWith(color: AppColor.white100),
      ),
      backgroundColor: backgroundColor,
      duration: duration,
      behavior: SnackBarBehavior.fixed, // Makes it float above the content
      // Adds margin if behavior is floating
    ),
  );
}

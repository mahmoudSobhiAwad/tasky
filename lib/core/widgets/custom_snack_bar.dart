import 'package:flutter/material.dart';
import 'package:tasky/core/utils/theme/app_colors.dart';
import 'package:tasky/core/utils/theme/app_fonts.dart';

void showCustomSnackBar(BuildContext context, String message,
    {Color backgroundColor = AppColor.green100,
    Duration duration = const Duration(milliseconds: 1500)}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: AppFontStyle.bold16.copyWith(color: AppColor.white100),
      ),
      backgroundColor: backgroundColor,
      duration: duration,
      behavior: SnackBarBehavior.floating, // Makes it float above the content
      margin: const EdgeInsets.all(16), // Adds margin if behavior is floating
    ),
  );
}

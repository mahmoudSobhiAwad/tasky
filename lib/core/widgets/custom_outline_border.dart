import 'package:flutter/material.dart';
import 'package:tasky/core/utils/theme/app_colors.dart';

OutlineInputBorder customOutLineBorders(
    {double? borderRadius, Color? borderColor, double? borderWidth}) {
  return OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius ?? 10),
      borderSide: BorderSide(
        color: borderColor ?? AppColor.white100,
        width: borderWidth ?? 1,
      ));
}

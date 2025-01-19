import 'package:flutter/material.dart';
import 'package:tasky/core/utils/theme/app_colors.dart';

class CustomContainerDecoration extends StatelessWidget {
  const CustomContainerDecoration({
    super.key,
    required this.child,
    this.padding,
    this.backGroundColor,
  });
  final Widget child;
  final EdgeInsets? padding;
  final Color? backGroundColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          padding ?? EdgeInsets.only(right: 10, left: 24, top: 20, bottom: 20),
      decoration: BoxDecoration(
        color: backGroundColor ?? AppColor.lavender100,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: child,
    );
  }
}

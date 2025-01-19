import 'package:flutter/material.dart';
import 'package:tasky/core/utils/theme/app_colors.dart';

class CustomContainerDecoration extends StatelessWidget {
  const CustomContainerDecoration({
    super.key,
    required this.child,
  });
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 10, left: 24, top: 20, bottom: 20),
      decoration: const BoxDecoration(
        color: AppColor.lavender100,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: child,
    );
  }
}

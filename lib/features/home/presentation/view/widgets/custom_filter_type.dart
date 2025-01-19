import 'package:flutter/material.dart';
import 'package:tasky/core/utils/theme/app_colors.dart';
import 'package:tasky/core/utils/theme/app_fonts.dart';

class CustomFilterType extends StatelessWidget {
  const CustomFilterType(
      {super.key, required this.isPicked, required this.filterName});
  final bool isPicked;
  final String filterName;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isPicked ? AppColor.primary100 : AppColor.lavender100,
        borderRadius: const BorderRadius.all(Radius.circular(24)),
      ),
      child: Text(
        filterName,
        style: AppFontStyle.regular16.copyWith(
            color: isPicked ? AppColor.white100 : AppColor.grayMuted100),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tasky/core/utils/theme/app_colors.dart';
import 'package:tasky/core/utils/theme/app_fonts.dart';
import 'package:tasky/core/widgets/custom_container_decoration.dart';

class CustomProfileContent extends StatelessWidget {
  const CustomProfileContent(
      {super.key,
      this.trailingWidget,
      required this.title,
      required this.subTitle});
  final Widget? trailingWidget;
  final String title;
  final String subTitle;
  @override
  Widget build(BuildContext context) {
    return CustomContainerDecoration(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        backGroundColor: AppColor.lightGray100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              spacing: 4,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppFontStyle.medium12
                      .copyWith(color: AppColor.darkGray40),
                ),
                Text(
                  subTitle,
                  style:
                      AppFontStyle.bold18.copyWith(color: AppColor.darkGray60),
                ),
              ],
            ),
            trailingWidget ?? SizedBox(),
          ],
        ));
  }
}

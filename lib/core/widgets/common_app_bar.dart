import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasky/core/utils/extensions/navigation_handler.dart';
import 'package:tasky/core/utils/theme/app_fonts.dart';
import 'package:tasky/core/utils/theme/app_images.dart';

class CustomCommonAppBar extends StatelessWidget {
  const CustomCommonAppBar(
      {super.key, required this.title, this.trailingWidget});
  final String title;
  final Widget? trailingWidget;
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 5,
      children: [
        IconButton(
            onPressed: () {
              context.pop();
            },
            icon: SvgPicture.asset(AppImages.arrowLeft)),
        Text(
          title,
          style: AppFontStyle.bold16,
        ),
        Spacer(),
        trailingWidget ?? SizedBox(),
        SizedBox()
      ],
    );
  }
}

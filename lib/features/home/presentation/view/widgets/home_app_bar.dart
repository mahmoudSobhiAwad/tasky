import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasky/core/utils/theme/app_colors.dart';
import 'package:tasky/core/utils/theme/app_images.dart';

class CustomHomeAppBar extends StatelessWidget {
  const CustomHomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(AppImages.logoInside),
        Spacer(),
        IconButton(
          onPressed: null,
          icon: SvgPicture.asset(AppImages.profileIcon),
        ),
        IconButton(
          onPressed: null,
          icon: Icon(
            Icons.logout,
            color: AppColor.primary100,
          ),
        ),
      ],
    );
  }
}

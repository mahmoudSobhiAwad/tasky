import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasky/core/utils/theme/app_colors.dart';
import 'package:tasky/core/utils/theme/app_fonts.dart';
import 'package:tasky/core/utils/theme/app_images.dart';

class TaskDateInDateDetails extends StatelessWidget {
  const TaskDateInDateDetails({
    super.key,
    this.date,
  });
  final String? date;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'End Date',
              style:
                  AppFontStyle.regular9.copyWith(color: AppColor.grayPurple100),
            ),
            Text(
              date ?? '',
              style: AppFontStyle.regular14,
            ),
          ],
        ),
        SvgPicture.asset(AppImages.calendarIcon),
      ],
    );
  }
}

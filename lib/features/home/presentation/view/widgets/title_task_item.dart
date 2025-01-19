import 'package:flutter/material.dart';
import 'package:tasky/core/utils/theme/app_colors.dart';
import 'package:tasky/core/utils/theme/app_fonts.dart';

class TitleOfTaskItem extends StatelessWidget {
  const TitleOfTaskItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 5,
      children: [
        Expanded(
            child: Text(
          "Grocery Shopping App",
          style: AppFontStyle.bold16,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        )),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: AppColor.pinkSoft100,
          ),
          child: Text(
            "Waiting",
            style: AppFontStyle.medium12.copyWith(color: AppColor.coral100),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasky/core/utils/theme/app_colors.dart';
import 'package:tasky/core/utils/theme/app_fonts.dart';

class PirorityInTaskDetails extends StatelessWidget {
  const PirorityInTaskDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 3,
      children: [
        Icon(
          CupertinoIcons.flag,
          color: AppColor.primary100,
        ),
        Text(
          "Medium Priority",
          style: AppFontStyle.bold16.copyWith(color: AppColor.primary100),
        ),
        Spacer(),
        PopupMenuButton(
            child: Icon(
              size: 20,
              CupertinoIcons.arrowtriangle_down_fill,
              color: AppColor.primary100,
            ),
            itemBuilder: (context) {
              return [];
            }),
      ],
    );
  }
}

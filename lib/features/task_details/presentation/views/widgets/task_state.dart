import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasky/core/utils/theme/app_colors.dart';
import 'package:tasky/core/utils/theme/app_fonts.dart';

class StateInTaskDetails extends StatelessWidget {
  const StateInTaskDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Inprogress",
          style: AppFontStyle.bold16.copyWith(color: AppColor.primary100),
        ),
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

import 'package:flutter/material.dart';
import 'package:tasky/core/utils/theme/app_colors.dart';
import 'package:tasky/core/utils/theme/app_fonts.dart';

class TrailingOfTaskItem extends StatelessWidget {
  const TrailingOfTaskItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        color: AppColor.white100,
        elevation: 10,
        borderRadius: BorderRadius.all(Radius.circular(12)),
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              child: Text(
                "Edit",
                style: AppFontStyle.medium16,
              ),
            ),
            PopupMenuItem(
              child: Text(
                "Delete",
                style: AppFontStyle.medium16.copyWith(color: AppColor.coral100),
              ),
            ),
          ];
        });
  }
}

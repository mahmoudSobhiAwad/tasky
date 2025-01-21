import 'package:flutter/material.dart';
import 'package:tasky/core/utils/theme/app_colors.dart';
import 'package:tasky/core/utils/theme/app_fonts.dart';
import 'package:tasky/core/widgets/custom_push_button.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog(
      {super.key,
      required this.mainTitle,
      this.subTitle,
      this.bigIcon,
      this.firstActionName,
      this.secondActionName,
      this.onTapFirstAction,
      this.isLoading = false,
      this.onTapSecondAction});
  final String mainTitle;
  final String? subTitle;
  final String? firstActionName;
  final String? secondActionName;
  final void Function()? onTapFirstAction;
  final void Function()? onTapSecondAction;
  final Widget? bigIcon;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetAnimationDuration: Duration.zero,
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: const BoxDecoration(
            color: AppColor.white100,
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 10,
          children: [
            Text(
              mainTitle,
              style: AppFontStyle.bold16,
            ),
            if (subTitle != null)
              Text(
                "$subTitle",
                style: AppFontStyle.regular14,
              ),
            if (bigIcon != null) bigIcon!,
            Row(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (firstActionName != null)
                  Expanded(
                    child: CustomPushButton(
                      backgroundColor: AppColor.red100,
                      onTap: onTapFirstAction,
                      title: firstActionName!,
                    ),
                  ),
                if (secondActionName != null)
                  Expanded(
                    child: CustomPushButton(
                      isLoading: isLoading,
                      backgroundColor: AppColor.green,
                      onTap: onTapSecondAction,
                      title: secondActionName!,
                    ),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

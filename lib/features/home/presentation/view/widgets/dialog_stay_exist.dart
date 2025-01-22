import 'package:flutter/material.dart';
import 'package:tasky/core/utils/extensions/navigation_handler.dart';
import 'package:tasky/core/utils/theme/app_colors.dart';
import 'package:tasky/core/widgets/custom_dialog.dart';

Future<bool?> showDialogToStayOrExit(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return CustomDialog(
          bigIcon: CircleAvatar(
            radius: 30,
            backgroundColor: AppColor.primary100,
            child: Center(
                child: Icon(
              Icons.logout_rounded,
              size: 40,
              color: AppColor.white100,
            )),
          ),
          mainTitle: "Are you Sure To Exist",
          firstActionName: "Exit",
          secondActionName: "Stay",
          onTapSecondAction: () {
            context.pop();
          },
          onTapFirstAction: () {
            context.pop(true);
          },
        );
      });
}

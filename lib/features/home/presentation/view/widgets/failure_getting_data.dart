import 'package:flutter/material.dart';
import 'package:tasky/core/utils/theme/app_colors.dart';
import 'package:tasky/core/utils/theme/app_fonts.dart';

class FailureGettingTasks extends StatelessWidget {
  const FailureGettingTasks({
    super.key,
    required this.errMessage,
    required this.refresh,
  });

  final String errMessage;
  final void Function() refresh;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          errMessage,
          style: AppFontStyle.bold16,
        ),
        Icon(
          Icons.warning,
          color: AppColor.red100,
          size: 70,
        ),
        InkWell(
          onTap: refresh,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Refresh !", style: AppFontStyle.bold16),
              Icon(Icons.refresh, color: AppColor.primary100)
            ],
          ),
        )
      ],
    );
  }
}

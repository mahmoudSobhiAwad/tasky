import 'package:flutter/material.dart';
import 'package:tasky/core/utils/extensions/media_query_handler.dart';
import 'package:tasky/core/utils/extensions/navigation_handler.dart';
import 'package:tasky/core/utils/theme/app_colors.dart';
import 'package:tasky/core/utils/theme/app_fonts.dart';
import 'package:tasky/core/utils/widgets/custom_push_button.dart';
import 'package:tasky/features/login/presentation/view/login_view.dart';
import 'package:tasky/features/on_boarding/data/constants.dart';

class TitlesWithButton extends StatelessWidget {
  const TitlesWithButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      children: [
        SizedBox(
          width: context.screenWidth * 0.75,
          child: Text(
            "Task Management &\nTo-Do List",
            style: AppFontStyle.bold24,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          width: context.screenWidth * 0.75,
          child: Text(
            secTitle,
            textAlign: TextAlign.center,
            style:
                AppFontStyle.regular14.copyWith(color: AppColor.grayPurple100),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        CustomPushButton(
          title: "Let’s Start",
          enableArrow: true,
          onTap: () {
            context.push(LoginView());
          },
        ),
      ],
    );
  }
}

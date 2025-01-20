import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tasky/core/utils/theme/app_colors.dart';
import 'package:tasky/core/utils/theme/app_fonts.dart';

class HavingAccountLoginOrSignUp extends StatelessWidget {
  const HavingAccountLoginOrSignUp({
    super.key,
    required this.mainText,
    required this.actionText,
    required this.onTapActionText,
  });
  final String mainText;
  final String actionText;
  final void Function() onTapActionText;
  @override
  Widget build(BuildContext context) {
    return Text.rich(TextSpan(
      text: mainText,
      style: AppFontStyle.regular14.copyWith(color: AppColor.gray13),
      children: [
        TextSpan(
          text: actionText,
          style: AppFontStyle.bold14
              .copyWith(color: AppColor.primary100)
              .copyWith(
                  decoration: TextDecoration.underline,
                  decorationColor: AppColor.primary100),
          recognizer: TapGestureRecognizer()..onTap = onTapActionText,
        ),
      ],
    ));
  }
}

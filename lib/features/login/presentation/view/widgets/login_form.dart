import 'package:flutter/material.dart';
import 'package:tasky/core/utils/extensions/navigation_handler.dart';
import 'package:tasky/core/utils/theme/app_colors.dart';
import 'package:tasky/core/utils/theme/app_fonts.dart';
import 'package:tasky/core/widgets/custom_push_button.dart';
import 'package:tasky/core/widgets/custom_rich_text.dart';
import 'package:tasky/core/widgets/custom_text_field.dart';
import 'package:tasky/features/home/presentation/view/home_view.dart';
import 'package:tasky/features/login/presentation/view/widgets/phone_from.dart';
import 'package:tasky/features/sign_up/presentation/view/sign_up_view.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 20,
      children: [
        Text(
          "Login",
          style: AppFontStyle.bold24.copyWith(color: AppColor.black100),
        ),
        const PhoneFormField(),
        CustomTextFormField(
          label: 'Password',
          labelStyle: AppFontStyle.regular14.copyWith(color: AppColor.gray13),
          suffixWidget: const IconButton(
              onPressed: null,
              icon: Icon(
                Icons.visibility,
                color: AppColor.gray100,
              )),
        ),
        CustomPushButton(
          title: 'Sign In',
          onTap: () => context.push(HomeView()),
          textStyle: AppFontStyle.bold16.copyWith(color: AppColor.white100),
        ),
        Center(
          child: HavingAccountLoginOrSignUp(
              mainText: 'Didn’t have any account?  ',
              actionText: 'Sign Up here',
              onTapActionText: () {
                context.push(SignUpView());
              }),
        ),
        const SizedBox(),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tasky/core/utils/extensions/media_query_handler.dart';
import 'package:tasky/core/utils/extensions/navigation_handler.dart';
import 'package:tasky/core/utils/theme/app_colors.dart';
import 'package:tasky/core/utils/theme/app_fonts.dart';
import 'package:tasky/core/utils/widgets/custom_boarding_image.dart';
import 'package:tasky/core/utils/widgets/custom_push_button.dart';
import 'package:tasky/core/utils/widgets/custom_rich_text.dart';
import 'package:tasky/core/utils/widgets/custom_text_field.dart';
import 'package:tasky/features/login/presentation/view/widgets/phone_from.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomBoardinImage(
              height: context.screenHeight * 0.2,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                spacing: 16,
                children: [
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      'Sign Up',
                      style: AppFontStyle.bold24,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  CustomTextFormField(label: 'Name...'),
                  PhoneFormField(),
                  CustomTextFormField(label: 'Years of experience...'),
                  CustomTextFormField(
                      isReadOnly: true,
                      controller: TextEditingController(
                          text: 'Choose experience Level'),
                      suffixWidget: PopupMenuButton(
                          icon: Icon(Icons.keyboard_arrow_down_rounded),
                          itemBuilder: (context) {
                            return [];
                          })),
                  CustomTextFormField(label: 'Address...'),
                  CustomTextFormField(label: 'Password...'),
                  CustomPushButton(
                    title: 'Sign up',
                    textStyle: AppFontStyle.bold16
                        .copyWith(color: AppColor.white100),
                  ),
                  Center(
                    child: HavingAccountLoginOrSignUp(
                        mainText: 'Already have any account? ',
                        actionText: 'Sign in',
                        onTapActionText: () {
                          context.pop();
                        }),
                  ),
                  SizedBox(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

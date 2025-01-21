import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/utils/extensions/navigation_handler.dart';
import 'package:tasky/core/utils/theme/app_colors.dart';
import 'package:tasky/core/utils/theme/app_fonts.dart';
import 'package:tasky/core/widgets/custom_push_button.dart';
import 'package:tasky/core/widgets/custom_rich_text.dart';
import 'package:tasky/core/widgets/custom_text_field.dart';
import 'package:tasky/features/login/presentation/manager/cubit/login_cubit.dart';
import 'package:tasky/features/login/presentation/view/widgets/phone_from.dart';
import 'package:tasky/features/sign_up/presentation/view/sign_up_view.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late final TextEditingController phoneController;
  late final TextEditingController passwordController;
  late Country country;
  bool isVisible = false;

  @override
  void initState() {
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    country = Country.parse('EG');
    super.initState();
  }

  @override
  void dispose() {
    passwordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<LoginCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 20,
      children: [
        Text(
          "Login",
          style: AppFontStyle.bold24.copyWith(color: AppColor.black100),
        ),
        BlocBuilder<LoginCubit, LoginState>(
          buildWhen: (prev, curr) {
            return curr is ChangeCounrtyPickedState;
          },
          builder: (context, state) {
            if (state is ChangeCounrtyPickedState) {
              country = state.country;
            }
            return PhoneFormField(
              changeCountry: (counrty) {
                cubit.changeCountryPicked(counrty);
              },
              country: country,
              phoneController: phoneController,
            );
          },
        ),
        BlocBuilder<LoginCubit, LoginState>(
          buildWhen: (prev, curr) {
            return curr is ChangeVisibilityState;
          },
          builder: (context, state) {
            if (state is ChangeVisibilityState) {
              isVisible = state.value;
            }
            return CustomTextFormField(
              maxLine: 1,
              isObeseureText: isVisible,
              label: 'Password',
              controller: passwordController,
              labelStyle:
                  AppFontStyle.regular14.copyWith(color: AppColor.gray13),
              suffixWidget: IconButton(
                  onPressed: () {
                    cubit.changePasswordVisibility(isVisible);
                  },
                  icon: Icon(
                  isVisible?Icons.visibility_off:Icons.visibility,
                    color: AppColor.gray100,
                  )),
            );
          },
        ),
        BlocBuilder<LoginCubit, LoginState>(
          buildWhen: (prev, curr) {
            return curr is LoginProccessState;
          },
          builder: (context, state) {
            return CustomPushButton(
              isLoading: state is LoginLoadingState ? true : false,
              title: 'Sign In',
              onTap: () {
                cubit.login(
                    passowrd: passwordController.text,
                    phoneNuber: '+${country.phoneCode}${phoneController.text}');
              },
              textStyle: AppFontStyle.bold16.copyWith(color: AppColor.white100),
            );
          },
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

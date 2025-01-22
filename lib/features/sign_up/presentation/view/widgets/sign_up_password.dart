import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/utils/theme/app_colors.dart';
import 'package:tasky/core/widgets/custom_text_field.dart';
import 'package:tasky/features/sign_up/presentation/manager/cubit/sign_up_cubit.dart';

class CustomPassowrdSignUp extends StatelessWidget {
  const CustomPassowrdSignUp({
    super.key,
    required this.passwordController,
  });

  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (prev, curr) {
        return curr is ChangeVisibiltyOfPasswordState;
      },
      builder: (context, state) {
        bool isObescured = false;
        if (state is ChangeVisibiltyOfPasswordState) {
          isObescured = state.value;
        }
        return CustomTextFormField(
          label: 'Password...',
          validator: (value) {
            if (!(value != null && value.trim().isNotEmpty)) {
              return 'Passowrd Can\'t be empty';
            }
            return null;
          },
          isObeseureText: !isObescured,
          controller: passwordController,
          maxLine: 1,
          suffixWidget: IconButton(
              onPressed: () {
                context
                    .read<SignUpCubit>()
                    .changePasswordVisibility(isObescured);
              },
              icon: Icon(
                isObescured
                    ? Icons.visibility_rounded
                    : Icons.visibility_off_rounded,
                color: AppColor.gray13,
              )),
        );
      },
    );
  }
}

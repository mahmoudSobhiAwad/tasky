import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/utils/constants/var_contstant.dart';
import 'package:tasky/core/utils/theme/app_colors.dart';
import 'package:tasky/core/utils/theme/app_fonts.dart';
import 'package:tasky/core/widgets/custom_push_button.dart';
import 'package:tasky/core/widgets/custom_text_field.dart';
import 'package:tasky/features/login/presentation/view/widgets/phone_from.dart';
import 'package:tasky/features/sign_up/data/models/create_acc_model.dart';
import 'package:tasky/features/sign_up/presentation/manager/cubit/sign_up_cubit.dart';
import 'package:tasky/features/sign_up/presentation/view/widgets/sign_up_password.dart';
import 'package:tasky/features/sign_up/presentation/view/widgets/exp_level.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key, this.pickedCountryCode});
  final String? pickedCountryCode;
  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  late final TextEditingController nameController;
  late final TextEditingController phoneController;
  late final TextEditingController yearExpController;
  String expLevel = expLevelParam;
  late final TextEditingController addressController;
  late final TextEditingController passwordController;
  final _formKey = GlobalKey<FormState>();
  late String countryCode;

  @override
  void initState() {
    nameController = TextEditingController();
    phoneController = TextEditingController();
    yearExpController = TextEditingController();
    addressController = TextEditingController();
    passwordController = TextEditingController();
    countryCode = widget.pickedCountryCode ?? "+20";
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    yearExpController.dispose();
    addressController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        spacing: 16,
        children: [
          CustomTextFormField(
            validator: (value) {
              if (!(value != null && value.trim().isNotEmpty)) {
                return 'Name Can\'t be empty';
              }
              return null;
            },
            label: 'Name...',
            controller: nameController,
            maxLine: 1,
          ),
          BlocBuilder<SignUpCubit, SignUpState>(
            buildWhen: (prev, curr) {
              return curr is ChangeCountryCodeState;
            },
            builder: (context, state) {
              if (state is ChangeCountryCodeState) {}
              return PhoneFormField(
                phoneController: phoneController,
                initialCountryCode: countryCode,
                changeCountryPicked: (counrty) {
                  countryCode = counrty.dialCode;
                },
              );
            },
          ),
          CustomTextFormField(
            label: 'Years of experience...',
            controller: yearExpController,
            maxLine: 1,
            validator: (value) {
              if (!(value != null && value.trim().isNotEmpty)) {
                return 'Years of experience Can\'t be empty';
              }
              return null;
            },
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            textInputType: TextInputType.number,
          ),
          BlocBuilder<SignUpCubit, SignUpState>(buildWhen: (prev, current) {
            return current is ChangeExperienceLevelState;
          }, builder: (context, state) {
            if (state is ChangeExperienceLevelState) {
              expLevel = state.value;
            }
            return ExpereinceLevel(expLevel: expLevel);
          }),
          CustomTextFormField(
            label: 'Address...',
            validator: (value) {
              if (!(value != null && value.trim().isNotEmpty)) {
                return 'Address Can\'t be empty';
              }
              return null;
            },
            controller: addressController,
            maxLine: 1,
          ),
          CustomPassowrdSignUp(passwordController: passwordController),
          BlocBuilder<SignUpCubit, SignUpState>(
            builder: (context, state) {
              return CustomPushButton(
                isLoading: (state is PhoneValidationLoadingState ||
                        state is SignUpLoadingState)
                    ? true
                    : false,
                title: 'Sign up',
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<SignUpCubit>().createAccount(
                        CreateAccountModel(
                            name: nameController.text,
                            address: addressController.text.isEmpty
                                ? null
                                : addressController.text,
                            password: passwordController.text,
                            expLevel:
                                expLevel == expLevelParam ? null : expLevel,
                            expYear: yearExpController.text.isEmpty
                                ? null
                                : yearExpController.text,
                            phone: '+$countryCode${phoneController.text}'));
                  }
                },
                textStyle:
                    AppFontStyle.bold16.copyWith(color: AppColor.white100),
              );
            },
          ),
        ],
      ),
    );
  }
}

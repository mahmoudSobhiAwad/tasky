import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/utils/theme/app_colors.dart';
import 'package:tasky/core/utils/theme/app_fonts.dart';
import 'package:tasky/core/widgets/custom_push_button.dart';
import 'package:tasky/core/widgets/custom_text_field.dart';
import 'package:tasky/features/login/presentation/view/widgets/phone_from.dart';
import 'package:tasky/features/sign_up/presentation/manager/cubit/sign_up_cubit.dart';
import 'package:tasky/features/sign_up/presentation/view/widgets/custom_sign_up_button.dart';
import 'package:tasky/features/sign_up/presentation/view/widgets/exp_level_with_cubit.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  late final TextEditingController nameController;
  late final TextEditingController phoneController;
  late final TextEditingController yearExpController;
  late final TextEditingController expLevelController;
  late final TextEditingController addressController;
  late final TextEditingController passwordController;
  late Country country;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    nameController = TextEditingController();
    phoneController = TextEditingController();
    yearExpController = TextEditingController();
    expLevelController = TextEditingController(text: 'Choose experience Level');
    addressController = TextEditingController();
    passwordController = TextEditingController();
    country = Country.parse('EG');
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
              if (state is ChangeCountryCodeState) {
                country = state.country;
              }
              return PhoneFormField(
                validator: (value) {
                  if (!(value != null && value.trim().isNotEmpty)) {
                    return 'Phone Can\'t be empty';
                  }
                  return null;
                },
                phoneController: phoneController,
                changeCountry: (country) {
                  context.read<SignUpCubit>().changeCountryPicked(country);
                },
                country: country,
              );
            },
          ),
          CustomTextFormField(
            validator: (value) {
              if (!(value != null && value.trim().isNotEmpty)) {
                return 'Year of Experience Can\'t be empty';
              }
              return null;
            },
            label: 'Years of experience...',
            controller: yearExpController,
            maxLine: 1,
            textInputType: TextInputType.number,
          ),
          ExpereinceLevelWithCubit(
              validator: (value) {
                if (value == 'Choose experience Level') {
                  return 'You Have to Set exp level Can\'t be empty';
                }
                return null;
              },
              expLevelController: expLevelController),
          CustomTextFormField(
            validator: (value) {
              if (!(value != null && value.trim().isNotEmpty)) {
                return 'Address Can\'t be empty';
              }
              return null;
            },
            label: 'Address...',
            controller: addressController,
            maxLine: 1,
          ),
          CustomPassowrdSignUp(passwordController: passwordController),
          BlocBuilder<SignUpCubit, SignUpState>(
            builder: (context, state) {
              return CustomPushButton(
                isLoading: state is PhoneValidationLoadingState ? true : false,
                title: 'Sign up',
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<SignUpCubit>().validatePhoneNumber(
                        phoneNumber: phoneController.text,
                        countryCode: country.phoneCode);
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


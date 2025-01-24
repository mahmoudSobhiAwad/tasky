import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/utils/extensions/media_query_handler.dart';
import 'package:tasky/core/utils/extensions/navigation_handler.dart';
import 'package:tasky/core/utils/functions/api_services/to_do_api_handler.dart';
import 'package:tasky/core/utils/functions/service_locator.dart';
import 'package:tasky/core/utils/theme/app_colors.dart';
import 'package:tasky/core/utils/theme/app_fonts.dart';
import 'package:tasky/core/widgets/custom_boarding_image.dart';
import 'package:tasky/core/widgets/custom_rich_text.dart';
import 'package:tasky/core/widgets/custom_snack_bar.dart';
import 'package:tasky/features/home/presentation/view/home_view.dart';
import 'package:tasky/features/sign_up/data/repos/phone_validation_repo_imp.dart';
import 'package:tasky/features/sign_up/presentation/manager/cubit/sign_up_cubit.dart';
import 'package:tasky/features/sign_up/presentation/view/widgets/sign_up_form.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(
          phoneValidationRepoImp: getIt.get<PhoneValidationRepoImp>(),
          apiHandlerImp: getIt.get<ApiHandlerImp>()),
      child: BlocListener<SignUpCubit, SignUpState>(
        listener: (context, state) async {
          if (state is PhoneValidationFailureState) {
            showCustomSnackBar(context, state.errMessage ?? "",
                backgroundColor: AppColor.red100);
          } else if (state is PhoneValidationSuccessState) {
            showCustomSnackBar(
              context,
              "Phone Number Validated Successfully",
            );
          } else if (state is SignUpFailureState) {
            showCustomSnackBar(context, state.errMessage ?? "",
                backgroundColor: AppColor.red100);
          } else if (state is SignUpSuccessState) {
            context.pushReplacement(HomeView());
          }
        },
        child: SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10,),
                  CustomBoardinImage(
                    isSignUp: true,
                    height: context.screenHeight * 0.2,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 24,
                      children: [
                        Text(
                          'Sign Up',
                          style: AppFontStyle.bold24,
                        ),
                        const SignUpForm(),
                        Center(
                          child: HavingAccountLoginOrSignUp(
                              mainText: 'Already have any account? ',
                              actionText: 'Sign in',
                              onTapActionText: () {
                                context.pop();
                              }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

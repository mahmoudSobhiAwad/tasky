import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/utils/extensions/navigation_handler.dart';
import 'package:tasky/core/database/api/api_consumer.dart';
import 'package:tasky/core/utils/functions/service_locator.dart';
import 'package:tasky/core/utils/theme/app_colors.dart';
import 'package:tasky/core/widgets/custom_boarding_image.dart';
import 'package:tasky/core/widgets/custom_snack_bar.dart';
import 'package:tasky/features/home/presentation/view/home_view.dart';
import 'package:tasky/features/login/presentation/manager/cubit/login_cubit.dart';
import 'package:tasky/features/login/presentation/view/widgets/login_form.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (context) =>
          LoginCubit(apiHandlerImp: getIt.get<ApiHandlerImp>()),
      child: BlocListener<LoginCubit, LoginState>(
        listenWhen: (prev, curr) {
          return curr is LoginProccessState;
        },
        listener: (context, state) {
          if (state is LoginSuccessState) {
            context.pushReplacement(HomeView());
          } else if (state is LoginFailureState) {
            showCustomSnackBar(context, state.errMessage ?? "",
                backgroundColor: AppColor.red100);
          }
        },
        child: const Scaffold(
          body: Column(
            children: [
              Expanded(child: CustomBoardinImage()),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: LoginForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

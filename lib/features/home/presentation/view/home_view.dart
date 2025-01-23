import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/utils/extensions/navigation_handler.dart';
import 'package:tasky/core/utils/functions/service_locator.dart';
import 'package:tasky/core/utils/theme/app_colors.dart';
import 'package:tasky/core/widgets/custom_snack_bar.dart';
import 'package:tasky/features/home/data/repos/home_repo_impl.dart';
import 'package:tasky/features/home/presentation/manager/cubit/home_cubit.dart';
import 'package:tasky/features/home/presentation/view/widgets/custom_floating_buttons.dart';
import 'package:tasky/features/home/presentation/view/widgets/dialog_stay_exist.dart';
import 'package:tasky/features/home/presentation/view/widgets/home_body.dart';
import 'package:tasky/features/login/presentation/view/login_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(homeRepoImp: getIt.get<HomeRepoImp>())
        ..getAllTasks()
        ..addListenToScroll(),
      child: BlocListener<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is LogOutFailureState) {
            showCustomSnackBar(context, state.errMessage ?? "",
                backgroundColor: AppColor.red100);
          } else if (state is LogOutSuccessState) {
            context.pushReplacement(LoginView());
          } else if (state is RefreshFailedState) {
            context.pushReplacement(LoginView());
          } else if (state is GetAllTasksFailureState) {
            showCustomSnackBar(context, state.errMessage ?? "",
                backgroundColor: AppColor.red100);
          } else if (state is GetAllTasksFailureState) {
            showCustomSnackBar(context, state.errMessage ?? "",
                backgroundColor: AppColor.red100);
          }
        },
        child: PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) async {
            if (didPop) {
              return;
            }
            bool checkAfter = false;
            checkAfter = await showDialogToStayOrExit(context) ?? false;

            if (checkAfter && context.mounted) {
              SystemNavigator.pop();
            }
          },
          child: SafeArea(
            child: Scaffold(
              body: HomeBody(),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endFloat,
              floatingActionButton: BlocBuilder<HomeCubit, HomeState>(
                buildWhen: (prev, curr) {
                  return curr is ChangeFabVisibilityState;
                },
                builder: (context, state) {
                  if (state is ChangeFabVisibilityState) {
                    return state.isFabVisible
                        ? CustomFloatingButtons()
                        : SizedBox();
                  }
                  return CustomFloatingButtons();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

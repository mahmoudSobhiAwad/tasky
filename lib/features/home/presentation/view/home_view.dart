import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ScrollController _scrollController = ScrollController();
  bool _isFabVisible = true;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (_isFabVisible) {
        setState(() {
          _isFabVisible = false;
        });
      }
    } else if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      if (!_isFabVisible) {
        setState(() {
          _isFabVisible = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(homeRepoImp: getIt.get<HomeRepoImp>()),
      child: BlocListener<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is LogOutFailureState) {
            showCustomSnackBar(context, state.errMessage ?? "",
                backgroundColor: AppColor.red100);
          } else if (state is LogOutSuccessState) {
            context.pushReplacement(LoginView());
          } else if (state is RefreshFailedState) {
            context.pushReplacement(LoginView());
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
          child: Builder(builder: (context) {
            var cubit = context.read<HomeCubit>();
            return SafeArea(
              child: Scaffold(
                body: HomeBody(
                  cubit: cubit,
                  scrollController: _scrollController,
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.endFloat,
                floatingActionButton:
                    _isFabVisible ? CustomFloatingButtons() : null,
              ),
            );
          }),
        ),
      ),
    );
  }
}

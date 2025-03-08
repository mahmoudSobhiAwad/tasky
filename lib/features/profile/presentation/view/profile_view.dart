import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tasky/core/database/api/api_consumer.dart';
import 'package:tasky/core/utils/functions/service_locator.dart';
import 'package:tasky/core/utils/theme/app_colors.dart';
import 'package:tasky/core/widgets/common_app_bar.dart';
import 'package:tasky/core/widgets/custom_snack_bar.dart';
import 'package:tasky/features/home/presentation/view/widgets/failure_getting_data.dart';
import 'package:tasky/features/profile/data/model/profile_model.dart';
import 'package:tasky/features/profile/presentation/manager/cubit/profile_cubit.dart';
import 'package:tasky/features/profile/presentation/view/widgets/custom_profile_item.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProfileCubit(apiHandlerImp: getIt.get<ApiHandlerImp>())
            ..getProfileData(),
      child: SafeArea(
        child: Scaffold(
          body: Column(
            spacing: 24,
            children: [
              CustomCommonAppBar(title: 'Profile'),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 22),
                  child: BlocBuilder<ProfileCubit, ProfileState>(
                    builder: (context, state) {
                      if (state is ProfileFailureState) {
                        return FailureGettingTasks(
                            errMessage: state.errMessage ?? "", refresh: () {});
                      } else if (state is ProfileLoadingState) {
                        return Skeletonizer(
                          enabled: true,
                          child: ProfileBody(),
                        );
                      } else if (state is ProfileSuccessState) {
                        return ProfileBody(
                          model: state.profileModel,
                        );
                      }
                      return SizedBox();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileBody extends StatelessWidget {
  const ProfileBody({
    super.key,
    this.model,
  });
  final ProfileModel? model;

  @override
  Widget build(BuildContext context) {
    return Column(spacing: 8, children: [
      CustomProfileContent(
        title: 'Name',
        subTitle: model?.name ?? "",
      ),
      CustomProfileContent(
        title: 'Phone',
        subTitle: model?.phone ?? "",
        trailingWidget: IconButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: model?.phone ?? ""));
              showCustomSnackBar(context, "Copied to clipboard");
            },
            icon: Icon(
              Icons.content_copy_rounded,
              color: AppColor.primary100,
            )),
      ),
      CustomProfileContent(
        title: 'Level',
        subTitle: model?.expLevel ?? "",
      ),
      CustomProfileContent(
        title: 'Years of experience',
        subTitle: '${model?.experienceYear} years',
      ),
      CustomProfileContent(
        title: 'Location',
        subTitle: '${model?.address}',
      ),
    ]);
  }
}

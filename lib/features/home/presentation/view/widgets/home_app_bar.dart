import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasky/core/utils/extensions/navigation_handler.dart';
import 'package:tasky/core/utils/theme/app_colors.dart';
import 'package:tasky/core/utils/theme/app_images.dart';
import 'package:tasky/core/widgets/custom_dialog.dart';
import 'package:tasky/features/profile/presentation/view/profile_view.dart';

class CustomHomeAppBar extends StatelessWidget {
  const CustomHomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(AppImages.logoInside),
        Spacer(),
        IconButton(
          onPressed: () => context.push(ProfileView()),
          icon: SvgPicture.asset(AppImages.profileIcon),
        ),
        IconButton(
          onPressed: () {
            showDialog<bool>(
                context: context,
                builder: (context) {
                  return CustomDialog(
                    mainTitle: "Are You Sure To Logout",
                    subTitle: "We are gonna miss you",
                    firstActionName: "Logout",
                    secondActionName: "Stay",
                    onTapFirstAction: () {
                      context.pop(true);
                    },
                    onTapSecondAction: () {
                      context.pop();
                    },
                    bigIcon: Icon(
                      Icons.heart_broken_rounded,
                      size: 40,
                      color: AppColor.red100,
                    ),
                  );
                });
          },
          icon: Icon(
            Icons.logout,
            color: AppColor.primary100,
          ),
        ),
      ],
    );
  }
}

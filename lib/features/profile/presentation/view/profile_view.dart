import 'package:flutter/material.dart';
import 'package:tasky/core/utils/theme/app_colors.dart';
import 'package:tasky/core/widgets/common_app_bar.dart';
import 'package:tasky/features/profile/presentation/view/widgets/custom_profile_item.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          spacing: 24,
          children: [
            CustomCommonAppBar(title: 'Profile'),
            Expanded(
                child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 22),
              child: Column(spacing: 8, children: [
                CustomProfileContent(
                  title: 'Name',
                  subTitle: 'Islam Sayed',
                ),
                CustomProfileContent(
                  title: 'Phone',
                  subTitle: '+20 123 456-7890',
                  trailingWidget: IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.content_copy_rounded,
                        color: AppColor.primary100,
                      )),
                ),
                CustomProfileContent(
                  title: 'Level',
                  subTitle: 'Senior',
                ),
                CustomProfileContent(
                  title: 'Years of experience',
                  subTitle: '7 years',
                ),
                CustomProfileContent(
                  title: 'Location',
                  subTitle: 'Fayyum, Egypt',
                ),
              ]),
            )),
          ],
        ),
      ),
    );
  }
}

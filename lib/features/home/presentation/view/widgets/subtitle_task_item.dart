import 'package:flutter/cupertino.dart';
import 'package:tasky/core/utils/theme/app_colors.dart';
import 'package:tasky/core/utils/theme/app_fonts.dart';

class SubTitleOfTaskItem extends StatelessWidget {
  const SubTitleOfTaskItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          textAlign: TextAlign.start,
          testBig,
          style: AppFontStyle.regular14.copyWith(color: AppColor.gray13),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Row(
          spacing: 5,
          children: [
            Icon(
              CupertinoIcons.flag,
              color: AppColor.primary100,
            ),
            Text(
              "Low",
              style: AppFontStyle.medium12.copyWith(color: AppColor.primary100),
            ),
            Spacer(),
            Text(
              "30/12/2022",
              style: AppFontStyle.medium12.copyWith(color: AppColor.gray13),
            ),
          ],
        )
      ],
    );
  }
}

String testBig = ''' This application is designed for super shops. By using 
this application they can enlist all their products in one 
place and can deliver. Customers will get a one-stop 
solution for their daily shopping''';

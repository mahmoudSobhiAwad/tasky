import 'package:flutter/cupertino.dart';
import 'package:tasky/core/utils/theme/app_colors.dart';
import 'package:tasky/core/utils/theme/app_fonts.dart';
import 'package:tasky/features/create_edit_task/data/models/priority_model.dart';

class SubTitleOfTaskItem extends StatelessWidget {
  const SubTitleOfTaskItem({
    super.key,
    this.subTitle,
    this.model,
    this.date,
  });
  final String? subTitle;
  final PriorityModel? model;
  final String? date;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          textAlign: TextAlign.start,
          subTitle??"",
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
              model?.title ?? "",
              style: AppFontStyle.medium12.copyWith(color: model?.color),
            ),
            Spacer(),
            Text(
              date ?? "",
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

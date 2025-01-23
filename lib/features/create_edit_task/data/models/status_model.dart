import 'dart:ui';

import 'package:tasky/core/utils/theme/app_colors.dart';

class StatusModel {
  String title;
  Color backgroundColor;
  Color textColor;
  StatusModel(
      {required this.backgroundColor,
      required this.textColor,
      required this.title});
}

List<StatusModel?> statusList = [
  StatusModel(
      backgroundColor: AppColor.pinkSoft100,
      textColor: AppColor.coral100,
      title: 'waiting'),
  StatusModel(
      backgroundColor: AppColor.lavender100,
      textColor: AppColor.primary100,
      title: 'inprogress'),
  StatusModel(
      backgroundColor: AppColor.bluePale100,
      textColor: AppColor.blueBright100,
      title: 'finished'),
];

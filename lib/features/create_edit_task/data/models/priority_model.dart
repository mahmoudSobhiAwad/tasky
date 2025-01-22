import 'dart:ui';

import 'package:tasky/core/utils/theme/app_colors.dart';

class PriorityModel {
  String title;
  Color color;
  PriorityModel({required this.color, required this.title});
}

List<PriorityModel> pirorityList = [
  PriorityModel(color: AppColor.blueBright100, title: 'low'),
  PriorityModel(color: AppColor.primary100, title: 'medium'),
  PriorityModel(color: AppColor.coral100, title: 'high'),
];

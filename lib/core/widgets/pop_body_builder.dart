import 'package:flutter/material.dart';
import 'package:tasky/core/utils/theme/app_colors.dart';

class PopBodyBuilder extends StatelessWidget {
  const PopBodyBuilder({super.key, required this.item});
  final List<Widget> item;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemBuilder: (context, index) {
          return item[index];
        },
        separatorBuilder: (context, index) {
          return Divider(
            color: AppColor.gray13,
          );
        },
        itemCount: item.length);
  }
}

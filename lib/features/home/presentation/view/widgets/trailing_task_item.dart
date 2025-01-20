import 'package:flutter/material.dart';
import 'package:popover/popover.dart';
import 'package:tasky/core/utils/theme/app_colors.dart';
import 'package:tasky/core/utils/theme/app_fonts.dart';

class TrailingOfTaskItem extends StatelessWidget {
  const TrailingOfTaskItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showPopover(
            direction: PopoverDirection.bottom,
            arrowHeight: 10,
            arrowWidth: 20,
            constraints: BoxConstraints(maxHeight: 87, maxWidth: 81),
            context: context,
            bodyBuilder: (context) => Center(
                  child: PopBodyBuilder(item: [
                    Text(
                      "Edit",
                      style: AppFontStyle.medium16,
                    ),
                    Text(
                      "Delete",
                      style: AppFontStyle.medium16
                          .copyWith(color: AppColor.coral100),
                    ),
                  ]),
                ));
      },
      icon: Icon(Icons.more_vert),
    );
  }
}

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
        itemCount: 2);
  }
}

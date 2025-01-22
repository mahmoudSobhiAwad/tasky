import 'package:flutter/material.dart';
import 'package:popover/popover.dart';
import 'package:tasky/core/utils/theme/app_colors.dart';
import 'package:tasky/core/utils/theme/app_fonts.dart';
import 'package:tasky/core/widgets/pop_body_builder.dart';

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

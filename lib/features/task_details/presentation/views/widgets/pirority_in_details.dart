import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasky/core/utils/theme/app_colors.dart';
import 'package:tasky/core/utils/theme/app_fonts.dart';
import 'package:tasky/features/create_edit_task/data/models/priority_model.dart';

class PirorityInTaskDetails extends StatelessWidget {
  const PirorityInTaskDetails({
    super.key,
    this.pickedPriority,
    this.onSelect,
  });
  final PriorityModel? pickedPriority;
  final void Function(int)? onSelect;
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 3,
      children: [
        Icon(
          CupertinoIcons.flag,
          color: pickedPriority?.color,
        ),
        Text(
          "${pickedPriority?.title ?? "Choose"} Priority",
          style: AppFontStyle.bold16.copyWith(color: AppColor.primary100),
        ),
        Spacer(),
        PopupMenuButton(
            color: AppColor.lavender100,
            offset: Offset(0, 30),
            child: Icon(
              size: 20,
              CupertinoIcons.arrowtriangle_down_fill,
              color: AppColor.primary100,
            ),
            itemBuilder: (context) {
              return [
                ...List.generate(pirorityList.length, (index) {
                  return PopupMenuItem(
                      onTap: () {
                        onSelect != null ? onSelect!(index) : null;
                      },
                      child: Text(
                        pirorityList[index]?.title??"",
                        style: AppFontStyle.bold14
                            .copyWith(color: pirorityList[index]?.color),
                      ));
                })
              ];
            }),
      ],
    );
  }
}

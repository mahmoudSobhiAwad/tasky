import 'package:flutter/material.dart';
import 'package:popover/popover.dart';
import 'package:tasky/core/utils/extensions/navigation_handler.dart';
import 'package:tasky/core/utils/theme/app_colors.dart';
import 'package:tasky/core/utils/theme/app_fonts.dart';
import 'package:tasky/core/widgets/pop_body_builder.dart';

class TrailingOfTaskItem extends StatelessWidget {
  const TrailingOfTaskItem({
    super.key,
    required this.editButton,
    required this.deleteTask,
  });
  final void Function() editButton;
  final void Function() deleteTask;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showPopover(
            direction: PopoverDirection.bottom,
            arrowHeight: 10,
            arrowWidth: 20,
            constraints: const BoxConstraints(
              maxHeight: 120,
              maxWidth: 100,
            ),
            context: context,
            bodyBuilder: (context) => Center(
                  child: PopBodyBuilder(item: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: TextButton(
                        onPressed: () {
                          context.pop();
                          editButton();
                        },
                        child:const Text(
                          maxLines: 1,
                          "Edit",
                          style: AppFontStyle.medium16,
                        ),
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: TextButton(
                        onPressed: () {
                          context.pop();
                          deleteTask();
                        },
                        child:Text(
                          maxLines: 1,
                          "Delete",
                          style: AppFontStyle.medium16
                              .copyWith(color: AppColor.coral100),
                        ),
                      ),
                    ),
                  ]),
                ));
      },
      icon:const Icon(Icons.more_vert),
    );
  }
}

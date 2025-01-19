import 'package:flutter/material.dart';
import 'package:tasky/core/utils/extensions/navigation_handler.dart';
import 'package:tasky/core/utils/theme/app_colors.dart';
import 'package:tasky/features/create_edit_task/presentation/view/create_task_view.dart';

class CustomFloatingButtons extends StatelessWidget {
  const CustomFloatingButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          heroTag: 'fab1',
          onPressed: null,
          shape: CircleBorder(),
          backgroundColor: AppColor.purplePale100,
          child: Icon(
            size: 24,
            Icons.qr_code_2_rounded,
            color: AppColor.primary100,
          ),
        ),
        FloatingActionButton(
          onPressed: () {
            context.push(CreateTaskView());
          },
          heroTag: 'fab2',
          shape: CircleBorder(),
          backgroundColor: AppColor.primary100,
          child: IconButton(
              onPressed: null,
              icon: Icon(
                size: 32,
                Icons.add,
                color: AppColor.white100,
              )),
        ),
      ],
    );
  }
}

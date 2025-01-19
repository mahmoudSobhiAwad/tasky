import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasky/core/utils/theme/app_images.dart';
import 'package:tasky/core/utils/widgets/common_app_bar.dart';
import 'package:tasky/core/utils/widgets/custom_container_decoration.dart';
import 'package:tasky/core/utils/widgets/custom_push_button.dart';
import 'package:tasky/core/utils/widgets/custom_text_field.dart';
import 'package:tasky/features/create_edit_task/presentation/view/widgets/dashed_add_image.dart';
import 'package:tasky/features/task_details/presentation/views/widgets/pirority_in_details.dart';

class CreateTaskView extends StatelessWidget {
  const CreateTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          spacing: 24,
          children: [
            CustomCommonAppBar(title: 'Add new task'),
            Expanded(
                child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                spacing: 16,
                children: [
                  DashedAddImage(),
                  CustomTextFormField(
                    spacing: 8,
                    headerText: 'Task title',
                    label: 'Enter title here...',
                  ),
                  CustomTextFormField(
                    spacing: 8,
                    headerText: 'Task Description',
                    label: 'Enter description here...',
                    maxLine: 5,
                  ),
                  CustomContainerDecoration(child: PirorityInTaskDetails()),
                  CustomTextFormField(
                    spacing: 8,
                    isReadOnly: true,
                    suffixWidget: IconButton(
                        onPressed: null,
                        icon: SvgPicture.asset(AppImages.calendarIcon)),
                    headerText: 'Due date',
                    label: 'choose due date...',
                  ),
                ],
              ),
            )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: CustomPushButton(title: 'Add task'),
            ),
            SizedBox(),
          ],
        ),
      ),
    );
  }
}

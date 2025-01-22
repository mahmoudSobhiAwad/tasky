import 'package:flutter/material.dart';
import 'package:tasky/core/utils/extensions/media_query_handler.dart';
import 'package:tasky/core/utils/theme/app_fonts.dart';
import 'package:tasky/core/widgets/common_app_bar.dart';
import 'package:tasky/core/widgets/custom_container_decoration.dart';
import 'package:tasky/core/widgets/custom_network_img.dart';
import 'package:tasky/features/create_edit_task/data/models/task_model.dart';
import 'package:tasky/features/home/presentation/view/widgets/trailing_task_item.dart';
import 'package:tasky/features/task_details/presentation/views/widgets/pirority_in_details.dart';
import 'package:tasky/features/task_details/presentation/views/widgets/task_date.dart';
import 'package:tasky/features/task_details/presentation/views/widgets/task_state.dart';
import 'package:tasky/features/task_details/presentation/views/widgets/desc_with_show_more.dart';

class TaskDetailsView extends StatelessWidget {
  const TaskDetailsView({super.key, required this.taskModel});
  final TaskModel taskModel;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
          children: [
            CustomCommonAppBar(
              title: 'Task Details',
              trailingWidget: TrailingOfTaskItem(),
            ),
            CustomNetworkImage(
              width: double.infinity,
              height: context.screenHeight * 0.25,
              fit: BoxFit.fitHeight,
            ),
            const Text(
              "Grocery Shopping App",
              style: AppFontStyle.bold24,
            ),
            DescriptionAndShowMore(),
            CustomContainerDecoration(
              child: TaskDateInDateDetails(),
            ),
            CustomContainerDecoration(child: StateInTaskDetails()),
            CustomContainerDecoration(child: PirorityInTaskDetails()),
            Center(
                child: CustomNetworkImage(
              srcUrl:
                  'https://www.siteit.ch/webseite/wp-content/uploads/qr-code.jpg',
              height: 326,
              width: 326,
              fit: BoxFit.cover,
            )),
            SizedBox()
          ],
        ),
      ),
    ));
  }
}

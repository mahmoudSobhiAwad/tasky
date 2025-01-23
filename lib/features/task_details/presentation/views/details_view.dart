import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tasky/core/utils/extensions/media_query_handler.dart';
import 'package:tasky/core/utils/extensions/navigation_handler.dart';
import 'package:tasky/core/utils/theme/app_fonts.dart';
import 'package:tasky/core/widgets/common_app_bar.dart';
import 'package:tasky/core/widgets/custom_container_decoration.dart';
import 'package:tasky/core/widgets/custom_network_img.dart';
import 'package:tasky/features/create_edit_task/data/models/image_model.dart';
import 'package:tasky/features/create_edit_task/data/models/task_model.dart';
import 'package:tasky/features/create_edit_task/presentation/view/create_task_view.dart';
import 'package:tasky/features/home/presentation/view/widgets/trailing_task_item.dart';
import 'package:tasky/features/task_details/presentation/views/widgets/image_preview.dart';
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
              trailingWidget: TrailingOfTaskItem(
                editButton: () {
                  context.pushReplacement(CreateOrEditTaskView(
                    taskModel: taskModel,
                  ));
                },
                deleteTask: () {},
              ),
            ),
            InkWell(
              onTap: (){
                context.push(ImagePreview(imageModel: ImageModel(imagePath: taskModel.image,imageType: ImageType.network)));
              },
              child: CustomNetworkImage(
                srcUrl: taskModel.image,
                width: double.infinity,
                height: context.screenHeight * 0.25,
                fit: BoxFit.fitHeight,
              ),
            ),
            Text(
              taskModel.title ?? "",
              style: AppFontStyle.bold24,
            ),
            DescriptionAndShowMore(
              desc: taskModel.desc,
            ),
            CustomContainerDecoration(
              child: TaskDateInDateDetails(date: taskModel.createdAt,),
            ),
            CustomContainerDecoration(child: StateInTaskDetails(status: taskModel.status,)),
            CustomContainerDecoration(child: PirorityInTaskDetails(pickedPriority: taskModel.priority,)),
            Center(
              child: QrImageView(
                data: taskModel.id ?? "12345",
                version: QrVersions.auto,
                size: 326.0,
              ),
            ),
            SizedBox()
          ],
        ),
      ),
    ));
  }
}

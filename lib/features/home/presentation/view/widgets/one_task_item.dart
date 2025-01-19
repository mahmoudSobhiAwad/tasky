import 'package:flutter/material.dart';
import 'package:tasky/core/utils/widgets/custom_network_img.dart';
import 'package:tasky/features/home/presentation/view/widgets/subtitle_task_item.dart';
import 'package:tasky/features/home/presentation/view/widgets/title_task_item.dart';
import 'package:tasky/features/home/presentation/view/widgets/trailing_task_item.dart';

class OneTaskItem extends StatelessWidget {
  const OneTaskItem({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 5,
      minLeadingWidth: 60,
      contentPadding: const EdgeInsets.all(0),
      leading: CustomNetworkImage(),
      title: TitleOfTaskItem(),
      subtitle: SubTitleOfTaskItem(),
      trailing: TrailingOfTaskItem(),
    );
  }
}



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/utils/extensions/navigation_handler.dart';
import 'package:tasky/core/widgets/custom_delete_task_alert.dart';
import 'package:tasky/core/widgets/custom_network_img.dart';
import 'package:tasky/features/create_edit_task/data/models/task_model.dart';
import 'package:tasky/features/create_edit_task/presentation/view/widgets/edit_task_view.dart';
import 'package:tasky/features/home/presentation/manager/cubit/home_cubit.dart';
import 'package:tasky/features/home/presentation/view/widgets/subtitle_task_item.dart';
import 'package:tasky/features/home/presentation/view/widgets/title_task_item.dart';
import 'package:tasky/features/home/presentation/view/widgets/trailing_task_item.dart';
import 'package:tasky/features/task_details/presentation/manager/cubit/task_details_cubit.dart';

class OneTaskItem extends StatelessWidget {
  const OneTaskItem(
      {super.key,
      required this.taskModel,
      required this.cubit,
      required this.refresh});
  final TaskModel taskModel;
  final HomeCubit cubit;
  final void Function(TaskModel) refresh;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 5,
      minLeadingWidth: 60,
      contentPadding: const EdgeInsets.all(0),
      leading: ClipOval(
          child: CustomNetworkImage(
        srcUrl: taskModel.imageModel?.imagePath,
        width: 50,
        height: 50,
      )),
      title: TitleOfTaskItem(
        taksTitle: taskModel.title,
        taskStaus: taskModel.status,
      ),
      subtitle: SubTitleOfTaskItem(
        subTitle: taskModel.desc,
        model: taskModel.priority,
        date: taskModel.createdAt,
      ),
      trailing: TrailingOfTaskItem(
        editButton: () async {
          await context
              .push(EditTaskView(
            taskModel: taskModel,
          ))
              .then((value) {
            if (value != null) {
              refresh(value);
            }
          });
        },
        deleteTask: () {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => BlocBuilder<HomeCubit, HomeState>(
                    bloc: cubit,
                    builder: (context, state) {
                      return CustomDeleteTaskAlert(
                        isLoading: state is LoadingDeleteTask,
                        deleteTask: () async {
                          await cubit.deleteTask(taskModel.id);
                          if (context.mounted) {
                            context.pop();
                          }
                        },
                      );
                    },
                  ));
        },
      ),
    );
  }
}

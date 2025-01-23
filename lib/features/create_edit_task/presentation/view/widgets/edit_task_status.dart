import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/utils/theme/app_colors.dart';
import 'package:tasky/core/utils/theme/app_fonts.dart';
import 'package:tasky/features/create_edit_task/data/models/status_model.dart';
import 'package:tasky/features/create_edit_task/presentation/manager/cubit/create_edit_task_cubit.dart';

class EditTaskStatus extends StatelessWidget {
  const EditTaskStatus({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateEditTaskCubit, CreateEditTaskState>(
      buildWhen: (curr, prev) {
        return prev is ChangeDueDateState;
      },
      builder: (context, state) {
        var cubit = context.read<CreateEditTaskCubit>();
        return Wrap(
          runSpacing: 10,
          spacing: 15,
          children: [
            ...List.generate(statusList.length, (index) {
              return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            8), // Set the border radius here
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 7,
                      )),
                  onPressed: () {},
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        statusList[index]?.title ?? "",
                        style: AppFontStyle.bold14,
                      ),
                      Checkbox(
                        value: cubit.status == statusList[index],
                        onChanged: (v) {
                          cubit.changeStatus(index);
                        },
                        activeColor: AppColor.green,
                      )
                    ],
                  ));
            })
          ],
        );
      },
    );
  }
}

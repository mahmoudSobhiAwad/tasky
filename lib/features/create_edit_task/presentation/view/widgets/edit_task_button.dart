import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/utils/theme/app_colors.dart';
import 'package:tasky/core/widgets/custom_push_button.dart';
import 'package:tasky/core/widgets/custom_snack_bar.dart';
import 'package:tasky/features/create_edit_task/data/models/image_model.dart';
import 'package:tasky/features/create_edit_task/presentation/manager/cubit/create_edit_task_cubit.dart';
import 'package:tasky/features/create_edit_task/presentation/view/widgets/edit_task_view.dart';

class EditTakButton extends StatelessWidget {
  const EditTakButton({
    super.key,
    required this.imageModel,
    required GlobalKey<FormState> formKey,
    required this.widget,
    required this.titleEditingController,
    required this.descEditingController,
  }) : _formKey = formKey;

  final ImageModel imageModel;
  final GlobalKey<FormState> _formKey;
  final EditTaskView widget;
  final TextEditingController titleEditingController;
  final TextEditingController descEditingController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateEditTaskCubit, CreateEditTaskState>(
      buildWhen: (curr, prev) {
        return curr is UploadTaskState||prev is UploadTaskState;
      },
      builder: (context, state) {
        var cubit = context.read<CreateEditTaskCubit>();
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: CustomPushButton(
            isLoading: state is LoadingUploadTaskState,
            title: 'Edit',
            onTap: () {
              if (imageModel.imagePath == null || cubit.priority == null) {
                showCustomSnackBar(context, 'Image or Priority can\'t be empty',
                    backgroundColor: AppColor.red100);
              } else if (_formKey.currentState!.validate()) {
                cubit.uploadEditedTask(widget.taskModel.copyWith(
                    title: titleEditingController.text,
                    imageModel: imageModel,
                    status: cubit.status,
                    priority: cubit.priority,
                    desc: descEditingController.text));
              }
            },
          ),
        );
      },
    );
  }
}

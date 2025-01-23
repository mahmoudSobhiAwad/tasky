import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/utils/theme/app_colors.dart';
import 'package:tasky/core/widgets/custom_push_button.dart';
import 'package:tasky/core/widgets/custom_snack_bar.dart';
import 'package:tasky/features/create_edit_task/data/models/create_edit_task_model.dart';
import 'package:tasky/features/create_edit_task/data/models/image_model.dart';
import 'package:tasky/features/create_edit_task/presentation/manager/cubit/create_edit_task_cubit.dart';

class CreateTaskButton extends StatelessWidget {
  const CreateTaskButton({
    super.key,
    required this.imageModel,
    required this.priority,
    required GlobalKey<FormState> formKey,
    required this.descEditingController,
    required this.titleEditingController,
    required this.taskDate,
    required this.isEdit,
  }) : _formKey = formKey;

  final ImageModel imageModel;
  final String? priority;
  final GlobalKey<FormState> _formKey;
  final TextEditingController descEditingController;
  final TextEditingController titleEditingController;
  final String? taskDate;
  final bool isEdit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: BlocBuilder<CreateEditTaskCubit, CreateEditTaskState>(
        buildWhen: (prev, curr) {
          return curr is UploadTaskState;
        },
        builder: (context, state) {
          var cubit = context.read<CreateEditTaskCubit>();
          return CustomPushButton(
              isLoading: state is LoadingAddTaskState,
              onTap: () {
                if (imageModel.imagePath == null || priority == null) {
                  showCustomSnackBar(
                      context, 'Image or Priority can\'t be empty',
                      backgroundColor: AppColor.red100);
                } else if (_formKey.currentState!.validate()) {
                  cubit.uploadTask(CreateEditTaskModel(
                      imagePath: imageModel.imagePath,
                      desc: descEditingController.text,
                      title: titleEditingController.text,
                      dueDate: taskDate!,
                      priority: priority ?? "low"));
                }
              },
              title: isEdit ? 'Edit Task' : 'Add task');
        },
      ),
    );
  }
}

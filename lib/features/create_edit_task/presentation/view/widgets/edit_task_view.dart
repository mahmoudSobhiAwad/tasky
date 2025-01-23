import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/utils/extensions/navigation_handler.dart';
import 'package:tasky/core/utils/functions/service_locator.dart';
import 'package:tasky/core/utils/theme/app_colors.dart';
import 'package:tasky/core/widgets/custom_snack_bar.dart';
import 'package:tasky/features/create_edit_task/data/models/image_model.dart';
import 'package:tasky/features/create_edit_task/data/models/task_model.dart';
import 'package:tasky/features/create_edit_task/data/repos/add_edit_task_repo_impl.dart';
import 'package:tasky/features/create_edit_task/presentation/manager/cubit/create_edit_task_cubit.dart';
import 'package:tasky/features/create_edit_task/presentation/view/widgets/edit_task_body.dart';

class EditTaskView extends StatefulWidget {
  const EditTaskView({super.key, required this.taskModel});
  final TaskModel taskModel;
  @override
  State<EditTaskView> createState() => _EditTaskViewState();
}

class _EditTaskViewState extends State<EditTaskView> {
  late ImageModel imageModel;
  late final TextEditingController titleEditingController;
  late final TextEditingController descEditingController;
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    imageModel = widget.taskModel.imageModel?.copyWith() ?? ImageModel();
    titleEditingController =
        TextEditingController(text: widget.taskModel.title);
    descEditingController = TextEditingController(text: widget.taskModel.desc);
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    titleEditingController.dispose();
    descEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateEditTaskCubit(
          priority: widget.taskModel.priority,
          status: widget.taskModel.status,
          addEditTaskRepoImpl: getIt.get<AddEditTaskRepoImpl>()),
      child: SafeArea(
        child: BlocListener<CreateEditTaskCubit, CreateEditTaskState>(
          listenWhen: (curr, prev) {
            return curr is UploadTaskState;
          },
          listener: (context, state) {
            if (state is FailureUploadTaskState) {
              showCustomSnackBar(context, state.errMessage ?? "",
                  backgroundColor: AppColor.red100);
            } else if (state is FailureUploadImageState) {
              showCustomSnackBar(context, state.errMessage ?? "",
                  backgroundColor: AppColor.red100);
            } else if (state is SuccessUploadTaskState) {
              showCustomSnackBar(context, "Success Add Task",
                  backgroundColor: AppColor.green);
              context.pop(state.taskModel);
            }
          },
          child: EditTaskBody(
              formKey: _formKey,
              imageModel: imageModel,
              titleEditingController: titleEditingController,
              descEditingController: descEditingController,
              widget: widget),
        ),
      ),
    );
  }
}

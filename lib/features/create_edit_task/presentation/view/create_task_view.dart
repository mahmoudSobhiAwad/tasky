import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/utils/extensions/navigation_handler.dart';
import 'package:tasky/core/utils/functions/service_locator.dart';
import 'package:tasky/core/utils/theme/app_colors.dart';
import 'package:tasky/core/widgets/common_app_bar.dart';
import 'package:tasky/core/widgets/custom_container_decoration.dart';
import 'package:tasky/core/widgets/custom_snack_bar.dart';
import 'package:tasky/core/widgets/custom_text_field.dart';
import 'package:tasky/features/create_edit_task/data/models/image_model.dart';
import 'package:tasky/features/create_edit_task/data/models/priority_model.dart';
import 'package:tasky/features/create_edit_task/data/repos/add_edit_task_repo_impl.dart';
import 'package:tasky/features/create_edit_task/presentation/manager/cubit/create_edit_task_cubit.dart';
import 'package:tasky/features/create_edit_task/presentation/view/widgets/create_task_button.dart';
import 'package:tasky/features/create_edit_task/presentation/view/widgets/custom_image_with_change_delete.dart';
import 'package:tasky/features/create_edit_task/presentation/view/widgets/task_due_date.dart';
import 'package:tasky/features/task_details/presentation/views/widgets/pirority_in_details.dart';

class CreateTaskView extends StatefulWidget {
  const CreateTaskView({
    super.key,
  });
  @override
  State<CreateTaskView> createState() => _CreateTaskViewState();
}

class _CreateTaskViewState extends State<CreateTaskView> {
  late ImageModel imageModel;
  late final TextEditingController titleEditingController;
  late final TextEditingController descEditingController;
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    titleEditingController = TextEditingController();
    descEditingController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    imageModel = ImageModel();
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
          addEditTaskRepoImpl: getIt.get<AddEditTaskRepoImpl>()),
      child: SafeArea(
        child: BlocListener<CreateEditTaskCubit, CreateEditTaskState>(
          listenWhen: (prev, curr) {
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
          child: Scaffold(
            body: Form(
              key: _formKey,
              child: Column(
                spacing: 24,
                children: [
                  CustomCommonAppBar(
                    title: 'Add New Task',
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      spacing: 16,
                      children: [
                        CustomDashedImageWithChangeAndDelete(
                            imageModel: imageModel),
                        CustomTextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Title Can\'t be Empty ';
                            }
                            return null;
                          },
                          maxLine: 1,
                          controller: titleEditingController,
                          spacing: 8,
                          headerText: 'Task title',
                          label: 'Enter title here...',
                        ),
                        CustomTextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Description Can\'t be Empty ';
                            }
                            return null;
                          },
                          controller: descEditingController,
                          spacing: 8,
                          headerText: 'Task Description',
                          label: 'Enter description here...',
                          maxLine: 5,
                        ),
                        BlocBuilder<CreateEditTaskCubit, CreateEditTaskState>(
                          buildWhen: (prev, curr) {
                            return curr is ChangePirorityState;
                          },
                          builder: (context, state) {
                            var cubit = context.read<CreateEditTaskCubit>();

                            return CustomContainerDecoration(
                                child: PirorityInTaskDetails(
                              pickedPriority: pirorityList.firstWhere(
                                  (item) => item == cubit.priority,
                                  orElse: () => null),
                              onSelect: (index) {
                                cubit.changePirority(index);
                              },
                            ));
                          },
                        ),
                        BlocBuilder<CreateEditTaskCubit, CreateEditTaskState>(
                          buildWhen: (prev, curr) {
                            return curr is ChangeDueDateState;
                          },
                          builder: (context, state) {
                            var cubit = context.read<CreateEditTaskCubit>();

                            return CustomTaskDueDatePicker(
                              date: cubit.dateTime,
                              changeDate: (value) {
                                cubit.changePickedDate(value);
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  )),
                  CreateTaskButton(
                    imageModel: imageModel,
                    formKey: _formKey,
                    descEditingController: descEditingController,
                    titleEditingController: titleEditingController,
                  ),
                  SizedBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

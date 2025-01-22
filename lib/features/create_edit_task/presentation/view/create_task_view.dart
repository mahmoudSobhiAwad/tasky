import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/utils/extensions/navigation_handler.dart';
import 'package:tasky/core/utils/functions/service_locator.dart';
import 'package:tasky/core/utils/theme/app_colors.dart';
import 'package:tasky/core/widgets/common_app_bar.dart';
import 'package:tasky/core/widgets/custom_container_decoration.dart';
import 'package:tasky/core/widgets/custom_push_button.dart';
import 'package:tasky/core/widgets/custom_snack_bar.dart';
import 'package:tasky/core/widgets/custom_text_field.dart';
import 'package:tasky/features/create_edit_task/data/models/create_edit_task_model.dart';
import 'package:tasky/features/create_edit_task/data/models/image_model.dart';
import 'package:tasky/features/create_edit_task/data/models/priority_model.dart';
import 'package:tasky/features/create_edit_task/data/repos/add_edit_task_repo_impl.dart';
import 'package:tasky/features/create_edit_task/presentation/manager/cubit/create_edit_task_cubit.dart';
import 'package:tasky/features/create_edit_task/presentation/view/widgets/custom_image_with_change_delete.dart';
import 'package:tasky/features/create_edit_task/presentation/view/widgets/task_due_date.dart';
import 'package:tasky/features/task_details/presentation/views/widgets/pirority_in_details.dart';

class CreateTaskView extends StatefulWidget {
  const CreateTaskView({super.key});

  @override
  State<CreateTaskView> createState() => _CreateTaskViewState();
}

class _CreateTaskViewState extends State<CreateTaskView> {
  late ImageModel imageModel;
  late final TextEditingController titleEditingController;
  late final TextEditingController descEditingController;
  int? priorityIndex;
  String? taskDate;
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
          listenWhen: (curr, prev) {
            return curr is UploadTaskState;
          },
          listener: (context, state) {
            if (state is FailureAddTaskState) {
              showCustomSnackBar(context, state.errMessage ?? "",
                  backgroundColor: AppColor.red100);
            } else if (state is FailureUploadImageState) {
              showCustomSnackBar(context, state.errMessage ?? "",
                  backgroundColor: AppColor.red100);
            } else if (state is SuccessAddTaskState) {
              showCustomSnackBar(context, "Success Add Task",
                  backgroundColor: AppColor.red100);
              context.pop();
            }
          },
          child: Scaffold(
            body: Form(
              key: _formKey,
              child: Column(
                spacing: 24,
                children: [
                  CustomCommonAppBar(title: 'Add new task'),
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
                            if (state is ChangePirorityState) {
                              priorityIndex = state.value;
                            }
                            return CustomContainerDecoration(
                                child: PirorityInTaskDetails(
                              pickedPriority: priorityIndex != null
                                  ? pirorityList[priorityIndex!]
                                  : null,
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
                            if (state is ChangeDueDateState) {
                              taskDate = state.date;
                            }
                            return CustomTaskDueDatePicker(
                              date: taskDate,
                              changeDate: (value) {
                                cubit.changePickedDate(value);
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child:
                        BlocBuilder<CreateEditTaskCubit, CreateEditTaskState>(
                      buildWhen: (prev, curr) {
                        return curr is UploadTaskState;
                      },
                      builder: (context, state) {
                        var cubit = context.read<CreateEditTaskCubit>();
                        return CustomPushButton(
                            isLoading: state is LoadingAddTaskState,
                            onTap: () {
                              if (imageModel.imagePath == null ||
                                  priorityIndex == null) {
                                showCustomSnackBar(context,
                                    'Image or Priority can\'t be empty',
                                    backgroundColor: AppColor.red100);
                              } else if (_formKey.currentState!.validate()) {
                                cubit.uploadTask(CreateEditTaskModel(
                                    imagePath: imageModel.imagePath,
                                    desc: descEditingController.text,
                                    title: titleEditingController.text,
                                    dueDate: taskDate!,
                                    priority: pirorityList[priorityIndex ?? 0]
                                        .title));
                              }
                            },
                            title: 'Add task');
                      },
                    ),
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

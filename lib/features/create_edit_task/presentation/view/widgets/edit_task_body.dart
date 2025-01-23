import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/widgets/common_app_bar.dart';
import 'package:tasky/core/widgets/custom_container_decoration.dart';
import 'package:tasky/core/widgets/custom_text_field.dart';
import 'package:tasky/features/create_edit_task/data/models/image_model.dart';
import 'package:tasky/features/create_edit_task/data/models/priority_model.dart';
import 'package:tasky/features/create_edit_task/presentation/manager/cubit/create_edit_task_cubit.dart';
import 'package:tasky/features/create_edit_task/presentation/view/widgets/custom_image_with_change_delete.dart';
import 'package:tasky/features/create_edit_task/presentation/view/widgets/edit_task_button.dart';
import 'package:tasky/features/create_edit_task/presentation/view/widgets/edit_task_status.dart';
import 'package:tasky/features/create_edit_task/presentation/view/widgets/edit_task_view.dart';
import 'package:tasky/features/task_details/presentation/views/widgets/pirority_in_details.dart';

class EditTaskBody extends StatelessWidget {
  const EditTaskBody({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.imageModel,
    required this.titleEditingController,
    required this.descEditingController,
    required this.widget,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final ImageModel imageModel;
  final TextEditingController titleEditingController;
  final TextEditingController descEditingController;
  final EditTaskView widget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          spacing: 24,
          children: [
            CustomCommonAppBar(
              title: 'Edit Task',
            ),
            Expanded(
                child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 16,
                children: [
                  CustomDashedImageWithChangeAndDelete(imageModel: imageModel),
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
                  EditTaskStatus(),
                  SizedBox(),
                ],
              ),
            )),
            EditTakButton(
                imageModel: imageModel,
                formKey: _formKey,
                widget: widget,
                titleEditingController: titleEditingController,
                descEditingController: descEditingController),
            SizedBox(),
          ],
        ),
      ),
    );
  }
}

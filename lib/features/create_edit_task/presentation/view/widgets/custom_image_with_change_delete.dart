import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/utils/theme/app_colors.dart';
import 'package:tasky/core/utils/theme/app_fonts.dart';
import 'package:tasky/features/create_edit_task/data/models/image_model.dart';
import 'package:tasky/features/create_edit_task/presentation/manager/cubit/create_edit_task_cubit.dart';
import 'package:tasky/features/create_edit_task/presentation/view/widgets/change_delete_picked_image.dart';
import 'package:tasky/features/create_edit_task/presentation/view/widgets/custom_image_source_picker.dart';
import 'package:tasky/features/create_edit_task/presentation/view/widgets/dashed_add_image.dart';

class CustomDashedImageWithChangeAndDelete extends StatelessWidget {
  const CustomDashedImageWithChangeAndDelete(
      {super.key, required this.imageModel});
  final ImageModel imageModel;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateEditTaskCubit, CreateEditTaskState>(
      buildWhen: (prev, curr) {
        return curr is ChangeCurrPictureState;
      },
      builder: (context, state) {
        if (state is ChangeCurrPictureState) {
          imageModel.imagePath = state.imageModel.imagePath;
          imageModel.imageType = state.imageModel.imageType;
        }
        var cubit = context.read<CreateEditTaskCubit>();
        return Column(
          children: [
            DashedAddImage(
              imageModel: imageModel,
              onTap: () async {
                await showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return CustomPickImageSource();
                    }).then((value) {
                  if (value != null) {
                    cubit.pickImage(value);
                  }
                });
              },
            ),
            imageModel.imagePath != null
                ? ChangeOrDeletePickedImage(
                    changePicked: (source) async {
                      cubit.pickImage(source);
                    },
                    deleteImage: () {
                      cubit.deleteImage();
                    },
                  )
                : Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      "Image is Required To Send !!",
                      style:
                          AppFontStyle.bold14.copyWith(color: AppColor.red100),
                    )),
          ],
        );
      },
    );
  }
}

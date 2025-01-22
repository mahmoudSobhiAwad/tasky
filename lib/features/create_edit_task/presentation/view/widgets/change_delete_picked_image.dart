import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasky/core/utils/theme/app_colors.dart';
import 'package:tasky/core/utils/theme/app_fonts.dart';
import 'package:tasky/features/create_edit_task/presentation/view/widgets/custom_image_source_picker.dart';

class ChangeOrDeletePickedImage extends StatelessWidget {
  const ChangeOrDeletePickedImage({
    super.key,
    required this.changePicked,
    required this.deleteImage,
  });
  final void Function(ImageSource) changePicked;
  final void Function() deleteImage;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
            onPressed: () async {
              await showModalBottomSheet<ImageSource?>(
                  context: context,
                  builder: (context) {
                    return CustomPickImageSource();
                  }).then((value) {
                if (value != null) {
                  changePicked(value);
                }
              });
            },
            child: Text(
              "Change",
              style: AppFontStyle.bold16.copyWith(color: AppColor.primary100),
            )),
        SizedBox(
          height: 10,
          child: VerticalDivider(
            width: 2,
          ),
        ),
        TextButton(
            onPressed: deleteImage,
            child: Text(
              "Delete",
              style: AppFontStyle.bold16.copyWith(color: AppColor.red100),
            )),
      ],
    );
  }
}

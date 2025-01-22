import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';
import 'package:tasky/core/utils/extensions/media_query_handler.dart';
import 'package:tasky/core/utils/theme/app_colors.dart';
import 'package:tasky/core/utils/theme/app_fonts.dart';
import 'package:tasky/core/utils/theme/app_images.dart';
import 'package:tasky/core/widgets/custom_network_img.dart';
import 'package:tasky/features/create_edit_task/data/models/image_model.dart';

class DashedAddImage extends StatelessWidget {
  const DashedAddImage({
    super.key,
    this.onTap,
    required this.imageModel,
  });
  final void Function()? onTap;
  final ImageModel imageModel;
  @override
  Widget build(BuildContext context) {
    return switch (imageModel.imageType) {
      ImageType.file => Image.file(
          fit: BoxFit.cover,
          width: double.infinity,
          height: context.screenHeight * 0.25,
          File(imageModel.imagePath ?? "")),
      ImageType.network => CustomNetworkImage(
          srcUrl: imageModel.imagePath ?? "",
          fit: BoxFit.fitWidth,
          width: double.infinity,
          height: context.screenHeight * 0.25,
        ),
      ImageType.empty => Container(
          padding: EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            border: DashedBorder.fromBorderSide(
                dashLength: 2,
                side: BorderSide(color: AppColor.primary100, width: 1)),
          ),
          child: InkWell(
            onTap: onTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(AppImages.addImageIcon),
                Text(
                  "Add Img",
                  style: AppFontStyle.medium19
                      .copyWith(color: AppColor.primary100),
                )
              ],
            ),
          ),
        ),
    };
  }
}

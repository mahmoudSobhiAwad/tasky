import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasky/core/utils/extensions/navigation_handler.dart';
import 'package:tasky/core/utils/theme/app_colors.dart';
import 'package:tasky/core/utils/theme/app_fonts.dart';
import 'package:tasky/core/widgets/custom_container_decoration.dart';

class CustomPickImageSource extends StatelessWidget {
  const CustomPickImageSource({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainerDecoration(
      backGroundColor: AppColor.lightGray100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: Icon(
              Icons.close,
              color: AppColor.red100,
            ),
          ),
          Text(
            "Pick Image Sources",
            style: AppFontStyle.bold16.copyWith(color: AppColor.primary100),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            spacing: 50,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  context.pop(ImageSource.camera);
                },
                child: Column(
                  spacing: 10,
                  children: [
                    Text(
                      "Camera",
                      style: AppFontStyle.bold16,
                    ),
                    Icon(
                      Icons.camera_alt_rounded,
                      size: 50,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 25,
                child: VerticalDivider(
                  width: 3,
                ),
              ),
              InkWell(
                onTap: () => context.pop(ImageSource.gallery),
                child: Column(
                  spacing: 10,
                  children: [
                    Text(
                      "Gallery",
                      style: AppFontStyle.bold16,
                    ),
                    Icon(
                      Icons.image,
                      size: 50,
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

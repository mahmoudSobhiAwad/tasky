import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tasky/core/utils/theme/app_colors.dart';
import 'package:tasky/core/widgets/common_app_bar.dart';
import 'package:tasky/core/widgets/custom_network_img.dart';
import 'package:tasky/features/create_edit_task/data/models/image_model.dart';

class ImagePreview extends StatelessWidget {
  const ImagePreview({super.key, required this.imageModel});
  final ImageModel imageModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          spacing: 20,
          children: [
            CustomCommonAppBar(title: 'Image Preview'),
            Expanded(
              child: InteractiveViewer(
                child: switch (imageModel.imageType) {
                  ImageType.file =>Image.file(
                      File(imageModel.imagePath ?? ""),
                      errorBuilder: (context, _, s) {
                        return Icon(
                          Icons.error,
                          color: AppColor.red100,
                          size: 100,
                        );
                      },
                    ),
                  ImageType.network =>
                    CustomNetworkImage(srcUrl: imageModel.imagePath),
                  ImageType.empty => SizedBox()
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

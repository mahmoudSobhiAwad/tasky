import 'package:flutter/material.dart';
import 'package:tasky/core/utils/theme/app_colors.dart';

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({
    super.key,
    this.fit,
    this.srcUrl,
    this.width,
    this.height,
  });
  final BoxFit? fit;
  final String? srcUrl;
  final double? width;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return Image.network(
      srcUrl ?? "",
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) => Icon(
        size: 40,
        Icons.error,
        color: AppColor.red100,
      ),
    );
  }
}

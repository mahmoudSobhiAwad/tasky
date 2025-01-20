import 'package:flutter/widgets.dart';
import 'package:tasky/core/utils/theme/app_images.dart';

class CustomBoardinImage extends StatelessWidget {
  const CustomBoardinImage({
    super.key,
    this.isSignUp = false,
    this.height,
  });
  final bool isSignUp;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      height: height,
      filterQuality: FilterQuality.medium,
      isSignUp ? AppImages.onBoardingSignUp : AppImages.onBoardingImage,
      fit: BoxFit.cover,
      width: double.infinity,
    );
  }
}

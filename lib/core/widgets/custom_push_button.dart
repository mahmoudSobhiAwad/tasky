import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasky/core/utils/theme/app_colors.dart';
import 'package:tasky/core/utils/theme/app_fonts.dart';
import 'package:tasky/core/utils/theme/app_images.dart';

class CustomPushButton extends StatelessWidget {
  const CustomPushButton({
    super.key,
    required this.title,
    this.enableArrow = false,
    this.onTap,
    this.textStyle,
    this.isLoading = false,
    this.backgroundColor,
  });
  final bool isLoading;
  final String title;
  final bool enableArrow;
  final void Function()? onTap;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? null : onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
            color: backgroundColor ?? AppColor.primary100,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Center(
          child: Row(
            spacing: 8,
            mainAxisSize: MainAxisSize.min,
            children: [
              isLoading
                  ? CircularProgressIndicator(
                      color: AppColor.white100,
                    )
                  : Text(
                      title,
                      style: textStyle ??
                          AppFontStyle.bold19
                              .copyWith(color: AppColor.white100),
                    ),
              if (enableArrow) SvgPicture.asset(AppImages.arrowRight),
            ],
          ),
        ),
      ),
    );
  }
}

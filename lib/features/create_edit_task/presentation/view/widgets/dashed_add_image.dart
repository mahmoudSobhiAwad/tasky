import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';
import 'package:tasky/core/utils/theme/app_colors.dart';
import 'package:tasky/core/utils/theme/app_fonts.dart';
import 'package:tasky/core/utils/theme/app_images.dart';

class DashedAddImage extends StatelessWidget {
  const DashedAddImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        border: DashedBorder.fromBorderSide(
            dashLength: 2,
            side: BorderSide(color: AppColor.primary100, width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(AppImages.addImageIcon),
          Text(
            "Add Img",
            style: AppFontStyle.medium19.copyWith(color: AppColor.primary100),
          )
        ],
      ),
    );
  }
}

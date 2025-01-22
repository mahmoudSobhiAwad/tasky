import 'package:flutter/material.dart';
import 'package:tasky/core/utils/theme/app_colors.dart';
import 'package:tasky/core/utils/theme/app_fonts.dart';
import 'package:tasky/features/home/presentation/view/widgets/subtitle_task_item.dart';

class DescriptionAndShowMore extends StatefulWidget {
  const DescriptionAndShowMore({
    super.key,
  });

  @override
  State<DescriptionAndShowMore> createState() => _DescriptionAndShowMoreState();
}

class _DescriptionAndShowMoreState extends State<DescriptionAndShowMore> {
  int? maxLine = testBig.length > 200 ? 2 : null;

  void changeMaxLine() {
    maxLine = maxLine == null ? 2 : null;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Text(
          maxLines: maxLine,
          testBig,
          style: AppFontStyle.regular14.copyWith(color: AppColor.gray13),
        ),
        testBig.length > 200
            ? InkWell(
                onTap: changeMaxLine,
                child: Text(maxLine == null ? 'see less' : 'see more',
                    style: AppFontStyle.regular14.copyWith(
                      decoration: TextDecoration.underline,
                    )))
            : SizedBox(),
      ],
    );
  }
}

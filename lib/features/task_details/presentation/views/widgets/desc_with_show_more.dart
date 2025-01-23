import 'package:flutter/material.dart';
import 'package:tasky/core/utils/theme/app_colors.dart';
import 'package:tasky/core/utils/theme/app_fonts.dart';

class DescriptionAndShowMore extends StatefulWidget {
  const DescriptionAndShowMore({
    super.key,
    this.desc,
  });
  final String? desc;

  @override
  State<DescriptionAndShowMore> createState() => _DescriptionAndShowMoreState();
}

class _DescriptionAndShowMoreState extends State<DescriptionAndShowMore> {
  int? maxLine;
  @override
  void initState() {
    super.initState();

    maxLine = (widget.desc?.length ?? 0) > 200 ? 2 : null;
  }

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
          widget.desc ?? "",
          style: AppFontStyle.regular14.copyWith(color: AppColor.gray13),
        ),
        (widget.desc?.length ?? 0) > 200
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

import 'package:flutter/material.dart';
import 'package:tasky/core/utils/constants/var_contstant.dart';
import 'package:tasky/core/utils/theme/app_colors.dart';
import 'package:tasky/core/utils/theme/app_fonts.dart';
import 'package:tasky/features/home/presentation/view/widgets/custom_filter_type.dart';
import 'package:tasky/features/home/presentation/view/widgets/home_app_bar.dart';
import 'package:tasky/features/home/presentation/view/widgets/one_task_item.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({
    super.key,
    required ScrollController scrollController,
  }) : _scrollController = scrollController;

  final ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
      child: Column(
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomHomeAppBar(),
          Text('My Tasks',
              style: AppFontStyle.bold16.copyWith(color: AppColor.darkGray60)),
          Wrap(
            spacing: 10,
            children: [
              ...List.generate(filterList.length, (index) {
                return CustomFilterType(
                    isPicked: 0 == index, filterName: filterList[index]);
              }),
            ],
          ),
          Expanded(
            child: ListView.separated(
                controller: _scrollController,
                padding: EdgeInsets.all(0),
                itemBuilder: (context, index) {
                  return OneTaskItem();
                },
                separatorBuilder: (context, index) => SizedBox(
                      height: 5,
                    ),
                itemCount: 7),
          ),
        ],
      ),
    );
  }
}

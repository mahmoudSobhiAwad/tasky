import 'package:flutter/material.dart';
import 'package:tasky/core/utils/constants/var_contstant.dart';
import 'package:tasky/core/utils/extensions/navigation_handler.dart';
import 'package:tasky/core/utils/theme/app_colors.dart';
import 'package:tasky/core/utils/theme/app_fonts.dart';
import 'package:tasky/features/home/presentation/manager/cubit/home_cubit.dart';
import 'package:tasky/features/home/presentation/view/widgets/custom_filter_type.dart';
import 'package:tasky/features/home/presentation/view/widgets/home_app_bar.dart';
import 'package:tasky/features/home/presentation/view/widgets/one_task_item.dart';
import 'package:tasky/features/task_details/presentation/views/details_view.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({
    super.key,
    required this.scrollController,
    required this.cubit,
  });

  final ScrollController scrollController;
  final HomeCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
      child: Column(
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomHomeAppBar(
            cubit: cubit,
          ),
          Text('My Tasks',
              style: AppFontStyle.bold16.copyWith(color: AppColor.darkGray60)),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              ...List.generate(filterList.length, (index) {
                return CustomFilterType(
                    isPicked: 0 == index, filterName: filterList[index]);
              }),
            ],
          ),
          Expanded(
            child: ListView.separated(
                controller: scrollController,
                padding: EdgeInsets.all(0),
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () {
                        context.push(TaskDetailsView());
                      },
                      child: OneTaskItem());
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

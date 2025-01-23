import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tasky/core/utils/constants/var_contstant.dart';
import 'package:tasky/core/utils/extensions/navigation_handler.dart';
import 'package:tasky/core/utils/theme/app_colors.dart';
import 'package:tasky/core/utils/theme/app_fonts.dart';
import 'package:tasky/features/home/presentation/manager/cubit/home_cubit.dart';
import 'package:tasky/features/home/presentation/view/widgets/custom_filter_type.dart';
import 'package:tasky/features/home/presentation/view/widgets/failure_getting_data.dart';
import 'package:tasky/features/home/presentation/view/widgets/home_app_bar.dart';
import 'package:tasky/features/home/presentation/view/widgets/one_task_item.dart';
import 'package:tasky/features/task_details/presentation/views/details_view.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (curr, prev) {
        return (prev != curr && curr is! ChangeFabVisibilityState);
      },
      builder: (context, state) {
        final cubit = context.read<HomeCubit>();
        bool isloading = state is GetAllTasksLoadingState;
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
                  style:
                      AppFontStyle.bold16.copyWith(color: AppColor.darkGray60)),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  ...List.generate(filterList.length, (index) {
                    return InkWell(
                      onTap: () {
                        cubit.changeFilter(index);
                      },
                      child: CustomFilterType(
                          isPicked: index == cubit.filterIndex,
                          filterName: filterList[index]),
                    );
                  }),
                ],
              ),
              Expanded(
                child: Skeletonizer(
                  ignoreContainers: false,
                  enabled: isloading,
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await cubit.getAllTasks();
                    },
                    child: ListView.separated(
                        controller: cubit.scrollController,
                        padding: EdgeInsets.all(0),
                        itemBuilder: (context, index) {
                          if (index == cubit.tasksList.length) {
                            if (state is GetAllTasksFailureState) {
                              return FailureGettingTasks(
                                errMessage: state.errMessage ?? "",
                                refresh: () {
                                  cubit.getAllTasks();
                                },
                              );
                            }
                            return state is FetchMoreLoadingState
                                ? Center(child: CircularProgressIndicator())
                                : Center(
                                    child: Text(
                                      'No More Date Exist',
                                      style: AppFontStyle.bold18,
                                    ),
                                  );
                          }
                          return InkWell(
                              onTap: () {
                                context.push(TaskDetailsView(
                                  taskModel: isloading
                                      ? fakeTaskModel
                                      : cubit.tasksList[index],
                                ));
                              },
                              child: OneTaskItem(
                                cubit: cubit,
                                taskModel: isloading
                                    ? fakeTaskModel
                                    : cubit.tasksList[index],
                                refresh: (model) async {
                                  await cubit.updateTaskWithOther(model);
                                },
                              ));
                        },
                        separatorBuilder: (context, index) => SizedBox(
                              height: 5,
                            ),
                        itemCount: isloading ? 7 : cubit.tasksList.length + 1),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

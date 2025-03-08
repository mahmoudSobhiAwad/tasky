import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tasky/core/utils/constants/var_contstant.dart';
import 'package:tasky/core/utils/extensions/media_query_handler.dart';
import 'package:tasky/core/utils/extensions/navigation_handler.dart';
import 'package:tasky/core/utils/theme/app_colors.dart';
import 'package:tasky/core/utils/theme/app_fonts.dart';
import 'package:tasky/features/create_edit_task/data/models/task_model.dart';
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
      buildWhen: (prev, curr) {
        return (curr is! ChangeFabVisibilityState);
      },
      builder: (context, state) {
        final cubit = context.read<HomeCubit>();
        bool isLoading = state is GetAllTasksLoadingState;
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
                  style: AppFontStyle.bold16
                      .copyWith(color: AppColor.darkGray60)),
              SizedBox(
                height: 40,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          cubit.changeFilter(index);
                        },
                        child: CustomFilterType(
                            isPicked: index == cubit.filterIndex,
                            filterName: filterList[index]),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: 10,
                      );
                    },
                    itemCount: filterList.length),
              ),
              Expanded(
                child: Skeletonizer(
                  ignoreContainers: false,
                  enabled: isLoading,
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await cubit.getAllTasks();
                    },
                    child: ListView.separated(
                        physics: AlwaysScrollableScrollPhysics(),
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
                                : SizedBox();
                          }
                          return InkWell(
                              onTap: () async {
                                await context
                                    .push(TaskDetailsView(
                                  taskModel: isLoading
                                      ? fakeTaskModel
                                      : cubit.tasksList[index],
                                ))
                                    .then((value) {
                                  if (value != null && value is TaskModel) {
                                    cubit.updateTaskWithOther(value);
                                  } else if (value != null && value is String) {
                                    cubit.deleteTaskAfterDeleteFromDetails(
                                        value);
                                  }
                                });
                              },
                              child: OneTaskItem(
                                cubit: cubit,
                                taskModel: isLoading
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
                        itemCount: isLoading ? 7 : cubit.tasksList.length + 1),
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

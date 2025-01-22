import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tasky/core/utils/constants/var_contstant.dart';
import 'package:tasky/core/utils/functions/secure_shared_pref.dart';
import 'package:tasky/features/create_edit_task/data/models/task_model.dart';
import 'package:tasky/features/home/data/repos/home_repo_impl.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepoImp homeRepoImp;
  HomeCubit({required this.homeRepoImp}) : super(HomeInitial());
  int filterIndex = 0;
  List<TaskModel> tasksList = [];
  bool hasMore = false;
  int pageNum = 1;
  final ScrollController scrollController = ScrollController();
  bool isFabVisible = true;

  @override
  Future<void> close() {
    scrollController.dispose();

    return super.close();
  }

  void addListenToScroll() {
    scrollController.addListener(() {
      _controllFabVisibilty();
      _attachScrollRefresher();
    });
  }

  void _controllFabVisibilty() {
    if (scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (isFabVisible) {
        isFabVisible = false;
        emit(ChangeFabVisibilityState(isFabVisible: false));
      }
    } else if (scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      if (!isFabVisible) {
        isFabVisible = true;
        emit(ChangeFabVisibilityState(isFabVisible: true));
      }
    }
  }

  Future<void> logOut() async {
    String? refreshToken =
        await SecureSharedPref.getValues(key: refreshTokenParam);
    if (refreshToken != null) {
      emit(LogOutLoadingState());
      final result = await homeRepoImp.logOut(refreshToken: refreshToken);
      result.fold((error) {
        error.statusCode == 403
            ? emit(RefreshFailedState())
            : emit(LogOutFailureState(errMessage: error.errMessage));
      }, (success) async {
        await SecureSharedPref.putValue(key: accessTokenParam, value: null);
        await SecureSharedPref.putValue(key: refreshTokenParam, value: null);
        emit(LogOutSuccessState());
      });
    }
  }

  Future<void> changeFilter(int index) async {
    if (index != filterIndex) {
      filterIndex = index;
      pageNum = 1;
      tasksList.clear();
      emit(ChangeFilterTypeState());
      await getAllTasks();
    }
  }

  void _attachScrollRefresher() {
    scrollController.addListener(() {
      if (hasMore &&
          scrollController.position.pixels >=
              scrollController.position.maxScrollExtent &&
          state is! FetchMoreLoadingState) {
        _loadMoreTasks();
      }
    });
  }

  Future<void> getAllTasks() async {
    emit(GetAllTasksLoadingState());
    final result = await homeRepoImp.getAllTasks(pageNum,
        filterType: filterIndex != 0 ? filterList[filterIndex] : null);
    result.fold((error) {
      emit(GetAllTasksFailureState(errMessage: error.errMessage));
    }, (list) {
      hasMore = list.length == 20 ? true : false;
      tasksList.addAll(list);
      emit(GetAllTasksSuccessState(tasksList: list));
    });
  }

  Future<void> _loadMoreTasks() async {
    if (hasMore) {
      pageNum++;
      emit(FetchMoreLoadingState());
      final result = await homeRepoImp.getAllTasks(pageNum,
          filterType: filterIndex != 0 ? filterList[filterIndex] : null);
      result.fold((error) {
        emit(GetAllTasksFailureState(errMessage: error.errMessage));
      }, (list) {
        hasMore = list.length == 20 ? true : false;
        tasksList.addAll(list);
        emit(GetAllTasksSuccessState(tasksList: list));
      });
    }
  }
}

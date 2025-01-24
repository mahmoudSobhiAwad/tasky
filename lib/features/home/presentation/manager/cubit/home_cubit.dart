import 'dart:developer';

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
    pageNum = 1;
    tasksList.clear();
    emit(GetAllTasksLoadingState());
    final result = await homeRepoImp.getAllTasks(pageNum,
        filterType:
            filterIndex != 0 ? filterList[filterIndex].toLowerCase() : null);
    result.fold((error) {
      emit(GetAllTasksFailureState(errMessage: error.errMessage));
    }, (list) {
      hasMore = list.length == 20 ? true : false;
      tasksList.addAll(list);
      emit(GetAllTasksSuccessState());
    });
  }

  Future<void> _loadMoreTasks() async {
    if (hasMore) {
      pageNum++;
      emit(FetchMoreLoadingState());
      final result = await homeRepoImp.getAllTasks(pageNum,
          filterType:
              filterIndex != 0 ? filterList[filterIndex].toLowerCase() : null);
      result.fold((error) {
        emit(GetAllTasksFailureState(errMessage: error.errMessage));
      }, (list) {
        hasMore = list.length == 20 ? true : false;
        tasksList.addAll(list);
        emit(GetAllTasksSuccessState());
      });
    }
  }

  Future<void> updateTaskWithOther(TaskModel model) async {
    final index = tasksList.indexWhere((item) => item.id == model.id);
    if (index != -1) {
      tasksList[index] = tasksList[index].copyWith(
        imageModel: model.imageModel,
        id: model.id,
        updatedAt: model.updatedAt,
        createdAt: model.createdAt,
        user: model.user,
        title: model.title,
        desc: model.desc,
        priority: model.priority,
        status: model.status,
      );
      emit(GetAllTasksSuccessState());
    } else {
      // Handle the case where the task is not found (optional)
      log('Task with id ${model.id} not found.');
    }
  }

  void refreshScanQr(String qrCode) {
    emit(ScanQrCodeState());
    getOneTask(id: qrCode);
  }

  Future<void> addNewTask(TaskModel model) async {
    tasksList.insert(0, model);

    emit(GetAllTasksSuccessState());
  }

  Future<void> deleteTask(String? taskId) async {
    if (taskId != null) {
      emit(DeleteTaskLoadingState());
      final result = await homeRepoImp.deleteTask(taskId: taskId);
      result.fold((error) {
        emit(DeleteTaskFailureState(errMessage: error.errMessage));
      }, (task) {
        tasksList.removeWhere((model) => model.id == task.id);
        emit(GetAllTasksSuccessState());
      });
    }
  }

  Future<void> getOneTask({required String id}) async {
    emit(GetOneTaskLoadingState());
    final result = await homeRepoImp.getOneTask(qrCodeId: id);
    result.fold((error) {
      emit(GetOneTaskFailureState(errMessage: error.errMessage));
    }, (model) {
      emit(GetOneTaskSuccessState(taskModel: model));
    });
  }
}

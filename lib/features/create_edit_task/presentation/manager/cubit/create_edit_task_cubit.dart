import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:tasky/features/create_edit_task/data/models/create_edit_task_model.dart';
import 'package:tasky/features/create_edit_task/data/models/image_model.dart';
import 'package:tasky/features/create_edit_task/data/models/priority_model.dart';
import 'package:tasky/features/create_edit_task/data/models/task_model.dart';
import 'package:tasky/features/create_edit_task/data/repos/add_edit_task_repo_impl.dart';

part 'create_edit_task_state.dart';

class CreateEditTaskCubit extends Cubit<CreateEditTaskState> {
  CreateEditTaskCubit({required this.addEditTaskRepoImpl})
      : super(CreateEditTaskInitial());
  final AddEditTaskRepoImpl addEditTaskRepoImpl;

  Future<void> pickImage(ImageSource imageSource) async {
    final ImagePicker picker = ImagePicker();
    await picker.pickImage(source: imageSource).then((value) {
      if (value != null) {
        emit(ChangeCurrPictureState(
            imageModel:
                ImageModel(imagePath: value.path, imageType: ImageType.file)));
      }
    });
  }

  Future<void> deleteImage() async {
    emit(ChangeCurrPictureState(
        imageModel: ImageModel(imagePath: null, imageType: ImageType.empty)));
  }

  void changePirority(int value) async {
    emit(ChangePirorityState(value: pirorityList[value]?.title));
  }

  void changePickedDate(DateTime time) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(time);
    emit(ChangeDueDateState(date: formattedDate));
  }

  Future<void> uploadTask(CreateEditTaskModel model) async {
    if (model.imagePath != null) {
      emit(LoadingAddTaskState());
      final result = await addEditTaskRepoImpl.uploadImage(model.imagePath!);
      result.fold((error) {
        emit(FailureUploadImageState(errMessage: error.errMessage));
      }, (path) async {
        model.imagePath = path;
        await createTask(model);
      });
    }
  }

  Future<void> createTask(CreateEditTaskModel model) async {
    final result = await addEditTaskRepoImpl.createTask(model);
    result.fold((error) {
      emit(FailureAddTaskState(errMessage: error.errMessage));
    }, (model) {
      emit(SuccessAddTaskState(taskModel: model));
    });
  }
}

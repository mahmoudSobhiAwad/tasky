import 'package:flutter/material.dart';
import 'package:tasky/core/utils/extensions/navigation_handler.dart';
import 'package:tasky/core/widgets/custom_dialog.dart';

class CustomDeleteTaskAlert extends StatelessWidget {
  const CustomDeleteTaskAlert({
    super.key,
    this.isLoading = false,
    required this.deleteTask,
  });
  final bool isLoading;
  final void Function() deleteTask;

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      onTapFirstAction: () {
        context.pop();
      },
      onTapSecondAction: () {
        deleteTask();
       
      },
      isLoading: isLoading,
      firstActionName: 'Discard',
      secondActionName: 'Delete',
      mainTitle: 'Are You Sure To Delete this Task',
      bigIcon: Icon(
        Icons.warning,
        size: 60,
        color: Colors.amber,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasky/core/utils/theme/app_images.dart';
import 'package:tasky/core/widgets/custom_text_field.dart';

class CustomTaskDueDatePicker extends StatelessWidget {
  const CustomTaskDueDatePicker({
    super.key,
    this.date,
    required this.changeDate,
  });
  final String? date;
  final void Function(DateTime) changeDate;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Date Can\'t be Empty ';
        }
        return null;
      },
      controller: TextEditingController(text: date),
      spacing: 8,
      isReadOnly: true,
      suffixWidget: IconButton(
          onPressed: () {
            showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate:
                        DateTime(DateTime.now().year, DateTime.now().month + 2))
                .then((value) {
              if (value != null) {
                changeDate(value);
              }
            });
          },
          icon: SvgPicture.asset(AppImages.calendarIcon)),
      headerText: 'Due date',
      label: 'choose due date...',
    );
  }
}

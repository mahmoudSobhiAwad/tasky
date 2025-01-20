import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/utils/constants/var_contstant.dart';
import 'package:tasky/core/utils/theme/app_colors.dart';
import 'package:tasky/core/utils/theme/app_fonts.dart';
import 'package:tasky/core/widgets/custom_text_field.dart';
import 'package:tasky/features/sign_up/presentation/manager/cubit/sign_up_cubit.dart';

class ExpereinceLevelWithCubit extends StatelessWidget {
  const ExpereinceLevelWithCubit({
    super.key,
    required this.expLevelController,
    this.validator,
  });

  final TextEditingController expLevelController;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (prev, current) {
        return current is ChangeExperienceLevelState;
      },
      builder: (context, state) {
        if (state is ChangeExperienceLevelState) {
          expLevelController.text = state.value;
        }

        return CustomTextFormField(
            validator: validator,
            isReadOnly: true,
            maxLine: 1,
            controller: expLevelController,
            suffixWidget: PopupMenuButton(
                offset: Offset(0, 40),
                color: AppColor.lavender100,
                icon: Icon(Icons.keyboard_arrow_down_rounded),
                itemBuilder: (context) {
                  return [
                    ...List.generate(experienceLevelList.length, (index) {
                      return PopupMenuItem(
                          onTap: () {
                            context
                                .read<SignUpCubit>()
                                .changeSelectedExpereincneLevel(
                                  experienceLevelList[index],
                                );
                          },
                          value: experienceLevelList[index],
                          child: Text(
                            experienceLevelList[index],
                            style: AppFontStyle.bold14
                                .copyWith(color: AppColor.primary100),
                          ));
                    })
                  ];
                }));
      },
    );
  }
}

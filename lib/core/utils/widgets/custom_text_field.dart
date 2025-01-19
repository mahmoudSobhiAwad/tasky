import 'package:flutter/material.dart';
import 'package:tasky/core/utils/theme/app_colors.dart';
import 'package:tasky/core/utils/theme/app_fonts.dart';
import 'package:tasky/core/utils/widgets/custom_outline_border.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      this.maxLine,
      this.validator,
      this.controller,
      this.enableFocusBorder = true,
      this.textInputType,
      this.suffixText,
      this.suffixTextStyle,
      this.labelWidget,
      this.borderColor,
      this.borderRadius,
      this.borderWidth,
      this.prefixWidget,
      this.suffixWidget,
      this.textStyle,
      this.enableFill = true,
      this.fillColor,
      this.label,
      this.isObeseureText = false,
      this.labelStyle,
      this.focusBorderColor,
      this.floatingLabelBehavior,
      this.focusNode,
      this.textInputAction,
      this.onFieldSubmitted,
      this.enabled = true,
      this.headerText,
      this.isReadOnly = false,
      this.headerTextStyle});
  final Widget? labelWidget;
  final double? borderRadius;
  final String? Function(String? value)? validator;
  final double? borderWidth;
  final Color? borderColor;
  final Color? fillColor;
  final bool enableFill;
  final Widget? suffixWidget;
  final String? suffixText;
  final TextStyle? suffixTextStyle;
  final Widget? prefixWidget;
  final int? maxLine;
  final TextInputType? textInputType;
  final bool enableFocusBorder;
  final TextEditingController? controller;
  final TextStyle? textStyle;
  final String? label;
  final TextStyle? labelStyle;
  final bool isObeseureText;
  final TextInputAction? textInputAction;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final Color? focusBorderColor;
  final FocusNode? focusNode;
  final void Function(String?)? onFieldSubmitted;
  final bool enabled; // Add this line to control editability
  final String? headerText;
  final TextStyle? headerTextStyle;
  final bool isReadOnly;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (headerText != null)
          Text(
            headerText ?? "",
            style: headerTextStyle,
          ),
        TextFormField(
          readOnly: isReadOnly,
          enabled: enabled,
          obscureText: isObeseureText,
          validator: validator,
          focusNode: focusNode,
          textInputAction: textInputAction,
          controller: controller,
          maxLines: maxLine,
          keyboardType: textInputType,
          cursorColor: Colors.black,
          style: textStyle,
          onFieldSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: labelStyle ??
                AppFontStyle.regular14.copyWith(color: AppColor.gray13),
            errorStyle: AppFontStyle.regular12,
            focusColor: Colors.black,
            suffixIcon: suffixWidget,
            suffixText: suffixText,
            suffixStyle: suffixTextStyle,
            prefixIcon: prefixWidget,
            label: labelWidget,
            floatingLabelBehavior:
                floatingLabelBehavior ?? FloatingLabelBehavior.never,
            disabledBorder: customOutLineBorders(),
            border: customOutLineBorders(borderColor: AppColor.gray100),
            enabledBorder: customOutLineBorders(borderColor: AppColor.gray100),
            focusedBorder: customOutLineBorders(
              borderColor: enableFocusBorder ? AppColor.black100 : null,
            ),
            hoverColor: Colors.white,
          ),
        ),
      ],
    );
  }
}

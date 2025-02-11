import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tasky/core/utils/theme/app_colors.dart';
import 'package:tasky/core/utils/theme/app_fonts.dart';
import 'package:tasky/core/widgets/custom_outline_border.dart';

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
      this.headerTextStyle,
      this.spacing,
      this.initialValue,
      this.inputFormatters});
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
  final double? spacing;
  final TextInputType? textInputType;
  final bool enableFocusBorder;
  final TextEditingController? controller;
  final TextStyle? textStyle;
  final String? label;
  final TextStyle? labelStyle;
  final bool isObeseureText;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final Color? focusBorderColor;
  final FocusNode? focusNode;
  final String? initialValue;
  final void Function(String?)? onFieldSubmitted;
  final bool enabled; // Add this line to control editability
  final String? headerText;
  final TextStyle? headerTextStyle;
  final bool isReadOnly;
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: spacing ?? 0,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (headerText != null)
          Text(
            headerText ?? "",
            style: headerTextStyle ??
                AppFontStyle.regular12.copyWith(color: AppColor.grayPurple100),
          ),
        TextFormField(
          inputFormatters: inputFormatters,
          readOnly: isReadOnly,
          enabled: enabled,
          obscureText: isObeseureText,
          validator: validator,
          focusNode: focusNode,
          textInputAction: textInputAction,
          initialValue: initialValue,
          controller: controller,
          maxLines: maxLine,
          keyboardType: textInputType,
          cursorColor: Colors.black,
          style: textStyle,
          onFieldSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            alignLabelWithHint: true,
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

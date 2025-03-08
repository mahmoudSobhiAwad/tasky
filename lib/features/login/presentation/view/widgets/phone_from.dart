import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:tasky/core/utils/theme/app_colors.dart';
import 'package:tasky/core/utils/theme/app_fonts.dart';
import 'package:tasky/core/widgets/custom_outline_border.dart';

class PhoneFormField extends StatelessWidget {
  const PhoneFormField({
    super.key,
    required this.phoneController,
    this.phoneNumberFocusNode,
    required this.changeCountryPicked,
    this.initialCountryCode,
  });

  final TextEditingController phoneController;
  final FocusNode? phoneNumberFocusNode;
  final void Function(Country counrty) changeCountryPicked;
  final String? initialCountryCode;
  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
        initialCountryCode: initialCountryCode ?? 'EG',
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: InputDecoration(
          labelText: 'Phone Number',
          labelStyle: AppFontStyle.regular14.copyWith(color: AppColor.gray13),
          border: customOutLineBorders(),
          focusedBorder: customOutLineBorders(borderColor: AppColor.black100),
        ),
        controller: phoneController,
        focusNode: phoneNumberFocusNode,
        validator: (value) {
          if (value != null && value.isValidNumber()) {
            return 'Phone can\'t be Empty ';
          }
          return null;
        },
        onSubmitted: (value) {
          phoneNumberFocusNode?.nextFocus();
        },
        onCountryChanged: changeCountryPicked);
  }
}

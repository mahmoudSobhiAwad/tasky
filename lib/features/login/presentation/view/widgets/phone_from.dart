import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tasky/core/utils/theme/app_colors.dart';
import 'package:tasky/core/utils/theme/app_fonts.dart';
import 'package:tasky/core/widgets/custom_text_field.dart';

class PhoneFormField extends StatelessWidget {
  const PhoneFormField({
    super.key,
    required this.country,
    required this.changeCountry,
    required this.phoneController,
    this.validator,
    this.focusNode,
  });
  final Country country;
  final FocusNode? focusNode;
  final TextEditingController phoneController;
  final void Function(Country country) changeCountry;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      maxLine: 1,
      controller: phoneController,
      validator: validator,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (value) {
        FocusScope.of(context).requestFocus(focusNode);
      },
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      textInputType: TextInputType.phone,
      prefixWidget: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3),
        child: Row(
          spacing: 3,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              country.flagEmoji,
              style: TextStyle(fontSize: 24),
            ),
            Text(
              '+${country.phoneCode}',
              style: AppFontStyle.bold14.copyWith(color: AppColor.black100),
            ),
            IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  showCountryPicker(context: context, onSelect: changeCountry);
                },
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColor.gray13,
                ))
          ],
        ),
      ),
    );
  }
}

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:tasky/core/utils/theme/app_colors.dart';
import 'package:tasky/core/utils/theme/app_fonts.dart';
import 'package:tasky/core/widgets/custom_text_field.dart';

class PhoneFormField extends StatelessWidget {
  const PhoneFormField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
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
                  showCountryPicker(context: context, onSelect: (counrty) {});
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

Country country = Country.parse('EG');

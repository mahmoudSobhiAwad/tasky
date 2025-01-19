import 'package:flutter/material.dart';
import 'package:tasky/core/utils/widgets/custom_boarding_image.dart';
import 'package:tasky/features/on_boarding/presentation/view/widgets/titles_with_button.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          spacing: 24,
          children: [
            Expanded(child: CustomBoardinImage()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TitlesWithButton(),
            ),
            SizedBox(),
          ],
        ),
      ),
    );
  }
}

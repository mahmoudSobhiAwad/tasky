import 'package:flutter/material.dart';
import 'package:tasky/core/utils/widgets/custom_boarding_image.dart';
import 'package:tasky/features/login/presentation/view/widgets/login_form.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Expanded(child: CustomBoardinImage()),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: LoginForm(),
          ),
        ],
      ),
    );
  }
}

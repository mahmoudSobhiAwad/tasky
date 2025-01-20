import 'package:flutter/material.dart';
import 'package:tasky/core/utils/constants/var_contstant.dart';
import 'package:tasky/core/utils/functions/secure_shared_pref.dart';
import 'package:tasky/features/home/presentation/view/home_view.dart';
import 'package:tasky/features/login/presentation/view/login_view.dart';
import 'package:tasky/features/on_boarding/presentation/view/on_boarding_view.dart';

class SplashChecking extends StatelessWidget {
  const SplashChecking({super.key});
  Future<String?> _checkExist() async {
    return await SecureSharedPref.getValues(
      key: accessTokenParam,
    );
  }

  Future<String?> _skipOnBoarding() async {
    return await SecureSharedPref.getValues(
      key: 'skip',
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _checkExist(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            if (snapshot.data != null) {
              return HomeView();
            } else {
              return FutureBuilder(
                  future: _skipOnBoarding(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Scaffold(
                        body: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else if (snapshot.connectionState ==
                            ConnectionState.done &&
                        snapshot.data != null) {
                      return LoginView();
                    }
                    return OnBoardingView();
                  });
            }
          } else {
            return OnBoardingView();
          }
        });
  }
}

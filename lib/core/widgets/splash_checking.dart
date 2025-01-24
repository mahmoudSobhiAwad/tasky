import 'package:flutter/material.dart';
import 'package:tasky/core/utils/constants/var_contstant.dart';
import 'package:tasky/core/utils/functions/secure_shared_pref.dart';
import 'package:tasky/features/home/presentation/view/home_view.dart';
import 'package:tasky/features/login/presentation/view/login_view.dart';
import 'package:tasky/features/on_boarding/presentation/view/on_boarding_view.dart';

class SplashChecking extends StatefulWidget {
  const SplashChecking({super.key});

  @override
  State<SplashChecking> createState() => _SplashCheckingState();
}

class _SplashCheckingState extends State<SplashChecking> {
  Widget? _initialView;

  @override
  void initState() {
    super.initState();
    _determineInitialView();
  }

  Future<void> _determineInitialView() async {
    try {
      final skipOnboarding = await SecureSharedPref.getValues(key: 'skip');
      if (skipOnboarding == null) {
        setState(() {
          _initialView = const OnBoardingView();
        });
        return;
      }

      final accessToken =
          await SecureSharedPref.getValues(key: accessTokenParam);
      setState(() {
        _initialView =
            accessToken != null ? const HomeView() : const LoginView();
      });
    } catch (e) {
      setState(() {
        _initialView = const OnBoardingView();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_initialView == null) {
      return const Scaffold();
    }

    return _initialView!;
  }
}

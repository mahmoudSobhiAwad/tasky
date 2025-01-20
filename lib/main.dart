import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:tasky/core/utils/functions/cubit_observer.dart';
import 'package:tasky/core/utils/functions/service_locator.dart';
import 'package:tasky/core/utils/theme/app_colors.dart';
import 'package:tasky/features/on_boarding/presentation/view/on_boarding_view.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await setUp();
  Bloc.observer = SimpleBlocObserver();

  runApp(const Tasky());
}

class Tasky extends StatefulWidget {
  const Tasky({super.key});

  @override
  State<Tasky> createState() => _TaskyState();
}

class _TaskyState extends State<Tasky> {
  @override
  void initState() {
    FlutterNativeSplash.remove();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: AppColor.white100,
          useMaterial3: true,
          iconButtonTheme: IconButtonThemeData(
              style: ButtonStyle(
                  iconColor:
                      WidgetStatePropertyAll<Color>(AppColor.black100)))),
      home: const OnBoardingView(),
    );
  }
}

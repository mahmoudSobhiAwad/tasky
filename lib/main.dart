import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:tasky/app.dart';
import 'package:tasky/core/utils/functions/cubit_observer.dart';
import 'package:tasky/core/utils/functions/service_locator.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isMacOS || Platform.isWindows) {
    windowManager.setMinimumSize(const Size(350, 400));
  }
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await setUp();
  Bloc.observer = SimpleBlocObserver();

  runApp(const Tasky());
}

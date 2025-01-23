import 'package:flutter/material.dart';

extension NavigationExtensions on BuildContext {
  PageRouteBuilder<T> _animatedRoute<T>(Widget page,
      {Curve curve = Curves.easeInOut,
      Duration transationDuration = const Duration(milliseconds: 300),
      Duration reverseTransationDuration = const Duration(milliseconds: 300)}) {
    return PageRouteBuilder(
      transitionDuration: transationDuration,
      reverseTransitionDuration: reverseTransationDuration,
      // add the page where we navigate
      pageBuilder: (context, animation, secondaryAnimation) => page,
      // add transation for the page we set here fade transation according to requirement
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // while navigate to we set navigated to page with fade in the take the first animation.
        var fadeIn = Tween(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: animation, curve: curve),
        );
        // while navigate to we set current page with fade out the take the second animation.

        var fadeOut = Tween(begin: 1.0, end: 0.0).animate(
          CurvedAnimation(parent: secondaryAnimation, curve: curve),
        );
        //return the fade transation

        return FadeTransition(
          // the navigated to opacity
          opacity: fadeIn,
          // the current page
          child: FadeTransition(
            opacity: fadeOut,
            child: child,
          ),
        );
      },
    );
  }

  void pop<T extends Object?>([T? result]) {
    Navigator.pop(this, result);
  }

  Future<T?> push<T>(Widget page,
      {Curve curve = Curves.easeInOut,
      Duration transationDuration = const Duration(milliseconds: 300),
      Duration reverseTransationDuration = const Duration(milliseconds: 300)}) {
    return Navigator.push<T>(
      this,
      _animatedRoute(page,
          curve: curve,
          transationDuration: transationDuration,
          reverseTransationDuration: reverseTransationDuration),
    );
  }

  void pushReplacement(Widget page,
      {Curve curve = Curves.easeInOut,
      Duration transationDuration = const Duration(milliseconds: 300),
      Duration reverseTransationDuration = const Duration(milliseconds: 300)}) {
    Navigator.pushReplacement(
      this,
      _animatedRoute(page,
          curve: curve,
          transationDuration: transationDuration,
          reverseTransationDuration: reverseTransationDuration),
    );
  }

  void pushAndRemoveUntil(Widget page,
      {Curve curve = Curves.easeInOut,
      Duration transationDuration = const Duration(milliseconds: 300),
      Duration reverseTransationDuration = const Duration(milliseconds: 300)}) {
    Navigator.pushAndRemoveUntil(
      this,
      _animatedRoute(page,
          curve: curve,
          transationDuration: transationDuration,
          reverseTransationDuration: reverseTransationDuration),
      (route) => false,
    );
  }
}

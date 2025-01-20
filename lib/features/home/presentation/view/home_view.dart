import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:tasky/features/home/presentation/view/widgets/custom_floating_buttons.dart';
import 'package:tasky/features/home/presentation/view/widgets/dialog_stay_exist.dart';
import 'package:tasky/features/home/presentation/view/widgets/home_body.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ScrollController _scrollController = ScrollController();
  bool _isFabVisible = true;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (_isFabVisible) {
        setState(() {
          _isFabVisible = false;
        });
      }
    } else if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      if (!_isFabVisible) {
        setState(() {
          _isFabVisible = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult:(didPop, result) async{
         if (didPop) {
          return;
        }
        bool checkAfter = false;
        checkAfter = await showDialogToStayOrExit(context) ?? false;

        if (checkAfter && context.mounted) {
          SystemNavigator.pop();
        }
      },
      child: SafeArea(
        child: Scaffold(
          body: HomeBody(scrollController: _scrollController),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: _isFabVisible ? CustomFloatingButtons() : null,
        ),
      ),
    );
  }
}


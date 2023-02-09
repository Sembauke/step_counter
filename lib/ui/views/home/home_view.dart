import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:my_first_app/ui/common/app_colors.dart';
import 'package:my_first_app/ui/common/ui_helpers.dart';

import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(0x13, 0x13, 0x12, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0x1e, 0x1e, 0x1f, 1),
        title: Text(
          'StepUp: The Leveling Adventure',
          style: TextStyle(
            color: Colors.white.withOpacity(0.87),
          ),
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        height: 100,
        child: Card(
          margin: const EdgeInsets.all(16),
          color: const Color.fromRGBO(0x1e, 0x1e, 0x1f, 1),
          child: Center(
            child: Text(
              'Steps set Today',
              style: TextStyle(
                color: Colors.white.withOpacity(0.87),
                fontSize: 30,
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromRGBO(0x1e, 0x1e, 0x1f, 1),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();
}

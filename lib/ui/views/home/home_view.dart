import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return ViewModelBuilder<HomeViewModel>.reactive(
        viewModelBuilder: () => HomeViewModel(),
        onViewModelReady: (viewModel) {
          viewModel.initialise();
        },
        builder: (context, viewModel, child) {
          return Scaffold(
            backgroundColor: const Color.fromRGBO(0x13, 0x13, 0x12, 1),
            appBar: AppBar(
              backgroundColor: const Color.fromRGBO(0x1e, 0x1e, 0x1f, 1),
              title: Text(
                'StepUp',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.87),
                ),
              ),
              centerTitle: true,
            ),
            body: Container(
              constraints: const BoxConstraints(minHeight: 100, maxHeight: 400),
              child: Card(
                margin: const EdgeInsets.all(16),
                color: const Color.fromRGBO(0x1e, 0x1e, 0x1f, 1),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          'Today',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.87),
                            fontSize: 30,
                          ),
                        ),
                      ),
                      FutureBuilder(
                        future: viewModel.steps,
                        initialData: 1,
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            return CircularStepCounter(
                              model: viewModel,
                              snapshot: snapshot,
                            );
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
                      )
                    ],
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
        });
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();
}

class CircularStepCounter extends StatelessWidget {
  const CircularStepCounter({
    Key? key,
    required this.model,
    required this.snapshot,
  }) : super(key: key);

  final HomeViewModel model;
  final AsyncSnapshot snapshot;

  int handleSteps(int steps) {
    return steps > 0 ? steps : 1;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            alignment: Alignment.topCenter,
            width: 250,
            height: 250,
            child: Center(
              child: Text(
                '${handleSteps(snapshot.data)} \n steps',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.87),
                  fontSize: 40,
                ),
              ),
            ),
          ),
          Center(
            child: SizedBox(
              width: 250,
              height: 250,
              child: CircularProgressIndicator(
                backgroundColor: const Color.fromRGBO(0x13, 0x13, 0x12, 1),
                value: handleSteps(snapshot.data) / 10000,
                strokeWidth: 10,
              ),
            ),
          )
        ],
      ),
    );
  }
}

import 'dart:async';
import 'dart:developer';
import 'package:pedometer/pedometer.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  Stream<StepCount>? _stepCountStream;
  Stream<StepCount>? get stepCountStream => _stepCountStream;

  Future? steps;

  void initialise() {
    initialisePedometer();
  }

  void onStepCount(StepCount event) {
    steps = Future.value(event.steps);
    log('event.steps: ${event.steps}');
    notifyListeners();
  }

  void handleStepError(error) {
    log('error: $error');
  }

  Future<void> initialisePedometer() async {
    _stepCountStream = Pedometer.stepCountStream;
    notifyListeners();
    _stepCountStream!.listen(onStepCount).onError(handleStepError);
  }
}

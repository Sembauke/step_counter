import 'dart:async';
import 'dart:developer';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  Stream<StepCount>? _stepCountStream;
  Stream<StepCount>? get stepCountStream => _stepCountStream;

  Future? steps;

  void initialise() {
    checkUserPermissions();
  }

  Future checkUserPermissions() async {
    await Permission.activityRecognition.request();
    if (await Permission.activityRecognition.isDenied) {
      await Permission.activityRecognition.request().then((statusValue) {
        if (statusValue != PermissionStatus.denied) {
          initialisePedometer();
        } else {
          checkUserPermissions();
        }
      });
    } else {
      initialisePedometer();
    }
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

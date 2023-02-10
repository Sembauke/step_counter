import 'dart:async';
import 'dart:developer';
import 'package:my_first_app/app/app.locator.dart';
import 'package:my_first_app/services/step_storage_service.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  Stream<StepCount>? _stepCountStream;
  Stream<StepCount>? get stepCountStream => _stepCountStream;

  final StepStorageService _stepStorageService = locator<StepStorageService>();

  Future? steps;
  int stepCount = 0;

  set setStepCount(String value) {
    stepCount = int.parse(value);
    notifyListeners();
  }

  void initialise() async {
    checkUserPermissions();

    _stepStorageService.init();

    setStepCount = await _stepStorageService.getSteps();
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

  void onStepCount(StepCount event) async {
    stepCount++;
    _stepStorageService.setSteps(stepCount);
    steps = Future.value(stepCount);
    notifyListeners();
  }

  void handleStepError(error) {
    log('error: $error');
  }

  Future<void> initialisePedometer() async {
    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream!.listen(onStepCount).onError(handleStepError);
  }
}

import 'package:shared_preferences/shared_preferences.dart';

class StepStorageService {
  String _todaySteps = '0';
  String get todaySteps => _todaySteps;

  set setTodaysSteps(String steps) {
    _todaySteps = steps;
  }

  Future<void> init() async {
    setTodaysSteps = await getSteps();
  }

  Future<String> getSteps() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String date = checkCurrentDate();

    String? steps = prefs.getString(date);

    if (steps == null) setSteps(int.parse('1'));

    return steps ?? '1';
  }

  Future<void> setSteps(int steps) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String date = checkCurrentDate();

    try {
      prefs.setString(date, steps.toString());
    } catch (e) {
      return Future.error('Error');
    }

    setTodaysSteps = steps.toString();
  }

  String checkCurrentDate() {
    DateTime epoch = DateTime.now();

    int date = epoch.day + epoch.month + epoch.year;

    return date.toString();
  }
}

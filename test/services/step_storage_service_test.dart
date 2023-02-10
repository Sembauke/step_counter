import 'package:flutter_test/flutter_test.dart';
import 'package:my_first_app/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('StepStorageServiceTest -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}

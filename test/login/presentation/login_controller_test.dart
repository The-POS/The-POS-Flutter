import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:thepos/features/login/data/login_service/login_errors.dart';
import 'package:thepos/features/login/data/login_use_case/login_use_case_output.dart';
import 'package:thepos/features/login/data/models/login_result.dart';

import 'helpers/shared_helpers.dart';

class LoginController extends GetxController implements LoginUseCaseOutput {
  RxBool loading = RxBool(false);

  void login() {
    loading.value = true;
  }

  @override
  void onClose() {
    loading.value = false;
    super.onClose();
  }

  @override
  void onLoginFail(LoginErrors error) {}

  @override
  void onLoginSuccess(LoginResult result) {
    loading.value = false;
  }
}

void main() {
  test('loading rx property should be true when login method called', () {
    final LoginController sut = LoginController();
    Get.put(sut);

    expect(sut.loading.value, false, reason: 'precondition failed');

    sut.login();

    expect(sut.loading.value, true);
  });

  test('loading rx property should be false on delete controller', () async {
    final LoginController sut = LoginController();
    Get.put(sut);

    expect(sut.loading.value, false, reason: 'precondition failed');

    sut.loading.value = true;

    await Get.delete<LoginController>();

    expect(sut.loading.value, false);
  });

  test('loading rx property should be false on onLoginSuccess called',
      () async {
    final LoginController sut = LoginController();
    Get.put(sut);

    expect(sut.loading.value, false, reason: 'precondition failed');

    sut.onLoginSuccess(anyLoginResult);

    expect(sut.loading.value, false);
  });
}

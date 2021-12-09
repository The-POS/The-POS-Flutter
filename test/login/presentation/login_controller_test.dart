import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:thepos/features/login/presentation/controller/login_controller.dart';

import 'helpers/shared_helpers.dart';

void main() {
  LoginController _makeSUT() {
    final LoginController sut = LoginController();
    Get.put(sut);
    return sut;
  }

  tearDown(() async {
    await Get.delete<LoginController>();
  });

  test('loading rx property should be false on init', () {
    final LoginController sut = _makeSUT();

    expect(sut.loading.value, false);
  });

  test('loading rx property should be true when login method called', () {
    final LoginController sut = _makeSUT();

    sut.login();

    expect(sut.loading.value, true);
  });

  test('loading rx property should be false on delete controller', () async {
    final LoginController sut = _makeSUT();

    sut.loading.value = true;

    await Get.delete<LoginController>();

    expect(sut.loading.value, false);
  });

  test('loading rx property should be false on onLoginSuccess called',
      () async {
    final LoginController sut = _makeSUT();

    sut.login();
    sut.onLoginSuccess(anyLoginResult);

    expect(sut.loading.value, false);
  });

  test('loading rx property should be false on onLoginFail called', () async {
    final LoginController sut = _makeSUT();

    sut.login();
    sut.onLoginFail(anyLoginError);

    expect(sut.loading.value, false);
  });
}

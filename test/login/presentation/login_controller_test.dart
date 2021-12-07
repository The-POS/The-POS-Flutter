import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  RxBool loading = RxBool(false);

  void login() {
    loading.value = true;
  }

  @override
  void onClose() {
    loading.value = false;
    super.onClose();
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
}

import 'package:get/get.dart';

import '../../data/login_service/login_errors.dart';
import '../../data/login_use_case/login_use_case_output.dart';
import '../../data/models/login_result.dart';

class LoginController extends GetxController implements LoginUseCaseOutput {
  RxBool loading = RxBool(false);

  void login(String name, String password) {
    loading.value = true;
  }

  @override
  void onClose() {
    loading.value = false;
    super.onClose();
  }

  @override
  void onLoginSuccess(LoginResult result) {
    loading.value = false;
  }

  @override
  void onLoginFail(LoginErrors error) {
    loading.value = false;
  }
}

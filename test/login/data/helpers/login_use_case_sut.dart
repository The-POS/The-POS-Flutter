import 'package:thepos/features/login/data/login_use_case.dart';

import '../../../helpers/mock_client_stub.dart';

class LoginUseCaseSUT {
  LoginUseCaseSUT(this.client, this.loginUseCase);

  final MockClientStub client;
  final LoginUseCase loginUseCase;
}

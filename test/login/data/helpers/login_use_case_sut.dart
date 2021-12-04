import 'package:thepos/features/login/data/login_api/remote_login_api.dart';

import '../../../helpers/mock_client_stub.dart';

class LoginUseCaseSUT {
  LoginUseCaseSUT(this.client, this.loginUseCase);

  final MockClientStub client;
  final RemoteLoginApi loginUseCase;
}

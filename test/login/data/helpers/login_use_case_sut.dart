import 'package:thepos/features/login/data/remote_login/remote_login_api.dart';

import '../../../helpers/mock_client_stub.dart';

class LoginUseCaseSUT {
  LoginUseCaseSUT(this.client, this.loginUseCase);

  final MockClientStub client;
  final RemoteLoginApi loginUseCase;
}

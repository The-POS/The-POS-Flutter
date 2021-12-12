import 'package:thepos/features/login/data/login_service/api_login/api_login_service.dart';

import '../../../../helpers/mock_client_stub.dart';

class ApiLoginServiceSUT {
  ApiLoginServiceSUT(this.client, this.apiLoginService);

  final MockClientStub client;
  final ApiLoginService apiLoginService;
}

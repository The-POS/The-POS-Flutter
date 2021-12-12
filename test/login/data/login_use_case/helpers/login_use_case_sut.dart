import 'package:thepos/features/login/data/login_service/login_service.dart';
import 'package:thepos/features/login/data/login_use_case/login_use_case.dart';
import 'package:thepos/features/login/data/login_use_case/login_use_case_output.dart';

class LoginUseCaseSUT {
  LoginUseCaseSUT(
      {required this.service, required this.output, required this.useCase});

  final LoginService service;
  final LoginUseCaseOutput output;
  final LoginUseCase useCase;
}

// ignore_for_file: avoid_void_async

import 'package:connectivity/connectivity.dart';
import 'package:faker_dart/faker_dart.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thepos/core/auth_manager.dart';
import 'package:thepos/core/login_composer/login_use_case_factory.dart';
import 'package:thepos/core/navigator/app_navigator_factory.dart';
import 'package:thepos/core/preferences_utils.dart';
import 'package:thepos/features/home/data/datasources/home_faker_data_source.dart';
import 'package:thepos/features/home/data/datasources/home_local_data_source.dart';
import 'package:thepos/features/home/data/datasources/home_remote_data_source.dart';
import 'package:thepos/features/home/data/models/product.dart';
import 'package:thepos/features/home/data/repositories/home_repository.dart';
import 'package:thepos/features/invoice/data/data_sources/api_invoice/remote_store_invoice.dart';
import 'package:thepos/features/invoice/data/data_sources/local_store_invoice.dart';
import 'package:thepos/features/invoice/data/data_sources/store_invoice.dart';
import 'package:thepos/features/invoice/data/repositories/invoice_repository.dart';
import 'package:thepos/features/login/data/login_service/api_login/api_login_service.dart';
import 'package:thepos/features/login/data/login_service/login_service.dart';
import 'package:thepos/features/login/data/login_use_case/login_use_case.dart';
import 'package:thepos/features/login/presentation/controller/login_controller.dart';
import 'package:thepos/features/splash/presentation/controllers/splash_controller.dart';
import 'package:thepos/features/splash/presentation/splash_router.dart';

import 'config.dart';

late Box<Product> productsBox;
final faker = Faker.instance;
final AppNavigatorFactory navigatorFactory = AppNavigatorFactory();
Future<void> init() async {
  await Hive.initFlutter();
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  await createSplashController(sharedPreferences);
  await createLoginController(sharedPreferences);
  setupGetIt();
  Hive.registerAdapter(ProductAdapter());
  productsBox = await Hive.openBox<Product>('productsBox');
  await PreferenceUtils.init();
}

Future<void> createSplashController(SharedPreferences sharedPreferences) async {
  final AuthManager authManager = AuthManager(sharedPreferences);
  final SplashRouter splashRouter = SplashRouter(
      navigatorFactory: navigatorFactory,
      isAuthenticated: authManager.isAuthenticated);
  final SplashController splashController =
      SplashController(splashRouter.navigateToNextScreen);
  Get.put(splashController);
}

Future<void> createLoginController(SharedPreferences sharedPreferences) async {
  final Uri loginUri = Uri.https(domain, '$mainUrl/api/v2/login');
  print('loginUri $loginUri');
  final LoginService loginService = ApiLoginService(http.Client(), loginUri);
  final LoginController loginController = LoginController();
  final LoginUseCaseFactory factory = LoginUseCaseFactory();
  final LoginUseCase loginUseCase = factory.makeUseCase(
      loginController: loginController,
      sharedPreferences: sharedPreferences,
      navigatorFactory: navigatorFactory,
      loginService: loginService);
  loginController.loginService = loginUseCase.login;
  Get.lazyPut<LoginController>(() => loginController);
}

final getIt = GetIt.instance;
Future<void> setupGetIt() async {
//   //dataSorces
  getIt.registerSingleton<HomeLocalDataSource>(HomeLocalDataSource());
  getIt.registerSingleton<HomeRemoteDataSource>(HomeRemoteDataSource());
  getIt.registerSingleton<HomeFakerDataSource>(HomeFakerDataSource());

//Repositorise
  getIt.registerSingleton<HomeRepository>(HomeRepository(
      localDataSource: getIt(),
      remoteDataSource: getIt(),
      fakerDataSource: getIt()));

  final Uri uri = Uri.https(domain, '$mainUrl/api/v2/sales-invoices');

  final Box<String> hiveBox = await Hive.openBox('invoicesBox');

  final StoreInvoice remote = RemoteStoreInvoice(http.Client(), uri);
  final StoreInvoice local = LocalStoreInvoice(hiveBox: hiveBox);

  getIt.registerSingleton<StoreInvoice>(InvoiceRepository(
    checkInternetConnectivity: checkInternetConnectivity,
    remote: remote,
    local: local,
  ));
}

Future<bool> checkInternetConnectivity() async {
  final ConnectivityResult connectivityResult =
      await Connectivity().checkConnectivity();
  return connectivityResult == ConnectivityResult.mobile ||
      connectivityResult == ConnectivityResult.wifi;
}

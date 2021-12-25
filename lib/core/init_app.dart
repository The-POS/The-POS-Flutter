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
import 'package:thepos/features/customer/data/models/customer.dart';
import 'package:thepos/features/customer/data/repositories/customer_repository.dart';
import 'package:thepos/features/customer/data/serives/data_sources/api_customer/customer_remote_data_source.dart';
import 'package:thepos/features/customer/data/serives/data_sources/local_store_customer.dart';
import 'package:thepos/features/customer/data/serives/data_sources/remote_customer.dart';
import 'package:thepos/features/customer/presentation/controllers/customer_controller.dart';
import 'package:thepos/features/home/data/datasources/home_faker_data_source.dart';
import 'package:thepos/features/home/data/datasources/home_local_data_source.dart';
import 'package:thepos/features/home/data/datasources/home_remote_data_source.dart';
import 'package:thepos/features/home/data/models/category.dart';
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
import 'package:thepos/features/login/presentation/login_router.dart';
import 'package:thepos/features/splash/presentation/controllers/splash_controller.dart';
import 'package:thepos/features/splash/presentation/splash_router.dart';

import 'config.dart';

late Box<Product> productsBox;
late Box<Category> categoriesBox;
final Faker faker = Faker.instance;
final GetIt getIt = GetIt.instance;
late Box<Customer> customersBox;

final AppNavigatorFactory navigatorFactory = AppNavigatorFactory();
Future<void> init() async {
  await Hive.initFlutter();
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  final AuthManager authManager = AuthManager(sharedPreferences);
  final Box<String> invoicesBox = await Hive.openBox('invoicesBox');
  createSplashController(authManager.isAuthenticated);
  createLoginController(authManager);
  createHomeRepository(authManager);
  createInvoiceRepository(authManager, invoicesBox);
  Hive.registerAdapter(CustomerAdapter());
  customersBox = await Hive.openBox<Customer>('customerBox');
  createCustomerRepository(authManager ,customersBox);

  Hive.registerAdapter(ProductAdapter());
  productsBox = await Hive.openBox<Product>('productsBox');
  categoriesBox = await Hive.openBox<Category>('categoriesBox');
  await PreferenceUtils.init();
}

void createSplashController(bool isAuthenticated) {
  final SplashRouter splashRouter = SplashRouter(
      navigatorFactory: navigatorFactory, isAuthenticated: isAuthenticated);
  final SplashController splashController =
      SplashController(splashRouter.navigateToNextScreen);
  Get.put(splashController);
}

void createLoginController(AuthManager authManager) {
  final Uri loginUri = Uri.https(domain, '$mainUrl/api/v2/login');
  final LoginService loginService = ApiLoginService(http.Client(), loginUri);
  final LoginRouter loginRouter = LoginRouter(navigatorFactory);
  final LoginController loginController = LoginController();
  final LoginUseCaseFactory factory = LoginUseCaseFactory();
  final LoginUseCase loginUseCase = factory.makeUseCase(
      authManager: authManager,
      loginController: loginController,
      loginRouter: loginRouter,
      loginService: loginService);
  loginController.loginService = loginUseCase.login;
  Get.lazyPut<LoginController>(() => loginController);
}

void createHomeRepository(AuthManager authManager) {
  getIt.registerLazySingleton<HomeRepository>(
    () {
      final HomeLocalDataSource localDataSource = HomeLocalDataSource();

      final HomeRemoteDataSource remoteDataSource =
          HomeRemoteDataSource(token: authManager.token);

      final HomeFakerDataSource fakerDataSource = HomeFakerDataSource();

      return HomeRepository(
          localDataSource: localDataSource,
          remoteDataSource: remoteDataSource,
          fakerDataSource: fakerDataSource);
    },
  );
}

void createInvoiceRepository(AuthManager authManager, Box<String> invoicesBox) {
  getIt.registerLazySingleton<InvoiceRepository>(() {
    final Uri uri = Uri.https(domain, '$mainUrl/api/v2/sales-invoices');

    final StoreInvoice remote =
        RemoteStoreInvoice(http.Client(), uri, authManager.token);
    final StoreInvoice local = LocalStoreInvoice(hiveBox: invoicesBox);

    return InvoiceRepository(
      checkInternetConnectivity: checkInternetConnectivity,
      remote: remote,
      local: local,
    );
  });
}

void createCustomerRepository(AuthManager authManager, Box<Customer> hiveBoxCustomer) {
  final Uri uriCustomer = Uri.https(domain,'$mainUrl/api/v2/customers/');
  final CustomerController customerController = CustomerController();

  final CustomerRemoteDataSource remoteCustomer = CustomerRemoteDataSource(http.Client(),
      uriCustomer,authManager.token);
  final LocalStoreCustomer localCustomer = LocalStoreCustomer(hiveBox: hiveBoxCustomer);

  getIt.registerSingleton<RemoteCustomer>(CustomerRepository(
    checkInternetConnectivity: checkInternetConnectivity,
    remote: remoteCustomer,
    local: localCustomer,
  ));

  Get.lazyPut<CustomerController>(() => customerController);

}

Future<bool> checkInternetConnectivity() async {
  final ConnectivityResult connectivityResult =
      await Connectivity().checkConnectivity();
  return connectivityResult == ConnectivityResult.mobile ||
      connectivityResult == ConnectivityResult.wifi;
}

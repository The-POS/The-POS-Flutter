// ignore_for_file: avoid_void_async

import 'package:connectivity/connectivity.dart';
import 'package:faker_dart/faker_dart.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:thepos/core/preferences_utils.dart';
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

import 'config.dart';

late Box<Product> productsBox;
late Box<Category> categoriesBox;
final faker = Faker.instance;

Future<void> init() async {
  await Hive.initFlutter();
  setupGetIt();
  Hive.registerAdapter(ProductAdapter());
  productsBox = await Hive.openBox<Product>('productsBox');
  categoriesBox = await Hive.openBox<Category>('categoriesBox');
  setupGetIt();
  // Get.create(()=>HomeController());
  await PreferenceUtils.init();
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

  final Uri uri = Uri.https(domain, '$mainUrl/api/v1/sales-invoices');

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

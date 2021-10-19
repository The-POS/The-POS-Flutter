// ignore_for_file: avoid_void_async

import 'package:faker_dart/faker_dart.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:thepos/features/home/controllers/home_controller.dart';
import 'package:thepos/features/home/data/datasources/home_faker_data_source.dart';
import 'package:thepos/features/home/data/datasources/home_local_data_source.dart';
import 'package:thepos/features/home/data/datasources/home_remote_data_source.dart';
import 'package:thepos/features/home/data/models/product.dart';
import 'package:thepos/features/home/data/repositories/home_repository.dart';

late Box<Product> productsBox;
final faker = Faker.instance;

void init() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ProductAdapter());
  productsBox = await Hive.openBox<Product>('productsBox');
  setupGetIt();

  // Get.create(()=>HomeController());
}

final getIt = GetIt.instance;

void setupGetIt() {
  //dataSorces
  getIt.registerSingleton<HomeLocalDataSource>(HomeLocalDataSource());
  getIt.registerSingleton<HomeRemoteDataSource>(HomeRemoteDataSource());
  getIt.registerSingleton<HomeFakerDataSource>(HomeFakerDataSource());

//Repositorise
  getIt.registerSingleton<HomeRepository>(HomeRepository(
      localDataSource: getIt(),
      remoteDataSource: getIt(),
      fakerDataSource: getIt()));
}

// ignore_for_file: avoid_void_async

import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:thepos/features/home/data/datasources/home_local_data_source.dart';
import 'package:thepos/features/home/data/datasources/home_remote_data_source.dart';
import 'package:thepos/features/home/data/models/product.dart';
import 'package:thepos/features/home/data/repositories/home_repository.dart';

late Box<Product> productsBox;
void init() async {
  Hive.registerAdapter(ProductAdapter());
  productsBox = await Hive.openBox<Product>('productsBox');
  setupGetIt();
}

final getIt = GetIt.instance;

void setupGetIt() {

  //dataSorces
  getIt.registerSingleton<HomeLocalDataSource>(HomeLocalDataSource());
  getIt.registerSingleton<HomeRemoteDataSource>(HomeRemoteDataSource());


//Repositorise
  getIt.registerSingleton<HomeRepository>(HomeRepository(localDataSource: getIt(),remoteDataSource: getIt()));
}

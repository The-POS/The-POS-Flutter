import 'package:connectivity/connectivity.dart';
import 'package:thepos/core/config.dart';
import 'package:thepos/features/home/data/datasources/home_faker_data_source.dart';
import 'package:thepos/features/home/data/datasources/home_local_data_source.dart';
import 'package:thepos/features/home/data/datasources/home_remote_data_source.dart';
import 'package:thepos/features/home/data/models/category.dart';
import 'package:thepos/features/home/data/models/product.dart';

class HomeRepository {
  HomeRepository(
      {required this.fakerDataSource,
      required this.remoteDataSource,
      required this.localDataSource});

  final HomeRemoteDataSource remoteDataSource;
  final HomeLocalDataSource localDataSource;
  final HomeFakerDataSource fakerDataSource;

  Future<List<Product>> getProducts() async {
    if (enableFaker) {
      return fakerDataSource.getProducts();
    }
    final List<Product> products = await localDataSource.getProducts();
    if (products.isNotEmpty) {
      return products;
    } else {
      final List<Product> products = await remoteDataSource.getProducts();
      localDataSource.insertProducts(products);
      return products;
    }
  }

  Future<List<Product>> getProductsByGroupId(int groupId) async {
    final List<Product> products =
        await localDataSource.getProductsByGroupId(groupId);
    if (products.isNotEmpty) {
      return products;
    } else {
      final List<Product> products =
          await remoteDataSource.getProductsByGroupId(groupId);
      localDataSource.insertProducts(products);
      return products;
    }
  }

  Future<List<Category>> getProductsCategories() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) {
      return localDataSource.getProductsCategories();
    } else {
      return remoteDataSource.getProductsCategories();
    }
  }
}

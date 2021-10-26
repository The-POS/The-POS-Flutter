import 'package:connectivity/connectivity.dart';
import 'package:thepos/core/config.dart';
import 'package:thepos/features/home/data/datasources/home_faker_data_source.dart';
import 'package:thepos/features/home/data/datasources/home_local_data_source.dart';
import 'package:thepos/features/home/data/datasources/home_remote_data_source.dart';
import 'package:thepos/features/home/data/models/product.dart';

class HomeRepository {
  final HomeRemoteDataSource remoteDataSource;
  final HomeLocalDataSource localDataSource;
  final HomeFakerDataSource fakerDataSource;

  HomeRepository(
      {required this.fakerDataSource,
      required this.remoteDataSource,
      required this.localDataSource});

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
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) {
      return localDataSource.getProductsByGroupId(groupId);
    } else {
      return remoteDataSource.getProductsByGroupId(groupId);
    }
  }
}

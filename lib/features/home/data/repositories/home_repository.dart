// import 'package:dartz/dartz.dart';
// import 'package:famcare/core/errors/exceptions.dart';
// import 'package:famcare/core/errors/failures.dart';
// import 'package:famcare/core/models/list_response.dart';
// import 'package:famcare/core/models/single_m_response.dart';
// import 'package:famcare/core/models/single_response.dart';
// import 'package:famcare/core/models/success_response.dart';
// import 'package:famcare/features/auth/data/datasources/auth_local_data_source.dart';
// import 'package:famcare/features/auth/data/datasources/auth_remote_data_source.dart';
// import 'package:famcare/features/auth/data/models/country.dart';
// import 'package:famcare/features/auth/data/models/user.dart';
// import 'package:famcare/features/auth/data/models/user_meta.dart';
// import 'package:famcare/features/chats/data/repositories/chat_repository.dart';
// import 'package:famcare/features/features_user/bloc/features_bloc.dart';
// import 'package:famcare/features/features_user/data/feature.dart';
// import 'package:famcare/features/home_specialist/data/notes.dart';
// import 'package:famcare/features/profile/data/models/city.dart';
// import 'package:famcare/features/profile/data/models/profile_meta.dart';
// import 'package:famcare/injection_container.dart';
// import 'package:famcare/integrations/app_events.dart';
// import 'package:famcare/integrations/crashlytics.dart';
// import 'package:famcare/integrations/integrations.dart';
// import 'package:shared_preferences/shared_preferences.dart';

import 'package:connectivity/connectivity.dart';
import 'package:thepos/features/home/data/datasources/home_local_data_source.dart';
import 'package:thepos/features/home/data/datasources/home_remote_data_source.dart';
import 'package:thepos/features/home/data/models/product.dart';

class HomeRepository {
  final HomeRemoteDataSource remoteDataSource;
  final HomeLocalDataSource localDataSource;

  HomeRepository(
      {required this.remoteDataSource, required this.localDataSource});

  Future<List<Product>> getProducts() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) {
      return localDataSource.getProducts();
    } else {
      return remoteDataSource.getProducts();
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

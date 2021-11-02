import 'package:flutter_test/flutter_test.dart';
import 'package:thepos/features/products/product_cache_policy.dart';


void main() {
  ProductCachePolicy makeSUT(
      {required int timeIntervalInHours, required int cacheTimeOffset}) {
    final Duration duration =
        Duration(hours: timeIntervalInHours + cacheTimeOffset);

    final DateTime cacheTime = DateTime.now().subtract(duration);

    return ProductCachePolicy(timeIntervalInHours, cacheTime);
  }

  test('products cache expired on specific time interval', () {
    final ProductCachePolicy sut =
        makeSUT(timeIntervalInHours: 24, cacheTimeOffset: 0);

    final bool isExpired = sut.isExpired(currentDateTime: DateTime.now());

    expect(isExpired, true);
  });

  test('products cache expired after specific time interval', () {
    final ProductCachePolicy sut =
        makeSUT(timeIntervalInHours: 24, cacheTimeOffset: 1);

    final bool isExpired = sut.isExpired(currentDateTime: DateTime.now());

    expect(isExpired, true);
  });

  test('products cache does not expired before a specific time interval', () {
    final ProductCachePolicy sut =
        makeSUT(timeIntervalInHours: 24, cacheTimeOffset: -1);

    final bool isExpired = sut.isExpired(currentDateTime: DateTime.now());

    expect(isExpired, false);
  });
}

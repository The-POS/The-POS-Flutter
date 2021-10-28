import 'package:flutter_test/flutter_test.dart';
import 'package:thepos/features/products_feature/product_cache_policy.dart';

void main() {
  test('products cache expired on specific time interval', () {
    const int timeIntervalInHours = 24;
    const Duration duration = Duration(hours: timeIntervalInHours);

    final DateTime cacheTime = DateTime.now().subtract(duration);

    final DateTime currentDateTime = DateTime.now();

    final ProductCachePolicy cachePolicy =
        ProductCachePolicy(timeIntervalInHours, cacheTime);
    final bool isExpired =
        cachePolicy.isExpired(currentDateTime: currentDateTime);

    expect(isExpired, true);
  });

  test('products cache expired after specific time interval', () {
    const int timeIntervalInHours = 24;
    const Duration duration = Duration(hours: timeIntervalInHours + 1);

    final DateTime cacheTime = DateTime.now().subtract(duration);

    final DateTime currentDateTime = DateTime.now();

    final ProductCachePolicy cachePolicy =
        ProductCachePolicy(timeIntervalInHours, cacheTime);
    final bool isExpired =
        cachePolicy.isExpired(currentDateTime: currentDateTime);

    expect(isExpired, true);
  });

  test('products cache does not expired before a specific time interval', () {
    const int timeIntervalInHours = 24;
    const Duration duration = Duration(hours: timeIntervalInHours - 1);

    final DateTime cacheTime = DateTime.now().subtract(duration);

    final DateTime currentDateTime = DateTime.now();

    final ProductCachePolicy cachePolicy =
        ProductCachePolicy(timeIntervalInHours, cacheTime);
    final bool isExpired =
        cachePolicy.isExpired(currentDateTime: currentDateTime);

    expect(isExpired, false);
  });
}

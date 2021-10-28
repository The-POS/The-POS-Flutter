import 'package:flutter_test/flutter_test.dart';

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
}

class ProductCachePolicy {
  ProductCachePolicy(this.timeIntervalInHours, this.cacheDateTime);

  final int timeIntervalInHours;
  final DateTime cacheDateTime;

  bool isExpired({required DateTime currentDateTime}) {
    return currentDateTime.difference(currentDateTime).inHours <
        timeIntervalInHours;
  }
}

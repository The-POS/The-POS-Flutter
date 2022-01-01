class CustomerCachePolicy {
  CustomerCachePolicy(this.timeIntervalInHours, this.cacheDateTime);

  final int timeIntervalInHours;
  final DateTime cacheDateTime;

  bool isExpired({required DateTime currentDateTime}) =>
      currentDateTime.difference(cacheDateTime).inHours >= timeIntervalInHours;
}

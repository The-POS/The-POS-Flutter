import 'package:flutter_test/flutter_test.dart';

import 'navigator_factory_spy.dart';

void expectRoutes(List<Route> actual, List<Route> matcher) {
  expect(
    actual.length,
    matcher.length,
    reason: 'actual routes length ${actual.length} does not'
        ' equal mather routes length ${matcher.length}',
  );
  for (int i = 0; i <= actual.length - 1; i++) {
    expectRoute(actual[i], matcher[i]);
  }
}

void expectRoute(Route actual, Route matcher) {
  expect(
    actual.type,
    matcher.type,
    reason: 'actual route type ${actual.type} does not'
        ' equal matcher route type ${matcher.type}',
  );
  expect(
    actual.name,
    matcher.name,
    reason: 'actual route name ${actual.name} does not'
        ' equal matcher route name ${matcher.name}',
  );
  expect(
    actual.details,
    matcher.details,
    reason: 'actual route details ${actual.details} does not'
        ' equal matcher route details ${matcher.details}',
  );
}

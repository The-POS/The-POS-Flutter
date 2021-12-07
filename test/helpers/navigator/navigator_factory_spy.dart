import 'package:thepos/core/navigator/navigator_factory.dart';

enum NavigationType { offAndToNamed }

class Route {
  Route({required this.type, required this.name});

  final NavigationType type;
  final String name;
}

class NavigatorFactorySpy extends NavigatorFactory {
  List<Route> capturedRoutes = <Route>[];

  @override
  void offAndToNamed(String routeName) {
    capturedRoutes.add(Route(
      type: NavigationType.offAndToNamed,
      name: routeName,
    ));
  }
}

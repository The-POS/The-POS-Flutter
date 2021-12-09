import 'package:thepos/core/navigator/navigator_factory.dart';

enum NavigationType { offAndToNamed, showSnackBar }

class Route {
  Route({required this.type, this.name, this.details});

  final NavigationType type;
  final String? name;
  final String? details;
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

  @override
  void snackbar(String title, String message,
      {Duration animationDuration = const Duration(seconds: 1)}) {
    capturedRoutes.add(Route(
      type: NavigationType.showSnackBar,
      details: title + message,
    ));
  }
}

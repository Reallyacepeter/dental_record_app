/// lib/debug_route_logger.dart
import 'package:flutter/material.dart';

class RouteLogger extends NavigatorObserver {
  void _p(String msg) => debugPrint('[NAV] $msg');

  @override
  void didPush(Route route, Route? previousRoute) {
    _p('PUSH: ${previousRoute?.settings.name} -> ${route.settings.name}');
    super.didPush(route, previousRoute);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    _p('REPLACE: ${oldRoute?.settings.name} -> ${newRoute?.settings.name}');
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    _p('POP: ${route.settings.name} -> ${previousRoute?.settings.name}');
    super.didPop(route, previousRoute);
  }
}

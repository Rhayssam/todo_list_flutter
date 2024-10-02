import 'package:flutter/widgets.dart';

class TodoListNavigator {
  TodoListNavigator._();

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static NavigatorState get to => navigatorKey.currentState!;
}

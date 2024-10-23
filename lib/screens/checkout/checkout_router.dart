import 'package:childcaresoftware/screens/checkout/checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:childcaresoftware/screens/screens.dart';

class CheckOutRouter extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static const String CHECKOUT_SCREEN = 'checkout_screen';

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      initialRoute: CHECKOUT_SCREEN,
      onGenerateRoute: (RouteSettings settings) {
        Widget screen;

        switch (settings.name) {
          case CHECKOUT_SCREEN:
            screen = CheckOutScreen();
            break;
          default:
            throw Exception('Route not found');
        }

        return MaterialPageRoute(builder: (context) => screen);
      },
    );
  }
}

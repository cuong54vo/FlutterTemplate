import 'package:flutter/material.dart';
import 'package:childcaresoftware/screens/screens.dart';

class AddPaymentMethodRouter extends StatelessWidget {
  final navigatorKey = GlobalKey<NavigatorState>();
  static const String ADD_PAYMENT_METHOD_SCREEN = 'add_payment_method_screen';

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      initialRoute: ADD_PAYMENT_METHOD_SCREEN,
      onGenerateRoute: (RouteSettings settings) {
        Widget _screen;

        switch (settings.name) {
          case ADD_PAYMENT_METHOD_SCREEN:
            _screen = AddPaymentMethodScreen();
            break;
          default:
            _screen = Scaffold(
              body: Center(child: Text('No route defined for ${settings.name}')),
            );
        }

        return MaterialPageRoute(builder: (context) => _screen);
      },
    );
  }
}

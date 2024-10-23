import 'package:flutter/material.dart';
import 'package:childcaresoftware/screens/screens.dart';

class CheckInRouter extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static const String checkInScreen = 'checkin_screen';
  static const String checkOutScreen = 'checkout_screen';

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      initialRoute: checkInScreen,
      onGenerateRoute: (RouteSettings settings) {
        late Widget screen;

        switch (settings.name) {
          case checkInScreen:
            screen = CheckInScreen();
            break;
          case checkOutScreen:
            screen = CheckOutScreen();
            break;
          default:
            screen = Scaffold(
              body: Center(
                child: Text('404 Not Found'),
              ),
            );
        }

        return MaterialPageRoute(builder: (context) => screen);
      },
    );
  }
}

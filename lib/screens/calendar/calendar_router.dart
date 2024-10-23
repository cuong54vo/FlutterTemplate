import 'package:flutter/material.dart';
import 'package:childcaresoftware/screens/screens.dart';

class CalendarRouter extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static const String calendarScreen = 'calendar_screen';

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      initialRoute: calendarScreen,
      onGenerateRoute: (RouteSettings settings) {
        late Widget screen;

        switch (settings.name) {
          case calendarScreen:
            screen = CalendarScreen();
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

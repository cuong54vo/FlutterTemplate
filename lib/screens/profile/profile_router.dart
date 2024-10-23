import 'package:flutter/material.dart';
import 'package:childcaresoftware/screens/screens.dart';

class ProfileRouter extends StatelessWidget {
  final navigatorKey = GlobalKey<NavigatorState>();
  static const String PROFILE_SCREEN = 'profile_screen';

  @override
  Widget build(BuildContext context) {
    return Navigator(
        key: navigatorKey,
        initialRoute: PROFILE_SCREEN,
        onGenerateRoute: (profile) {
          Widget _screen;
          switch (profile.name) {
            case PROFILE_SCREEN:
              _screen = ProfileScreen();
              break;
            default:
              _screen = Scaffold(
              body: Center(
                child: Text('404 Not Found'),
              ),
            );
          }
          return MaterialPageRoute(builder: (context) => _screen);
        });
  }
}

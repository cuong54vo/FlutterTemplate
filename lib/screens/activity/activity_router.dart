import 'package:flutter/material.dart';
import 'package:childcaresoftware/screens/screens.dart';

class ActivityRouter extends StatelessWidget {
  static const String ACTIVITY_SCREEN = 'activity_screen';

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: ACTIVITY_SCREEN,
      onGenerateRoute: (RouteSettings settings) {
        Widget _screen;

        switch (settings.name) {
          case ACTIVITY_SCREEN:
            _screen = ActivityScreen();
            break;
          default:
            // Nếu không có route nào khớp, có thể trả về một màn hình mặc định hoặc một lỗi
            _screen = Scaffold(
              body: Center(child: Text('Không tìm thấy màn hình')),
            );
        }

        return MaterialPageRoute(builder: (context) => _screen);
      },
    );
  }
}

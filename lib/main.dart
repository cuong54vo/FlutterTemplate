import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:childcaresoftware/blocs/blocs.dart';
import 'package:childcaresoftware/constants/color.dart';
import 'package:childcaresoftware/router.dart';
import 'package:childcaresoftware/service_locator.dart';
import 'package:childcaresoftware/services/navigation_service.dart';
import 'package:childcaresoftware/simple_bloc_observer.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_analytics/firebase_analytics.dart';
// import 'package:firebase_analytics/observer.dart';
// import 'package:firebase_crashlytics/firebase_crashlytics.dart';

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  print("myBackgroundMessageHandler: $message");
  if (message.containsKey('data')) {
    final dynamic data = message['data'];
    // Handle data message
  }

  if (message.containsKey('notification')) {
    final dynamic notification = message['notification'];
    // Handle notification message
  }
  // Additional work can be done here if needed.
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initSystemDefault();
  setupLocator();
  
  // Uncomment when using Firebase
  // await Firebase.initializeApp();
  
  BlocOverrides.runZoned(
    () {
      runApp(MyApp());
    },
    blocObserver: SimpleBlocObserver(),
  );

  // Uncomment when using Firebase Crashlytics
  // if (kDebugMode) {
  //   await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
  // } else {
  //   await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  // }
  // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
}

void initSystemDefault() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarBrightness: Brightness.light),
  );
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState? get _navigator => locator<NavigationService>().navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationBloc()..add(AppStarted()),
      child: MaterialApp(
        title: 'ChildCareSoftware',
        navigatorKey: locator<NavigationService>().navigatorKey,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: AppBarTheme(
            color: Theme.of(context).scaffoldBackgroundColor,
            iconTheme: IconThemeData(color: AppColors.PRIMARY),
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        builder: (context, child) {
          return BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              if (state is Uninitialized) {
                _navigator?.pushNamedAndRemoveUntil(AppRouter.SPLASH, (route) => false);
              } else if (state is Unauthenticated) {
                if (state.isFirstTime) {
                  _navigator?.pushNamedAndRemoveUntil(AppRouter.ONBOARDING, (route) => false);
                } else {
                  _navigator?.pushNamedAndRemoveUntil(AppRouter.LOGIN, (route) => false);
                }
              } else if (state is Authenticated) {
                _navigator?.pushNamedAndRemoveUntil(AppRouter.HOME, (route) => false);
              }
            },
            child: child,
          );
        },
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}

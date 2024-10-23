import 'package:flutter/material.dart';
import 'package:childcaresoftware/screens/screens.dart';

class AppRouter {
  static const String HOME = 'home';
  static const String SPLASH = '/';
  static const String LOGIN = 'login';
  static const String ONBOARDING = 'introduction';
  static const String REGISTER = 'register';
  static const String FORGOT_PASSWORD = 'forgot_password';
  static const String VERIFY_CODE = 'verify_code';
  static const String NEW_PASSWORD = 'new_password';
  static const String PASSWORD_RESET_SUCCESS = 'password_reset_success';
  static const String ACTIVATE_VERIFY_CODE = 'activate_verify_code';
  static const String PROFILE = 'profile';
  static const String CHANGE_PASSWORD = 'change_password';
  static const String JOBS_DETAIL = 'jobs_detail';
  static const String PRODUCT_SEARCH = 'product_search';
  static const String BILLING = 'billing';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    Widget? screen;

    switch (settings.name) {
      case SPLASH:
        screen = SplashScreen();
        break;
      case ONBOARDING:
        screen = OnBoardingScreen();
        break;
      case LOGIN:
        screen = LoginScreen();
        break;
      case HOME:
        screen = HomeScreen();
        break;
      case REGISTER:
        screen = RegisterScreen();
        break;
      case FORGOT_PASSWORD:
        screen = ForgotPasswordScreen();
        break;
      case VERIFY_CODE:
        final VerifyCodeScreenArguments args = settings.arguments as VerifyCodeScreenArguments;
        screen = VerifyCodeScreen(email: args.email);
        break;
      case NEW_PASSWORD:
        final NewPasswordScreenArguments args = settings.arguments as NewPasswordScreenArguments;
        screen = NewPasswordScreen(email: args.email);
        break;
      case PASSWORD_RESET_SUCCESS:
        screen = PasswordResetSuccessScreen();
        break;
      case ACTIVATE_VERIFY_CODE:
        final String email = settings.arguments as String;
        screen = ActivateVerifyCodeScreen(email: email);
        break;
      case PROFILE:
        screen = ProfileScreen();
        break;
      case CHANGE_PASSWORD:
        screen = ChangePasswordScreen();
        break;
      case BILLING:
        screen = BillingScreen();
        break;
      default:
        screen = null; // Or handle unknown route
    }

    return MaterialPageRoute(
      builder: (context) => screen ?? const UnknownScreen(), // Handle null screen
    );
  }
}

// Define an UnknownScreen for handling unknown routes
class UnknownScreen extends StatelessWidget {
  const UnknownScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Unknown Route')),
      body: const Center(child: Text('404: Page Not Found')),
    );
  }
}

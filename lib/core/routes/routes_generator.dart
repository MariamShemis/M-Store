import 'package:flutter/cupertino.dart';
import 'package:m_store_1/core/routes/app_routes.dart';
import 'package:m_store_1/feature/auth/presentation/view/login_screen.dart';
import 'package:m_store_1/feature/splash_screen/splash_screen.dart';

abstract class RoutesGenerator {
  static Route? router(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splashScreen:
        {
          return CupertinoPageRoute(builder: (context) => SplashScreen());
        }
        case AppRoutes.login:
        {
          return CupertinoPageRoute(builder: (context) => LoginScreen());
        }

    }

    return null;
  }
}

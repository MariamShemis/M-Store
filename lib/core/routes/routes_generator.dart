import 'package:flutter/cupertino.dart';
import 'package:m_store_1/core/routes/app_routes.dart';
import 'package:m_store_1/feature/add_product/presentation/view/add_product.dart';
import 'package:m_store_1/feature/auth/presentation/view/forget_password.dart';
import 'package:m_store_1/feature/auth/presentation/view/login_screen.dart';
import 'package:m_store_1/feature/auth/presentation/view/register_screen.dart';
import 'package:m_store_1/feature/edit_profile/presentation/view/edit_profile.dart';
import 'package:m_store_1/feature/language/presentation/view/language_profile.dart';
import 'package:m_store_1/feature/main_layout/main_layout.dart';
import 'package:m_store_1/feature/main_layout/products/data/model/product_model.dart';
import 'package:m_store_1/feature/product_details/presentation/view/product_details.dart';
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
      case AppRoutes.register:
        {
          return CupertinoPageRoute(builder: (context) => RegisterScreen());
        }
      case AppRoutes.forgetPassword:
        {
          return CupertinoPageRoute(builder: (context) => ForgetPassword());
        }
      case AppRoutes.mainLayout:
        {
          return CupertinoPageRoute(builder: (context) => MainLayout());
        }
      case AppRoutes.addProduct:
        {
          return CupertinoPageRoute(builder: (context) => AddProduct());
        }
      case AppRoutes.editProfile:
        {
          return CupertinoPageRoute(builder: (context) => EditProfile());
        }
      case AppRoutes.language:
        {
          return CupertinoPageRoute(builder: (context) => LanguageProfile());
        }

      case AppRoutes.productDetails:
        {
          final product = settings.arguments as ProductModel;
          return CupertinoPageRoute(
            builder: (context) => ProductDetails(product: product),
          );
        }
    }
    return null;
  }
}

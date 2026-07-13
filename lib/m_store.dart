import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:m_store_1/core/routes/app_routes.dart';
import 'package:m_store_1/core/routes/routes_generator.dart';
import 'package:m_store_1/core/theme/theme_manager.dart';
import 'package:m_store_1/l10n/app_localizations.dart';

class MStore extends StatelessWidget {
  const MStore({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 882),
      splitScreenMode: true,
      minTextAdapt: true,
      builder:(context, child) =>  MaterialApp(
        title: "M Store",
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RoutesGenerator.router,
        initialRoute: AppRoutes.splashScreen,
        theme: ThemeManager.lightTheme,
        themeMode: ThemeMode.light,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: Locale("en"),
      ),
    );
  }
}

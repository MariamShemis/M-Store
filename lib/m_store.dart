import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:m_store_1/core/routes/app_routes.dart';
import 'package:m_store_1/core/routes/routes_generator.dart';
import 'package:m_store_1/core/theme/theme_manager.dart';
import 'package:m_store_1/feature/language/data/cubit/language_cubit.dart';
import 'package:m_store_1/feature/language/data/cubit/language_state.dart';
import 'package:m_store_1/l10n/app_localizations.dart';

class MStore extends StatelessWidget {
  const MStore({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 882),
      splitScreenMode: true,
      minTextAdapt: true,
      builder: (context, child) =>
          BlocBuilder<LanguageCubit, LanguageState>(
            builder: (context, state) {
              return MaterialApp(
                title: "M Store",
                debugShowCheckedModeBanner: false,
                onGenerateRoute: RoutesGenerator.router,
                initialRoute: AppRoutes.splashScreen,
                theme: ThemeManager.lightTheme,
                themeMode: ThemeMode.light,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                locale: state.locale,
              );
            },
          ),
    );
  }
}

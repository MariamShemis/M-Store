import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m_store_1/core/costants/color_manager.dart';
import 'package:m_store_1/feature/main_layout/home/presentation/view/home_tab.dart';
import 'package:m_store_1/feature/main_layout/products/presentation/view/products_tab.dart';
import 'package:m_store_1/feature/main_layout/profile/presentation/view/profile_tab.dart';
import 'package:m_store_1/feature/main_layout/sales/presentation/view/sales_tab.dart';
import 'package:m_store_1/l10n/app_localizations.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeTab(),
    ProductsTab(),
    SalesTab(),
    ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
            navigationBarTheme: NavigationBarThemeData(
              backgroundColor: ColorManager.white,
              elevation: 10,
              indicatorColor: const Color(0xFFFAF3E0),
              indicatorShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.r),
              ),
              labelTextStyle: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return GoogleFonts.inter(
                    color: ColorManager.mediumGold,
                    fontWeight: FontWeight.bold,
                    fontSize: 13.sp,
                  );
                }
                return GoogleFonts.inter(
                  color: ColorManager.brownDark,
                  fontWeight: FontWeight.w500,
                  fontSize: 12.sp,
                );
              }),
              iconTheme: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return IconThemeData(
                    color: ColorManager.mediumGold,
                    size: 26.r,
                  );
                }
                return IconThemeData(color: ColorManager.brownDark, size: 24.r);
              }),
            ),
          ),
          child: NavigationBar(
            height: 80.h,
            selectedIndex: _currentIndex,
            onDestinationSelected: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            destinations: [
              NavigationDestination(
                icon: Icon(
                  _currentIndex == 0 ? Icons.home_filled : Icons.home_outlined,
                ),
                label: appLocalizations.home.toUpperCase(),
              ),
              NavigationDestination(
                icon: Icon(
                  _currentIndex == 1
                      ? Icons.archive_rounded
                      : Icons.archive_outlined,
                ),
                label: appLocalizations.products.toUpperCase(),
              ),
              NavigationDestination(
                icon: Icon(
                  _currentIndex == 2
                      ? Icons.payments_rounded
                      : Icons.payments_outlined,
                ),
                label: appLocalizations.sales.toUpperCase(),
              ),
              NavigationDestination(
                icon: Icon(
                  _currentIndex == 3 ? Icons.person : Icons.person_outline,
                ),
                label: appLocalizations.profile.toUpperCase(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

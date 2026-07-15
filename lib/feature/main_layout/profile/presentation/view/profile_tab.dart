import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m_store_1/core/costants/color_manager.dart';
import 'package:m_store_1/feature/main_layout/profile/presentation/widgets/profile_header.dart';
import 'package:m_store_1/feature/main_layout/profile/presentation/widgets/profile_menu_item.dart';
import 'package:m_store_1/l10n/app_localizations.dart';

import '../widgets/profile_statistic_card.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: REdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ProfileHeader(
                name: "Julianne Moretti",
                job: "mero@gmail.com",
                phoneNumber: "0102125454",
                image: CircleAvatar(
                  radius: 40.r,
                  backgroundColor: ColorManager.primaryColor.withOpacity(0.6),
                  child: Icon(
                    Icons.person,
                    size: 35.sp,
                    color: ColorManager.white,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 14.w,
                mainAxisSpacing: 14.h,
                mainAxisExtent: height * 0.16,
                children: [
                  ProfileStatisticCard(
                    title: appLocalizations.inStock,
                    value: "156",
                    icon: Icons.check_circle_outline,
                  ),
                  ProfileStatisticCard(
                    title: appLocalizations.revenue,
                    value: "\$4.2k",
                    icon: Icons.attach_money,
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Text(
                appLocalizations.general_settings.toUpperCase(),
                style: GoogleFonts.inter(
                  color: ColorManager.greyDark.withOpacity(0.5),
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.8,
                ),
              ),
              SizedBox(height: 8.h),
              Container(
                decoration: BoxDecoration(
                  color: ColorManager.white,
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.015),
                      blurRadius: 15,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    ProfileMenuTile(
                      icon: Icons.person_outline_outlined,
                      title: appLocalizations.editProfile,
                      onTap: () {},
                    ),
                    ProfileMenuTile(
                      icon: Icons.security_rounded,
                      title: appLocalizations.account_Security,
                      onTap: () {},
                    ),
                    ProfileMenuTile(
                      icon: Icons.language_rounded,
                      title: appLocalizations.language,
                      trailingText: 'English',
                      onTap: () {},
                      showDivider: false,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              SizedBox(
                width: double.infinity,
                height: 52.h,
                child: TextButton(
                  onPressed: () {
                    _showDialogLogOut(context);
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: ColorManager.red.withOpacity(0.1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.logout_rounded,
                        color: ColorManager.red,
                        size: 20.sp,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        appLocalizations.log_out,
                        style: GoogleFonts.inter(
                          color: ColorManager.red,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDialogLogOut(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: ColorManager.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          appLocalizations.log_out,
          style: GoogleFonts.inter(
            color: ColorManager.primaryColor,
            fontSize: 25.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          appLocalizations.are_you_sure_you_want_to_log_out,
          style: GoogleFonts.inter(
            color: ColorManager.blackText,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              appLocalizations.cancel,
              style: TextStyle(color: ColorManager.red),
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
            },
            child: Text(
              appLocalizations.ok,
              style: TextStyle(color: ColorManager.primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}

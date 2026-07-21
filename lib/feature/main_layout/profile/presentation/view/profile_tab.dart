import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m_store_1/core/costants/color_manager.dart';
import 'package:m_store_1/core/routes/app_routes.dart';
import 'package:m_store_1/feature/language/data/cubit/language_cubit.dart';
import 'package:m_store_1/feature/language/data/cubit/language_state.dart';
import 'package:m_store_1/feature/main_layout/profile/data/cubit/profile_cubit.dart';
import 'package:m_store_1/feature/main_layout/profile/data/cubit/profile_state.dart';
import 'package:m_store_1/feature/main_layout/profile/presentation/widgets/profile_header.dart';
import 'package:m_store_1/feature/main_layout/profile/presentation/widgets/profile_menu_item.dart';
import 'package:m_store_1/l10n/app_localizations.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is LogoutSuccessState) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.login,
            (route) => false,
          );
        }
      },
      builder: (context, state) {
        if (state is GetProfileLoadingState) {
          return Center(
            child: CircularProgressIndicator(color: ColorManager.primaryColor,),
          );
        }
        if (state is GetProfileErrorState) {
          return Center(
            child: Text(state.message),
          );
        }
        final cubit = ProfileCubit.get(context);
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              padding: REdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ProfileHeader(
                    name: cubit.currentUser?.name ?? "",
                    job: cubit.currentUser?.email ?? "",
                    phoneNumber: cubit.currentUser?.phone ?? "",
                    image: CircleAvatar(
                      radius: 40.r,
                      backgroundColor: ColorManager.primaryColor.withOpacity(.15),
                      backgroundImage: cubit.currentUser?.image != null &&
                          cubit.currentUser!.image!.isNotEmpty
                          ? NetworkImage(cubit.currentUser!.image!)
                          : null,
                      child: cubit.currentUser?.image == null ||
                          cubit.currentUser!.image!.isEmpty
                          ? Icon(
                        Icons.person,
                        size: 35.sp,
                        color: ColorManager.primaryColor,
                      )
                          : null,
                    ),
                  ),
                  SizedBox(height: 40.h),
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
                          onTap: () async {
                            final result = await Navigator.pushNamed(
                              context,
                              AppRoutes.editProfile,
                            );

                            if (result == true && context.mounted) {
                              ProfileCubit.get(context).loadProfile();
                            }
                          },
                        ),
                        ProfileMenuTile(
                          icon: Icons.security_rounded,
                          title: appLocalizations.account_Security,
                          onTap: () {},
                        ),
                        BlocBuilder<LanguageCubit, LanguageState>(
                          builder: (context, state) {
                            return ProfileMenuTile(
                              icon: Icons.language_rounded,
                              title: appLocalizations.language,
                              trailingText:
                              state.locale.languageCode == 'ar'
                                  ? 'العربية'
                                  : 'English',
                              onTap: () {
                                Navigator.pushNamed(context, AppRoutes.language);
                              },
                              showDivider: false,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40.h),
                  SizedBox(
                    width: double.infinity,
                    height: 50.h,
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
      },
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

              ProfileCubit.get(context).logout();
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

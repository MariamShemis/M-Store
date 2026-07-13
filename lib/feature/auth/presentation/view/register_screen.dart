import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m_store_1/core/costants/assets_manager.dart';
import 'package:m_store_1/core/costants/color_manager.dart';
import 'package:m_store_1/core/widget/custom_auth_text_form_field.dart';
import 'package:m_store_1/l10n/app_localizations.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    fullNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: ColorManager.blackText,
          ),
        ),
        title: Text(
          appLocalizations.sign_up,
          style: GoogleFonts.playfairDisplay(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: ColorManager.blackText,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: REdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: 80.w,
                  height: 80.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(2.r),
                    child: Image.asset(ImageAssets.logoApp),
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  "M STORE",
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3,
                    color: ColorManager.blackText,
                  ),
                ),
                SizedBox(height: 25.h),
                Container(
                  padding: EdgeInsets.all(22.r),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 18,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          appLocalizations.createAccount,
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          appLocalizations
                              .join_MSTORE_and_simplify_the_way_you_organize_your_products_and_manage_your_inventory,
                          style: GoogleFonts.inter(
                            fontSize: 15.sp,
                            color: ColorManager.secondary,
                          ),
                        ),
                        SizedBox(height: 24.h),
                        CustomAuthTextFormField(
                          controller: fullNameController,
                          labelText: appLocalizations.name,
                          hintText: appLocalizations.enterYourName,
                        ),
                        SizedBox(height: 18.h),
                        CustomAuthTextFormField(
                          controller: emailController,
                          labelText: appLocalizations.email,
                          hintText: appLocalizations.enterYourEmail,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: 18.h),
                        CustomAuthTextFormField(
                          controller: phoneController,
                          labelText: appLocalizations.phoneNumber,
                          hintText: appLocalizations.enterYourPhone,
                          keyboardType: TextInputType.phone,
                        ),
                        SizedBox(height: 18.h),
                        CustomAuthTextFormField(
                          controller: passwordController,
                          labelText: appLocalizations.password,
                          hintText: "••••••••",
                          isPassword: true,
                        ),

                        SizedBox(height: 18.h),

                        CustomAuthTextFormField(
                          controller: confirmPasswordController,
                          labelText: appLocalizations.confirmPassword,
                          hintText: "••••••••",
                          isPassword: true,
                        ),
                        SizedBox(height: 22.h),

                        SizedBox(
                          width: double.infinity,
                          height: 46.h,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              appLocalizations.createAccount.toUpperCase(),
                            ),
                          ),
                        ),

                        SizedBox(height: 24.h),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${appLocalizations.alreadyHaveAccount} ",
                              style: TextStyle(
                                color: ColorManager.greyDark,
                                fontSize: 14.sp,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                appLocalizations.signIn,
                                style: TextStyle(
                                  color: ColorManager.primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

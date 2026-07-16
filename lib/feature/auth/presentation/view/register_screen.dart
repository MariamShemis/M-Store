import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m_store_1/core/costants/assets_manager.dart';
import 'package:m_store_1/core/costants/color_manager.dart';
import 'package:m_store_1/core/utils/ui_utils.dart';
import 'package:m_store_1/core/utils/validators/app_validators.dart';
import 'package:m_store_1/core/widget/custom_auth_text_form_field.dart';
import 'package:m_store_1/core/widget/logo_app.dart';
import 'package:m_store_1/feature/auth/data/cubit/auth_cubit.dart';
import 'package:m_store_1/feature/auth/data/cubit/auth_state.dart';
import 'package:m_store_1/feature/auth/data/model/register_request.dart';
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
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is RegisterLoadingState) {
          UiUtils.showLoading(context, isDismissible: false);
        }
        if (state is RegisterSuccessState) {
          UiUtils.hideLoading(context);
          UiUtils.showToast("Account created successfully.");
          Navigator.pop(context);
        }
        if (state is RegisterErrorState) {
          UiUtils.hideLoading(context);
          UiUtils.showError(context, state.message);
        }
      },
      builder: (context, state) {
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
              padding: REdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 10.h),
                      LogoApp(),
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
                              validator: (value) =>
                                  AppValidators.validateName(value, context),
                            ),
                            SizedBox(height: 18.h),
                            CustomAuthTextFormField(
                              controller: emailController,
                              labelText: appLocalizations.email,
                              hintText: appLocalizations.enterYourEmail,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) =>
                                  AppValidators.validateEmail(value, context),
                            ),
                            SizedBox(height: 18.h),
                            CustomAuthTextFormField(
                              controller: phoneController,
                              labelText: appLocalizations.phoneNumber,
                              hintText: appLocalizations.enterYourPhone,
                              keyboardType: TextInputType.phone,
                              validator: (value) =>
                                  AppValidators.validatePhone(value, context),
                            ),
                            SizedBox(height: 18.h),
                            CustomAuthTextFormField(
                              controller: passwordController,
                              labelText: appLocalizations.password,
                              hintText: "••••••••",
                              isPassword: true,
                              validator: (value) =>
                                  AppValidators.validatePassword(
                                    value,
                                    context,
                                  ),
                            ),
                            SizedBox(height: 18.h),
                            CustomAuthTextFormField(
                              controller: confirmPasswordController,
                              labelText: appLocalizations.confirmPassword,
                              hintText: "••••••••",
                              isPassword: true,
                              validator: (value) =>
                                  AppValidators.validateConfirmPassword(
                                    value,
                                    passwordController.text,
                                    context,
                                  ),
                            ),
                            SizedBox(height: 22.h),
                            SizedBox(
                              width: double.infinity,
                              height: 46.h,
                              child: ElevatedButton(
                                onPressed: _register,
                                child: Text(
                                  appLocalizations.createAccount
                                      .toUpperCase(),
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
                                  onTap: (){
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

                      SizedBox(height: 30.h),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _register() {
    if (_formKey.currentState!.validate()) {
      AuthCubit.get(context).register(
        RegisterRequest(
          name: fullNameController.text.trim(),
          email: emailController.text.trim(),
          phone: phoneController.text.trim(),
          password: passwordController.text.trim(),
        ),
      );
    }
  }
}

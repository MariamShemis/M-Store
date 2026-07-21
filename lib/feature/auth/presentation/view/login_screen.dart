import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m_store_1/core/costants/color_manager.dart';
import 'package:m_store_1/core/routes/app_routes.dart';
import 'package:m_store_1/core/utils/ui_utils.dart';
import 'package:m_store_1/core/utils/validators/app_validators.dart';
import 'package:m_store_1/core/widget/custom_auth_text_form_field.dart';
import 'package:m_store_1/core/widget/logo_app.dart';
import 'package:m_store_1/feature/auth/data/cubit/auth_cubit.dart';
import 'package:m_store_1/feature/auth/data/cubit/auth_state.dart';
import 'package:m_store_1/feature/auth/data/model/login_request.dart';
import 'package:m_store_1/feature/auth/presentation/widgets/custom_login_outline_border.dart';
import 'package:m_store_1/l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginLoadingState) {
          UiUtils.showLoading(context, isDismissible: false);
        }
        if (state is LoginSuccessState) {
          UiUtils.hideLoading(context);
          UiUtils.showToast(
            "${appLocalizations.welcome_} ${state.user.name}, ${appLocalizations.login_successfully}.",
          );
          Navigator.pushReplacementNamed(context, AppRoutes.mainLayout);
        }
        if (state is LoginErrorState) {
          UiUtils.hideLoading(context);
          UiUtils.showError(context, state.message);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 5,
            title: Text(
              appLocalizations.login,
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
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 10.h),
                      LogoApp(),
                      SizedBox(height: 25.h),
                      Container(
                        padding: EdgeInsets.all(22.r),
                        margin: EdgeInsets.all(5.r),
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
                              appLocalizations.signIn,
                              style: GoogleFonts.playfairDisplay(
                                fontSize: 30.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            SizedBox(height: 8.h),

                            Text(
                              appLocalizations
                                  .welcome_back_Please_sign_in_to_access_your_collection,
                              style: GoogleFonts.inter(
                                color: ColorManager.secondary,
                                fontSize: 15.sp,
                              ),
                            ),

                            SizedBox(height: 25.h),
                            CustomAuthTextFormField(
                              controller: _emailController,
                              labelText: appLocalizations.email,
                              hintText: appLocalizations.enterYourEmail,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) =>
                                  AppValidators.validateEmail(value, context),
                            ),
                            SizedBox(height: 24),
                            CustomAuthTextFormField(
                              controller: _passwordController,
                              labelText: appLocalizations.password,
                              hintText: '••••••••',
                              isPassword: true,
                              validator: (value) =>
                                  AppValidators.validatePassword(
                                    value,
                                    context,
                                  ),
                            ),
                            SizedBox(height: 18.h),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.forgetPassword,
                                  );
                                },
                                child: Text(
                                  appLocalizations.forget_password_,
                                  style: GoogleFonts.inter(
                                    fontSize: 14.sp,
                                    color: ColorManager.primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 18.h),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: _login,
                                label: Text(
                                  appLocalizations.login.toUpperCase(),
                                ),
                              ),
                            ),
                            SizedBox(height: 24.h),
                            Row(
                              children: [
                                Expanded(
                                  child: Divider(
                                    color: Color(0xFFE5E9E7),
                                    thickness: 1,
                                  ),
                                ),
                                Padding(
                                  padding: REdgeInsets.symmetric(
                                    horizontal: 16.0,
                                  ),
                                  child: Text(
                                    appLocalizations.orContinueWith,
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.bold,
                                      color: ColorManager.greyDark,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Divider(
                                    color: Color(0xFFE5E9E7),
                                    thickness: 1,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 24.h),
                            CustomLoginOutlineBorder(
                              onPressed: () =>
                                  AuthCubit.get(context).loginWithGoogle,
                              isGoogleLogin: true,
                              isGoogle: false,
                            ),
                            SizedBox(height: 24.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${appLocalizations.dontHaveAnAccount}  ",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: ColorManager.greyDark,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      AppRoutes.register,
                                    );
                                  },
                                  child: Text(
                                    appLocalizations.register,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                      color: ColorManager.primaryColor,
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

  void _login() {
    if (_formKey.currentState!.validate()) {
      AuthCubit.get(context).login(
        LoginRequest(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        ),
        context,
      );
    }
  }
}

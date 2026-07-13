import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m_store_1/core/costants/assets_manager.dart';
import 'package:m_store_1/core/costants/color_manager.dart';
import 'package:m_store_1/core/utils/validators/app_validators.dart';
import 'package:m_store_1/core/widget/custom_auth_text_form_field.dart';
import 'package:m_store_1/l10n/app_localizations.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
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
          appLocalizations.forgetPassword,
          style: GoogleFonts.playfairDisplay(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: ColorManager.blackText,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: REdgeInsets.only(
            left: 24.0,
            right: 24,
            top: 10.0,
            bottom: 16.0,
          ),
          child: Form(
            child: Column(
              children: [
                Image.asset(
                  ImageAssets.forgetPassword,
                  height: 300.h,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 10.h),
                Container(
                  padding: REdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 32.0,
                  ),
                  decoration: BoxDecoration(
                    color: ColorManager.white,
                    borderRadius: BorderRadius.circular(28.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 20.r,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        appLocalizations.forget_password_,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      SizedBox(height: 8.h),
                      Padding(
                        padding: REdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          appLocalizations
                              .pleaseEnterYourEmailToReceiveAConfirmationCodeToSetANewPassword,
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(fontSize: 12.sp),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                        ),
                      ),
                      SizedBox(height: 24.h),
                      CustomAuthTextFormField(
                        controller: _emailController,
                        labelText: appLocalizations.email,
                        hintText: appLocalizations.enterYourEmail,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) =>
                            AppValidators.validateEmail(value, context),
                      ),
                      SizedBox(height: 24.h),
                      ElevatedButton(
                        onPressed: (){},
                        child: Text(appLocalizations.resetPassword),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

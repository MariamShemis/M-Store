import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:m_store_1/core/costants/color_manager.dart';
import 'package:m_store_1/core/utils/ui_utils.dart';
import 'package:m_store_1/feature/edit_profile/data/cubit/edit_profile_cubit.dart';
import 'package:m_store_1/feature/edit_profile/data/cubit/edit_profile_state.dart';
import 'package:m_store_1/feature/edit_profile/presentation/widget/custom_profile_field.dart';
import 'package:m_store_1/feature/edit_profile/presentation/widget/profile_brithday_field.dart';
import 'package:m_store_1/feature/edit_profile/presentation/widget/profile_gender_dropdown.dart';
import 'package:m_store_1/feature/main_layout/profile/data/cubit/profile_cubit.dart';
import 'package:m_store_1/feature/main_layout/profile/presentation/widgets/user_image_profile.dart';
import 'package:m_store_1/l10n/app_localizations.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _birthdayController = TextEditingController();
  final _passwordController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  String? _selectedGender;
  File? _profileImage;

  @override
  void initState() {
    super.initState();
    context.read<EditProfileCubit>().loadProfile();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _birthdayController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    Navigator.pop(context);

    final image = await _picker.pickImage(source: source, imageQuality: 80);

    if (image == null) return;

    setState(() {
      _profileImage = File(image.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.editProfile),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocConsumer<EditProfileCubit, EditProfileState>(
        listener: (context, state) {
          if (state is EditProfileSaving) {
            UiUtils.showLoading(context, isDismissible: false);
          }

          if (state is EditProfileLoaded) {
            final user = context.read<EditProfileCubit>().user!;

            _nameController.text = user.name;
            _emailController.text = user.email;
            _phoneController.text = user.phone;
            _birthdayController.text = user.birthday ?? "";
            _selectedGender = user.gender;

            setState(() {});
          }

          if (state is EditProfileSuccess) {
            UiUtils.hideLoading(context);
            UiUtils.showToast(appLocalizations.profileUpdatedSuccessfully);

            context.read<ProfileCubit>().loadProfile();

            Navigator.pop(context, true);
          }

          if (state is EditProfileError) {
            UiUtils.hideLoading(context);
            UiUtils.showError(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is EditProfileLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: ColorManager.primaryColor,
              ),
            );
          }

          final user = context.read<EditProfileCubit>().user;

          return SingleChildScrollView(
            padding: REdgeInsets.symmetric(horizontal:  20.r , vertical: 16),
            child: Column(
              children: [
                UserImageProfile(
                  image: CircleAvatar(
                    radius: 55.r,
                    backgroundColor: ColorManager.primaryColor20,
                    backgroundImage: _profileImage != null
                        ? FileImage(_profileImage!)
                        : user?.image != null && user!.image!.isNotEmpty
                        ? NetworkImage(user.image!)
                        : null,
                    child:
                        _profileImage == null &&
                            (user?.image == null || user!.image!.isEmpty)
                        ? Icon(
                            Icons.person,
                            size: 45.sp,
                            color: ColorManager.primaryColor,
                          )
                        : null,
                  ),
                  onTap: _showImagePicker,
                ),
                SizedBox(height: 12.h),

                CustomProfileField(
                  title: appLocalizations.name,
                  hintText: appLocalizations.enterYourName,
                  controller: _nameController,
                ),

                SizedBox(height: 20.h),

                CustomProfileField(
                  title: appLocalizations.email,
                  hintText: appLocalizations.enterYourEmail,
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                ),

                SizedBox(height: 20.h),

                CustomProfileField(
                  title: appLocalizations.phoneNumber,
                  hintText: appLocalizations.enterYourPhoneNumber,
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                ),

                SizedBox(height: 20.h),

                ProfileBirthdayField(controller: _birthdayController),

                SizedBox(height: 20.h),

                ProfileGenderDropdown(
                  selectedValue: _selectedGender,
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value;
                    });
                  },
                ),
                SizedBox(height: 40.h),
                SizedBox(
                  width: double.infinity,
                  height: 55.h,
                  child: ElevatedButton(
                    onPressed: _saveProfile,
                    child: Text(appLocalizations.save),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _saveProfile() async {
    final appLocalizations = AppLocalizations.of(context)!;
    final currentUser = context.read<EditProfileCubit>().user;

    if (currentUser == null) return;

    String password = "";

    if (_emailController.text.trim() != currentUser.email) {
      final provider = FirebaseAuth.instance.currentUser!
          .providerData
          .first
          .providerId;

      if (provider == "password") {
        final result = await showDialog<String>(
          context: context,
          builder: (context) {
            _passwordController.clear();

            return AlertDialog(
              title: Text(appLocalizations.confirmPassword),
              content: TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: appLocalizations.enter_your_password
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(appLocalizations.cancel),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                      _passwordController.text.trim(),
                    );
                  },
                  child: Text(appLocalizations.confirm),
                ),
              ],
            );
          },
        );

        if (result == null || result.isEmpty) return;

        password = result;
      }
    }

    context.read<EditProfileCubit>().updateProfile(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      phone: _phoneController.text.trim(),
      birthday: _birthdayController.text.trim(),
      gender: _selectedGender ?? "",
      image: _profileImage,
      password: password,
    );
  }

  void _showImagePicker() {
    final appLocalizations = AppLocalizations.of(context)!;

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) {
        return Padding(
          padding: EdgeInsets.all(24.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt_outlined),
                title: Text(appLocalizations.take_A_Photo),
                onTap: () => _pickImage(ImageSource.camera),
              ),
              ListTile(
                leading: const Icon(Icons.photo_library_outlined),
                title: Text(appLocalizations.chooseFromGallery),
                onTap: () => _pickImage(ImageSource.gallery),
              ),
            ],
          ),
        );
      },
    );
  }
}

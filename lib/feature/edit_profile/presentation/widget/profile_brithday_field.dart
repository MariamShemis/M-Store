import 'package:flutter/material.dart';
import 'package:m_store_1/feature/edit_profile/presentation/widget/custom_profile_field.dart';
import 'package:m_store_1/l10n/app_localizations.dart';

import '../../../../core/costants/color_manager.dart';

class ProfileBirthdayField extends StatelessWidget {
  final TextEditingController controller;

  const ProfileBirthdayField({super.key, required this.controller});

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: ColorManager.primaryColor,
              onPrimary: ColorManager.white,
              onSurface: ColorManager.blackText,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      controller.text =
      "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
    }
  }
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return CustomProfileField(
      title: appLocalizations.birthday.toUpperCase(),
      hintText: appLocalizations.select_your_birthday,
      controller: controller,
      readOnly: true,
      onTap: () => _selectDate(context),
    );
  }
}
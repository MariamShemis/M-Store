import 'package:flutter/material.dart';
import 'package:m_store_1/feature/edit_profile/presentation/widget/custom_profile_field.dart';
import 'package:m_store_1/l10n/app_localizations.dart';

class ProfileBirthdayField extends StatelessWidget {
  final TextEditingController controller;

  const ProfileBirthdayField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final app = AppLocalizations.of(context)!;

    return CustomProfileField(
      title: app.birthday,
      hintText: "YYYY-MM-DD",
      controller: controller,
      keyboardType: TextInputType.datetime,
      onChanged: (value) {
        String text = value.replaceAll("-", "");

        if (text.length > 8) {
          text = text.substring(0, 8);
        }

        String formatted = "";

        for (int i = 0; i < text.length; i++) {
          formatted += text[i];

          if (i == 3 || i == 5) {
            formatted += "-";
          }
        }

        if (formatted != controller.text) {
          controller.value = TextEditingValue(
            text: formatted,
            selection: TextSelection.collapsed(
              offset: formatted.length,
            ),
          );
        }
      },
    );
  }
}
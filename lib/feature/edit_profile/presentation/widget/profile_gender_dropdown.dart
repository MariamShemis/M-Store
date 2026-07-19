import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m_store_1/core/costants/color_manager.dart';
import 'package:m_store_1/l10n/app_localizations.dart';

class ProfileGenderDropdown extends StatelessWidget {
  final String? selectedValue;
  final ValueChanged<String?> onChanged;

  const ProfileGenderDropdown({
    super.key,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final app = AppLocalizations.of(context)!;
    final isArabic = Localizations.localeOf(context).languageCode == "ar";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          app.gender.toUpperCase(),
          style: GoogleFonts.inter(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: ColorManager.secondary,
          ),
        ),
        SizedBox(height: 8.h),
        DropdownButtonFormField<String>(
          value: selectedValue == "" ? null : selectedValue,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w500,
            fontSize: 15.sp,
            color: ColorManager.blackText,
          ),
          decoration: InputDecoration(
            hintText: app.selectGender,
            hintStyle: GoogleFonts.inter(
              fontWeight: FontWeight.w500,
              fontSize: 15.sp,
              color: ColorManager.lightGreyEF,
            ),
          ),
          items: [
            DropdownMenuItem(
              value: "Male",
              child: Text(isArabic ? "ذكر" : "Male"),
            ),
            DropdownMenuItem(
              value: "Female",
              child: Text(isArabic ? "أنثى" : "Female"),
            ),
          ],
          onChanged: onChanged,
        ),
      ],
    );
  }
}

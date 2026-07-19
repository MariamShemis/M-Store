import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m_store_1/core/costants/color_manager.dart';
import 'package:m_store_1/l10n/app_localizations.dart';

class BuyerInfoCard extends StatelessWidget {
  final Map<String, dynamic> buyerData;
  final int buyerNumber;

  const BuyerInfoCard({
    super.key,
    required this.buyerData,
    required this.buyerNumber,
  });

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Container(
      width: double.infinity,
      padding: REdgeInsets.all(24),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: ColorManager.lightGreyEF, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.shield_outlined, color: ColorManager.mediumGold, size: 20.sp),
              SizedBox(width: 8.w),
              Text(
                "${appLocalizations.buyerInformation} #$buyerNumber",
                style: GoogleFonts.playfairDisplay(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: ColorManager.mediumGold,
                ),
              ),
            ],
          ),
          Divider(height: 24.h, color: ColorManager.lightGreyEF),
          _buildInfoItem(appLocalizations.name, buyerData['name'] ?? 'N/A'),
          SizedBox(height: 12.h),
          _buildInfoItem(appLocalizations.phoneNumber, buyerData['phone'] ?? 'N/A'),
          SizedBox(height: 12.h),
          _buildInfoItem(appLocalizations.address, buyerData['address'] ?? 'N/A'),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(fontSize: 11.sp, color: ColorManager.secondary, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: GoogleFonts.inter(fontSize: 14.sp, color: ColorManager.blackText, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
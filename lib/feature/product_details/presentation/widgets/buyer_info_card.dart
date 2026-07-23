import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m_store_1/core/costants/color_manager.dart';
import 'package:m_store_1/feature/main_layout/products/data/model/buyer_model.dart';
import 'package:m_store_1/l10n/app_localizations.dart';

class BuyerInfoCard extends StatelessWidget {
  final BuyerModel buyer;
  final double purchasePrice;
  final int buyerNumber;

  const BuyerInfoCard({
    super.key,
    required this.buyerNumber,
    required this.buyer,
    required this.purchasePrice,
  });

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final totalPrice = buyer.sellingPrice * buyer.quantity;

    final profit = (buyer.sellingPrice - purchasePrice) * buyer.quantity;
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
              Icon(
                Icons.shield_outlined,
                color: ColorManager.mediumGold,
                size: 20.sp,
              ),
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
          Row(
            children: [
              Expanded(
                child: _buildInfoItem(appLocalizations.name, buyer.name),
              ),
              ?buyer.address.isNotEmpty
                  ? Expanded(
                      child: _buildInfoItem(
                        appLocalizations.address,
                        buyer.address,
                      ),
                    )
                  : null,
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              ?buyer.phone.isNotEmpty
                  ? Expanded(
                      child: _buildInfoItem(
                        appLocalizations.phoneNumber,
                        buyer.phone,
                      ),
                    )
                  : null,
              Expanded(
                child: _buildInfoItem(
                  appLocalizations.quantity,
                  (buyer.quantity).toString(),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: _buildInfoItem(
                  appLocalizations.sellingPrice,
                  "${buyer.sellingPrice.toStringAsFixed(2)} ${appLocalizations.lE}",
                ),
              ),
              Expanded(
                child: _buildInfoItem(
                  appLocalizations.totalPrice,
                  "${totalPrice.toStringAsFixed(2)} ${appLocalizations.lE}",
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          Row(
            children: [
              Expanded(
                child: _buildInfoItem(
                  appLocalizations.profit,
                  "${profit.toStringAsFixed(2)} ${appLocalizations.lE}",
                ),
              ),
              const Expanded(child: SizedBox()),
            ],
          ),
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
          style: GoogleFonts.inter(
            fontSize: 11.sp,
            color: ColorManager.secondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            color: ColorManager.blackText,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

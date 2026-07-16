import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m_store_1/core/costants/color_manager.dart';
import 'package:m_store_1/feature/add_product/data/model/buyer_data.dart';
import 'package:m_store_1/feature/add_product/presentation/widgets/custom_product_text_form_field.dart';
import 'package:m_store_1/l10n/app_localizations.dart';

class BuyerInformationSection extends StatelessWidget {
  final List<BuyerData> buyers;
  final VoidCallback onAddBuyer;
  final Function(int index) onRemoveBuyer;

  const BuyerInformationSection({
    super.key,
    required this.buyers,
    required this.onAddBuyer,
    required this.onRemoveBuyer,
  });

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Container(
      padding: REdgeInsets.all(24),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(28.r),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black0.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 38.w,
                height: 38.w,
                decoration: const BoxDecoration(
                  color: ColorManager.lightGreyEF,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    "03",
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: ColorManager.darkBronze,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  appLocalizations.buyerInformation,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w600,
                    color: ColorManager.blackText,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              IconButton(
                onPressed: onAddBuyer,
                style: IconButton.styleFrom(
                  backgroundColor: ColorManager.primaryColor20,
                  shape: const CircleBorder(),
                  padding: REdgeInsets.all(10),
                ),
                icon: Icon(
                  Icons.add_rounded,
                  color: ColorManager.darkBronze,
                  size: 22.sp,
                ),
              ),
            ],
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: buyers.length,
            itemBuilder: (context, index) {
              final buyer = buyers[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (index > 0) ...[
                    Padding(
                      padding: REdgeInsets.symmetric(vertical: 20),
                      child: Divider(
                        color: ColorManager.lightGreyEF,
                        thickness: 1.5.w,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${appLocalizations.buyer} #${index + 1}",
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: ColorManager.darkBronze,
                          ),
                        ),
                        IconButton(
                          onPressed: () => onRemoveBuyer(index),
                          icon: Icon(
                            Icons.delete_outline_rounded,
                            color: ColorManager.red,
                            size: 20.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                  ] else ...[
                    SizedBox(height: 24.h),
                  ],
                  CustomProductTextFormField(
                    labelText: appLocalizations.buyerName,
                    hintText: appLocalizations.enter_buyer_name,
                    controller: buyer.nameController,
                  ),
                  SizedBox(height: 20.h),
                  CustomProductTextFormField(
                    labelText: appLocalizations.address,
                    hintText: appLocalizations.enter_buyer_address,
                    controller: buyer.addressController,
                  ),
                  SizedBox(height: 20.h),
                  CustomProductTextFormField(
                    labelText: appLocalizations.phoneNumber,
                    hintText: appLocalizations.enter_buyer_phone_number,
                    controller: buyer.phoneController,
                    keyboardType: TextInputType.phone,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

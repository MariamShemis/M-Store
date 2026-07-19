import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m_store_1/core/costants/color_manager.dart';
import 'package:m_store_1/feature/main_layout/products/data/model/product_model.dart';
import 'package:m_store_1/l10n/app_localizations.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onTap;
  const ProductCard({super.key, required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final profit =
        (product.sellingPrice - product.purchasePrice) * product.soldQuantity;
    final available = product.availableQuantity > 0;

    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 20.h),
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 12,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
                  child: Image.network(
                    product.mainImage,
                    height: 220.h,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(18.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "${appLocalizations.iD}: ${product.productNumber}",
                            style: GoogleFonts.manrope(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                              color: ColorManager.greyDark,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            "${appLocalizations.qTY}: ${product.availableQuantity.toString().padLeft(2, '0')}",
                            style: GoogleFonts.manrope(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                              color: ColorManager.greyDark,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        product.productName,
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: ColorManager.blackText,
                        ),
                      ),
                      if (product.description.isNotEmpty) ...[
                        SizedBox(height: 8.h),
                        Text(
                          product.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.manrope(
                            color: ColorManager.brownDark,
                            fontWeight: FontWeight.w400,
                            fontSize: 16.sp,
                          ),
                        ),
                      ],
                      Divider(height: 32.h, color: ColorManager.lightGreyEF),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  appLocalizations.pricing.toUpperCase(),
                                  style: GoogleFonts.manrope(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w600,
                                    color: ColorManager.greyDark,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  "${appLocalizations.buy}: ${product.purchasePrice.toStringAsFixed(2)} ${appLocalizations.lE}",
                                  style: GoogleFonts.manrope(
                                    fontSize: 16.sp,
                                    color: ColorManager.blackText,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(height: 5.h),
                                Text(
                                  "${appLocalizations.sell}: ${product.sellingPrice.toStringAsFixed(2)}${appLocalizations.lE}",
                                  style: GoogleFonts.manrope(
                                    fontSize: 16.sp,
                                    color: ColorManager.mediumGold,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                appLocalizations.profit.toUpperCase(),
                                style: GoogleFonts.manrope(
                                  color: ColorManager.greyDark,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                "+${profit.toStringAsFixed(2)} ${appLocalizations.lE}",
                                style: GoogleFonts.manrope(
                                  color: ColorManager.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 16.h,
              left: 14.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: available
                      ? ColorManager.green.withOpacity(0.1)
                      : ColorManager.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(30.r),
                  border: Border.all(
                    color: available
                        ? ColorManager.green.withOpacity(0.3)
                        : ColorManager.red.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Text(
                  available ? appLocalizations.available : appLocalizations.sold,
                  style: TextStyle(
                    color: available ? ColorManager.green : ColorManager.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 13.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

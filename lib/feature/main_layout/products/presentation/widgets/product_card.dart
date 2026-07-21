import 'package:cached_network_image/cached_network_image.dart';
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
    final profit = product.profit;
    final profitText =
        "${profit > 0 ? "+" : ""}${profit.toStringAsFixed(2)} ${appLocalizations.lE}";
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
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(24.r),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: product.mainImage,
                    fadeInDuration: Duration.zero,
                    fadeOutDuration: Duration.zero,
                    height: 220.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (_, __) =>
                        Container(height: 220.h, color: Colors.grey.shade100),
                    errorWidget: (context, url, error) => Container(
                      height: 220.h,
                      color: Colors.grey.shade200,
                      child: Icon(Icons.broken_image_outlined, size: 45.sp),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(18.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            product.productName,
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                              color: ColorManager.blackText,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 7.h,
                            ),
                            decoration: BoxDecoration(
                              color: ColorManager.lightGreyEF,
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                            child: Text(
                              "${appLocalizations.iD}: ${product.productNumber}",
                              style: GoogleFonts.manrope(
                                fontWeight: FontWeight.w700,
                                color: ColorManager.greyDark,
                                fontSize: 14.sp
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        if (product.description.isNotEmpty) ...[
                          Expanded(
                            child: Text(
                              product.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.manrope(
                                color: ColorManager.brownDark,
                                fontWeight: FontWeight.w400,
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                        ],
                        Text(
                          "${appLocalizations.qTY}: ${product.availableQuantity.toString().padLeft(2, '0')}",
                          style: GoogleFonts.manrope(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            color: ColorManager.greyDark,
                          ),
                        ),
                      ],),
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
                                profitText,
                                style: GoogleFonts.manrope(
                                  color: profit >= 0 ? ColorManager.green : Colors.red,
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
                  color: product.isSold
                      ? ColorManager.mediumGold
                      : ColorManager.green,
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Text(
                  product.isSold
                      ? appLocalizations.sold.toUpperCase()
                      : appLocalizations.available.toUpperCase(),
                  style: TextStyle(
                    color: ColorManager.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp,
                    letterSpacing: 0.5,
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

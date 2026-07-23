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
                  child: product.mainImage.isEmpty
                      ? Container(
                    height: 220.h,
                    width: double.infinity,
                    color: Color(0xffD0C5AF).withOpacity(0.5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 72.w,
                          height: 72.w,
                          decoration: BoxDecoration(
                            color: ColorManager.mediumGold.withOpacity(.12),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.inventory_2_outlined,
                            size: 36.sp,
                            color: ColorManager.mediumGold,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          appLocalizations.noImageAvailable,
                          style: GoogleFonts.manrope(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: ColorManager.greyDark,
                          ),
                        ),
                      ],
                    ),
                  )
                      : CachedNetworkImage(
                    imageUrl: product.mainImage,
                    fadeInDuration: Duration.zero,
                    fadeOutDuration: Duration.zero,
                    height: 220.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => Container(
                      height: 220.h,
                      color: Colors.grey.shade100,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    errorWidget: (_, __, ___) => Container(
                      height: 220.h,
                      width: double.infinity,
                      color: const Color(0xffF8F7F4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 72.w,
                            height: 72.w,
                            decoration: BoxDecoration(
                              color: ColorManager.mediumGold.withOpacity(.12),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.image_not_supported_outlined,
                              size: 36.sp,
                              color: ColorManager.mediumGold,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            appLocalizations.noImageAvailable,
                            style: GoogleFonts.manrope(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: ColorManager.greyDark,
                            ),
                          ),
                        ],
                      ),
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
                                fontSize: 14.sp,
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
                        ],
                      ),
                      if (product.purchasePrice != null) ...[
                        Divider(height: 32.h, color: ColorManager.lightGreyEF),
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
                        Row(
                          children: [
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  style: GoogleFonts.manrope(
                                    fontSize: 15.sp,
                                    color: ColorManager.blackText,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: "${appLocalizations.purchasePrice}:   ",
                                    ),
                                    TextSpan(
                                      text:
                                          "${product.purchasePrice.toStringAsFixed(2)} ${appLocalizations.lE}",
                                      style: GoogleFonts.manrope(
                                        fontSize: 18.sp,
                                        color: ColorManager.mediumGold,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
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
                    fontSize: 13.sp,
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

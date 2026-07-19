import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m_store_1/core/costants/color_manager.dart';
import 'package:m_store_1/feature/main_layout/products/data/model/product_model.dart';
import 'package:m_store_1/l10n/app_localizations.dart';

class ProductHeaderSection extends StatelessWidget {
  final ProductModel product;

  const ProductHeaderSection({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "${product.category.toUpperCase()} / ${appLocalizations.category.toUpperCase()}",
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: ColorManager.mediumGold,
                letterSpacing: 0.5,
              ),
            ),
            const Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: ColorManager.lightGreyEF,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  Text(
                    "#${product.productNumber}",
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: ColorManager.brownDark,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Icon(Icons.copy, size: 12.sp, color: ColorManager.greyDark),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Text(
          product.productName,
          style: GoogleFonts.playfairDisplay(
            fontSize: 32.sp,
            fontWeight: FontWeight.bold,
            color: ColorManager.blackText,
          ),
        ),
        if (product.description.isNotEmpty) ...[
          SizedBox(height: 12.h),
          Text(
            product.description,
            style: GoogleFonts.inter(
              fontSize: 15.sp,
              color: ColorManager.secondary,
              height: 1.5,
            ),
          ),
        ],
      ],
    );
  }
}

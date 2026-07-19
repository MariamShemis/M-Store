import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:m_store_1/core/costants/color_manager.dart';
import 'package:m_store_1/feature/main_layout/products/data/model/product_model.dart';
import 'package:m_store_1/l10n/app_localizations.dart';

class ProductImagesPreview extends StatelessWidget {
  final ProductModel product;
  const ProductImagesPreview({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Column(
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(24.r),
              child: Image.network(
                product.mainImage,
                height: 300.h,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 16.h,
              left: 16.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: product.isSold ? ColorManager.blackText : ColorManager.green,
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Text(
                  product.isSold ? appLocalizations.sold.toUpperCase() : appLocalizations.available.toUpperCase(),
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
        if (product.images.isNotEmpty) ...[
          SizedBox(height: 12.h),
          Row(
            children: List.generate(
              product.images.length,
                  (index) => Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: Image.network(
                      product.images[index],
                      height: 100.h,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
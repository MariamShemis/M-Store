import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m_store_1/core/costants/color_manager.dart';
import 'package:m_store_1/l10n/app_localizations.dart';

class ProductImagesUploader extends StatelessWidget {
  final String? mainImagePath;
  final List<String> additionalImages;
  final VoidCallback onPickMainImage;
  final Function(int index) onPickAdditionalImage;

  const ProductImagesUploader({
    super.key,
    this.mainImagePath,
    required this.additionalImages,
    required this.onPickMainImage,
    required this.onPickAdditionalImage,
  });

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Container(
      padding: REdgeInsets.all(24),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(28.r),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black0.withOpacity(0.03),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            appLocalizations.productImagery,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.playfairDisplay(
              fontSize: 22.sp,
              fontWeight: FontWeight.w500,
              color: ColorManager.blackText,
            ),
          ),

          SizedBox(height: 24.h),

          GestureDetector(
            onTap: onPickMainImage,
            child: _buildMainImageUploadArea(context),
          ),

          SizedBox(height: 16.h),

          _buildAdditionalImagesArea(),
        ],
      ),
    );
  }

  Widget _buildMainImageUploadArea(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return DottedBorder(
      color: ColorManager.lightGrey.withOpacity(.5),
      strokeWidth: 1.5,
      dashPattern: const [8, 5],
      borderType: BorderType.RRect,
      radius: Radius.circular(20.r),
      child: Container(
        height: 280.h,
        decoration: BoxDecoration(
          color: ColorManager.background,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: (mainImagePath != null && mainImagePath!.isNotEmpty)
            ? ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: _buildImage(mainImagePath!),
        )
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              height: 82.w,
              decoration: BoxDecoration(
                color: ColorManager.mediumGold.withOpacity(.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.image_outlined,
                size: 42.sp,
                color: ColorManager.mediumGold,
              ),
            ),
            SizedBox(height: 18.h),
            Text(
              appLocalizations.noImageAvailable,
              style: GoogleFonts.manrope(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: ColorManager.blackText,
              ),
            ),

            SizedBox(height: 6.h),

            Text(
              appLocalizations.tap_to_upload_image,
              style: GoogleFonts.manrope(
                fontSize: 14.sp,
                color: ColorManager.greyDark,
              ),
            ),

            SizedBox(height: 20.h),

            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 18.w,
                vertical: 10.h,
              ),
              decoration: BoxDecoration(
                color: ColorManager.mediumGold,
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.add_photo_alternate_outlined,
                    color: Colors.white,
                    size: 18.sp,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    appLocalizations.uploadImage,
                    style: GoogleFonts.manrope(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdditionalImagesArea() {
    return Row(
      children: List.generate(
        3,
            (index) {
          final hasImage = index < additionalImages.length;

          return Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: GestureDetector(
                onTap: () => onPickAdditionalImage(index),
                child: DottedBorder(
                  color: ColorManager.lightGrey.withOpacity(.5),
                  strokeWidth: 1.5,
                  dashPattern: const [6, 4],
                  borderType: BorderType.RRect,
                  radius: Radius.circular(16.r),
                  child: Container(
                    height: 85.h,
                    decoration: BoxDecoration(
                      color: ColorManager.background,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: hasImage
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(16.r),
                      child: _buildImage(additionalImages[index]),
                    )
                        : Center(
                      child: Icon(
                        Icons.add,
                        size: 28.sp,
                        color: ColorManager.greyDark,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildImage(String path) {
    if (path.startsWith("http")) {
      return Image.network(
        path,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
      );
    }

    return Image.file(
      File(path),
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
    );
  }
}
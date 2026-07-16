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
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Container(
      padding: REdgeInsets.all(24),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(28.r),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black0.withOpacity(0.03),
            spreadRadius: 0,
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            appLocalizations.productImagery,
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
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return DottedBorder(
      color: ColorManager.lightGrey.withOpacity(0.5),
      strokeWidth: 1.5,
      dashPattern: const [8, 5],
      borderType: BorderType.RRect,
      radius: Radius.circular(20.r),
      child: Container(
        height: 280.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: ColorManager.background,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: mainImagePath != null
            ? Center(
                child: Text(
                  "Main Image Selected ✅",
                  style: GoogleFonts.inter(
                    color: ColorManager.darkBronze,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: REdgeInsets.all(18),
                    decoration: const BoxDecoration(
                      color: ColorManager.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.add_photo_alternate_outlined,
                      size: 32.sp,
                      color: ColorManager.darkBronze,
                    ),
                  ),
                  SizedBox(height: 18.h),
                  Text(
                    appLocalizations.upload_Main_Image,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: ColorManager.blackText,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    "PNG, JPG or WEBP",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: ColorManager.secondary,
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
        (index) => Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            child: GestureDetector(
              onTap: () => onPickAdditionalImage(index),
              child: DottedBorder(
                color: ColorManager.lightGrey.withOpacity(0.5),
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
                  child: Center(
                    child: additionalImages.length > index
                        ? const Icon(
                            Icons.check_circle_rounded,
                            color: Colors.green,
                          )
                        : Icon(
                            Icons.add,
                            size: 28.sp,
                            color: ColorManager.greyDark,
                          ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

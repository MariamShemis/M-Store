import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m_store_1/core/costants/color_manager.dart';
import 'package:m_store_1/core/utils/validators/product_validators.dart';
import 'package:m_store_1/feature/add_product/presentation/widgets/custom_product_text_form_field.dart';
import 'package:m_store_1/l10n/app_localizations.dart';

class PhysicalAttributesSection extends StatelessWidget {
  final TextEditingController materialController;
  final TextEditingController primaryColorController;
  final TextEditingController sizeController;
  final TextEditingController quantityController;
  final TextEditingController purchasePriceController;
  final TextEditingController sellingPriceController;
  final Widget? colorSuffixIcon;
  final VoidCallback? onColorTap;
  final void Function(String)? onChangedColor;

  const PhysicalAttributesSection({
    super.key,
    required this.materialController,
    required this.primaryColorController,
    required this.sizeController,
    required this.quantityController,
    required this.purchasePriceController,
    required this.sellingPriceController,
    this.colorSuffixIcon,
    this.onChangedColor,
    this.onColorTap,
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
                    "02",
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: ColorManager.darkBronze,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                appLocalizations.physicalAttributes,
                style: GoogleFonts.playfairDisplay(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w600,
                  color: ColorManager.blackText,
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          CustomProductTextFormField(
            labelText: appLocalizations.material,
            hintText: appLocalizations.enter_material,
            controller: materialController,
            validator: (value) =>
                ProductValidators.validateMaterial(value, context),
          ),
          SizedBox(height: 20.h),
          GestureDetector(
            onTap: onColorTap,
            child: AbsorbPointer(
              absorbing: onColorTap != null,
              child: CustomProductTextFormField(
                labelText: appLocalizations.primaryColor,
                hintText: appLocalizations.enter_color,
                controller: primaryColorController,
                suffixIcon: colorSuffixIcon,
                onChanged: onChangedColor,
              ),
            ),
          ),

          SizedBox(height: 20.h),
          CustomProductTextFormField(
            labelText:
                "${appLocalizations.size} / ${appLocalizations.dimensions}",
            hintText: appLocalizations.enter_size,
            controller: sizeController,
            validator: (value) =>
                ProductValidators.validateSize(value, context),
          ),
          SizedBox(height: 20.h),
          CustomProductTextFormField(
            labelText: appLocalizations.initialQuantity,
            hintText: appLocalizations.enter_quantity,
            controller: quantityController,
            keyboardType: TextInputType.number,
            validator: (value) =>
                ProductValidators.validateQuantity(value, context),
          ),
          SizedBox(height: 20.h),
          CustomProductTextFormField(
            labelText: appLocalizations.purchasePrice,
            hintText: "0.00",
            controller: purchasePriceController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            prefixIcon: Padding(
              padding: REdgeInsets.only(left: 16, right: 8, top: 14),
              child: Text(
                appLocalizations.lE,
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: ColorManager.secondary,
                ),
              ),
            ),
            validator: (value) =>
                ProductValidators.validatePrice(value, context),
          ),
          SizedBox(height: 20.h),
          CustomProductTextFormField(
            labelText: appLocalizations.sellingPrice,
            controller: sellingPriceController,
            hintText: "0.00",
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            prefixIcon: Padding(
              padding: REdgeInsets.only(left: 16, right: 8, top: 14),
              child: Text(
                appLocalizations.lE,
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: ColorManager.secondary,
                ),
              ),
            ),
            validator: (value) =>
                ProductValidators.validatePrice(value, context),
          ),
        ],
      ),
    );
  }
}

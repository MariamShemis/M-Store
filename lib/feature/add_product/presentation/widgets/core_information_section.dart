import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m_store_1/core/costants/color_manager.dart';
import 'package:m_store_1/core/utils/validators/product_validators.dart';
import 'package:m_store_1/feature/add_product/presentation/widgets/custom_product_text_form_field.dart';
import 'package:m_store_1/l10n/app_localizations.dart';

class CoreInformationSection extends StatelessWidget {
  final TextEditingController productNumberController;
  final TextEditingController categoryController;
  final TextEditingController productNameController;
  final TextEditingController descriptionController;

  const CoreInformationSection({
    super.key,
    required this.productNumberController,
    required this.categoryController,
    required this.productNameController,
    required this.descriptionController,
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
                    "01",
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
                appLocalizations.coreIdentity,
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
            labelText: appLocalizations.productNumber,
            hintText: appLocalizations.enter_product_number,
            keyboardType: TextInputType.number,
            controller: productNumberController,
            validator: (value) =>
                ProductValidators.validateProductNumber(value, context),
          ),
          SizedBox(height: 20.h),
          CustomProductTextFormField(
            labelText: appLocalizations.productName,
            keyboardType: TextInputType.name,
            hintText: appLocalizations.enter_product_name,
            controller: productNameController,
            validator: (value) =>
                ProductValidators.validateProductName(value, context),
          ),
          SizedBox(height: 20.h),
          CustomProductTextFormField(
            labelText: appLocalizations.category,
            hintText: appLocalizations.enter_category,
            keyboardType: TextInputType.text,
            controller: categoryController,
              validator: (value) =>
                  ProductValidators.validateCategory(value, context),
          ),
          SizedBox(height: 20.h),
          CustomProductTextFormField(
            labelText: appLocalizations.description,
            maxLines: 3,
            keyboardType: TextInputType.text,
            hintText: appLocalizations.enter_description,
            controller: descriptionController,
            validator: (value) =>
                ProductValidators.validateDescription(value, context),
          ),
        ],
      ),
    );
  }
}

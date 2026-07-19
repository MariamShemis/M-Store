import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:m_store_1/feature/add_product/presentation/widgets/custom_product_text_form_field.dart';
import 'package:m_store_1/feature/main_layout/products/data/model/product_model.dart';
import 'package:m_store_1/l10n/app_localizations.dart';

class SellProductBottomSheet extends StatefulWidget {
  final ProductModel product;
  final Function(
      String name,
      String phone,
      String address,
      int quantity,
      ) onSave;

  const SellProductBottomSheet({
    super.key,
    required this.product, required this.onSave,
  });

  @override
  State<SellProductBottomSheet> createState() =>
      _SellProductBottomSheetState();
}

class _SellProductBottomSheetState extends State<SellProductBottomSheet> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final quantityController = TextEditingController(text: "1");
  final priceController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    quantityController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        top: 20.h,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30.r),
        ),
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  width: 60.w,
                  height: 5.h,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                ),
              ),

              SizedBox(height: 20.h),

              Text(
                appLocalizations.sellProduct,
                textAlign: TextAlign.center,
                style: textTheme.titleLarge,
              ),

              SizedBox(height: 5.h),

              Text(
                widget.product.productName,
                style: textTheme.bodyMedium,
              ),

              SizedBox(height: 8.h),

              Text(
                "${appLocalizations.availableQuantity} : ${widget.product.availableQuantity}",
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
              ),

              SizedBox(height: 25.h),

              CustomProductTextFormField(
                labelText: appLocalizations.buyerName,
                hintText: appLocalizations.enter_buyer_name,
                controller: nameController,
              ),

              SizedBox(height: 16.h),

              CustomProductTextFormField(
                labelText: appLocalizations.phoneNumber,
                hintText: appLocalizations.enter_buyer_phone_number,
                controller: phoneController,
                keyboardType: TextInputType.phone,
              ),

              SizedBox(height: 16.h),

              CustomProductTextFormField(
                labelText: appLocalizations.address,
                hintText: appLocalizations.enter_buyer_address,
                controller: addressController,
              ),

              SizedBox(height: 16.h),

              CustomProductTextFormField(
                labelText: appLocalizations.quantity,
                hintText: appLocalizations.enter_quantity,
                controller: quantityController,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 30.h),

              SizedBox(
                width: double.infinity,
                height: 55.h,
                child: ElevatedButton(
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) return;

                    widget.onSave(
                      nameController.text,
                      phoneController.text,
                      addressController.text,
                      int.parse(quantityController.text),
                    );
                  },
                  child: Text(appLocalizations.save),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
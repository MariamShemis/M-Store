import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:m_store_1/core/costants/color_manager.dart';
import 'package:m_store_1/l10n/app_localizations.dart';

class ProductActionButtons extends StatelessWidget {
  final bool isSold;
  final VoidCallback onSell;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ProductActionButtons({
    super.key,
    required this.isSold,
    required this.onSell,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Column(
      children: [
        if (!isSold) ...[
          SizedBox(
            width: double.infinity,
            height: 52.h,
            child: ElevatedButton(
              onPressed: onSell,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorManager.mediumGold,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.r),
                ),
              ),
              child: Text(appLocalizations.sellProduct.toUpperCase()),
            ),
          ),
          SizedBox(height: 12.h),
        ],
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 52.h,
                child: OutlinedButton(
                  onPressed: onEdit,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: ColorManager.blackText, width: 1 ,),
                    foregroundColor: ColorManager.blackText,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.r),
                    ),
                  ),
                  child: Text(appLocalizations.edit.toUpperCase()),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: SizedBox(
                height: 52.h,
                child: OutlinedButton(
                  onPressed: onDelete,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: ColorManager.red, width: 1),
                    foregroundColor: ColorManager.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.r),
                    ),
                  ),
                  child: Text(appLocalizations.delete.toUpperCase()),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
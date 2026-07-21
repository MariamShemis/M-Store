import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:m_store_1/core/costants/color_manager.dart';
import 'package:m_store_1/feature/main_layout/products/data/model/product_model.dart';
import 'package:m_store_1/l10n/app_localizations.dart';

class ProductInfoCard extends StatelessWidget {
  final ProductModel product;

  const ProductInfoCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final profit = product.profit;
    final profitText =
        "${profit > 0 ? "+" : ""}${profit.toStringAsFixed(2)} ${appLocalizations.lE}";

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: ColorManager.lightGreyEF,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Align(
            alignment: Alignment.centerRight,
            child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    appLocalizations.retailPrice.toUpperCase(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      color: ColorManager.secondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  "${product.sellingPrice.toStringAsFixed(2)} ${appLocalizations.lE}",
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 28.sp,
                    color: ColorManager.mediumGold,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          Divider(),
          SizedBox(height: 20.h),
          Row(
            children: [
              Expanded(
                child: _item(
                  appLocalizations.category,
                  product.category,
                ),
              ),
              Expanded(
                child: _item(
                  appLocalizations.material,
                  product.material.toUpperCase(),
                ),
              ),
            ],
          ),

          SizedBox(height: 22.h),

          Row(
            children: [
              Expanded(
                child: _item(
                  appLocalizations.color,
                  product.color,
                ),
              ),
              Expanded(
                child: _item(
                  appLocalizations.size.toUpperCase(),
                  product.dimensions,
                ),
              ),
            ],
          ),

          SizedBox(height: 22.h),

          Row(
            children: [
              Expanded(
                child: _item(
                  appLocalizations.qTY,
                  "${product.availableQuantity} ${appLocalizations.units}",
                ),
              ),
              Expanded(
                child: _item(
                  appLocalizations.profit,
                  profitText,
                  valueColor: profit >= 0 ? ColorManager.green : Colors.red,
                ),
              ),
            ],
          ),
          SizedBox(height: 22.h),
          Row(
            children: [
              Expanded(
                child: _item(
                  appLocalizations.added.toUpperCase(),
                  _formatDate(product.createdAt),
                ),
              ),
              ?product.updatedAt != null ?Expanded(
                child: _item(
                  appLocalizations.modified.toUpperCase(),
                  _formatDate(product.updatedAt!),
                ),
              ) : null,
            ],
          ),
        ],
      ),
    );
  }
  String _formatDate(DateTime date) {
    return DateFormat("dd MMM yyyy • hh:mm a").format(date);
  }

  Widget _item(
      String title,
      String value, {
        Color? valueColor,
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 11,
            color: ColorManager.secondary,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: valueColor ?? ColorManager.blackText,
          ),
        ),
      ],
    );
  }

  // String _formatDate(DateTime date) {
  //   return "${date.day}/${date.month}/${date.year}";
  // }
}
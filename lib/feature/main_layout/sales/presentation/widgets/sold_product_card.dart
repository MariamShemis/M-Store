import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m_store_1/core/costants/color_manager.dart';
import 'package:m_store_1/feature/main_layout/products/data/model/product_model.dart';
import 'package:m_store_1/l10n/app_localizations.dart';

class SoldProductCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback? onTap;

  const SoldProductCard({super.key, required this.product, this.onTap});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    final buyer = product.buyers.first;
    final buyerProfit = product.buyerProfit(buyer);
    final profit = product.totalProfit;
    final profitColor = profit >= 0 ? ColorManager.green : ColorManager.red;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(26.r),
      child: Container(
        margin: EdgeInsets.only(bottom: 22.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(26.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.05),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
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
                                  color: ColorManager.mediumGold.withOpacity(
                                    .12,
                                  ),
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
                                    color: ColorManager.mediumGold.withOpacity(
                                      .12,
                                    ),
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
                Positioned(
                  top: 14,
                  left: 14,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 15.w,
                      vertical: 7.h,
                    ),
                    decoration: BoxDecoration(
                      color: ColorManager.mediumGold,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      appLocalizations.sold.toUpperCase(),
                      style: GoogleFonts.manrope(
                        fontSize: 13.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
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
                          fontSize: 26.sp,
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
                            fontSize: 14.sp,
                            color: ColorManager.greyDark,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 22.h),
                  Row(
                    children: [
                      Expanded(
                        child: _infoItem(
                          icon: Icons.person_outline_rounded,
                          text: buyer.name,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: _infoItem(
                          icon: Icons.calendar_today_outlined,
                          text:
                              "${buyer.purchaseDate?.day}/${buyer.purchaseDate?.month}/${buyer.purchaseDate?.year}",
                        ),
                      ),
                    ],
                  ),
                  if (buyer.phone.isNotEmpty || buyer.address.isNotEmpty) ...[
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        ?buyer.phone.isNotEmpty
                            ? Expanded(
                                child: _infoItem(
                                  icon: Icons.phone_outlined,
                                  text: buyer.phone,
                                ),
                              )
                            : null,
                        SizedBox(width: buyer.phone.isNotEmpty ? 12.w : 0.w),
                        ?buyer.address.isNotEmpty
                            ? Expanded(
                                child: _infoItem(
                                  icon: Icons.location_on_outlined,
                                  text: buyer.address,
                                ),
                              )
                            : null,
                      ],
                    ),
                  ],
                  SizedBox(height: 14.h),
                  Row(
                    children: [
                      Expanded(
                        child: _infoItem(
                          icon: Icons.shopping_cart_checkout_outlined,
                          text: "${buyer.quantity} ${appLocalizations.units}",
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: _infoItem(
                          icon: Icons.payments_outlined,
                          text:
                              "${buyer.sellingPrice.toStringAsFixed(2)} ${appLocalizations.lE}",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      Expanded(
                        child: _infoItem(
                          icon: Icons.trending_up,
                          text:
                              "${buyerProfit >= 0 ? '+' : ''}${buyerProfit.toStringAsFixed(2)} ${appLocalizations.lE}",
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: _infoItem(
                          icon: Icons.inventory_2_outlined,
                          text:
                              "${appLocalizations.remaining}: ${product.availableQuantity}",
                        ),
                      ),
                    ],
                  ),
                  Divider(height: 30.h, color: ColorManager.lightGreyEF),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              appLocalizations.sellingPrice.toUpperCase(),
                              style: GoogleFonts.manrope(
                                fontSize: 12.sp,
                                color: ColorManager.greyDark,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              "${product.totalSellingPrice.toStringAsFixed(2)} ${appLocalizations.lE}",
                              style: GoogleFonts.manrope(
                                fontSize: 20.sp,
                                color: ColorManager.mediumGold,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Row(
                              children: [
                                Text(
                                  "${appLocalizations.sold_QTY.toUpperCase()}: ",
                                  style: GoogleFonts.manrope(
                                    fontSize: 14.sp,
                                    color: ColorManager.greyDark,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),

                                SizedBox(width: 8.w),

                                Text(
                                  product.soldQuantity.toString(),
                                  style: GoogleFonts.manrope(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                    color: ColorManager.green,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            appLocalizations.profit.toUpperCase(),
                            style: GoogleFonts.manrope(
                              fontSize: 12.sp,
                              color: ColorManager.greyDark,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          SizedBox(height: 8.h),

                          Text(
                            "${profit >= 0 ? "+" : ""}${profit.toStringAsFixed(2)} ${appLocalizations.lE}",
                            style: GoogleFonts.manrope(
                              color: profitColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.sp,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoItem({required IconData icon, required String text}) {
    return Row(
      children: [
        Icon(icon, size: 18.sp, color: ColorManager.mediumGold),

        SizedBox(width: 6.w),

        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.manrope(
              fontSize: 14.sp,
              color: ColorManager.greyDark,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

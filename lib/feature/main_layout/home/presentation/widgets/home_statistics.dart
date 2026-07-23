import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:m_store_1/core/costants/color_manager.dart';
import 'package:m_store_1/feature/main_layout/home/data/model/dashboard_model.dart';
import 'package:m_store_1/l10n/app_localizations.dart';

class HomeStatistics extends StatelessWidget {
  const HomeStatistics({super.key, required this.dashboard});

  final DashboardModel dashboard;

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    final size = MediaQuery.sizeOf(context);
    final double cardAspectRatio = size.height < 650 ? 1.1 : 1.5;

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 12.w,
      mainAxisSpacing: 12.h,
      childAspectRatio: cardAspectRatio,
      children: [
        _StatisticCard(
          title: appLocalizations.products.toUpperCase(),
          value: dashboard.totalProducts.toString(),
          icon: Icons.inventory_2_outlined,
        ),
        _StatisticCard(
          title: appLocalizations.available.toUpperCase(),
          value: dashboard.availableProducts.toString(),
          icon: Icons.check_circle_outline,
        ),
        _StatisticCard(
          title: appLocalizations.availableItems.toUpperCase(),
          value: dashboard.availableItems.toString(),
          icon: Icons.widgets_outlined,
        ),
        _StatisticCard(
          title: appLocalizations.sold.toUpperCase(),
          value: dashboard.soldProducts.toString(),
          icon: Icons.shopping_bag_outlined,
        ),
        _StatisticCard(
          title: appLocalizations.soldItems.toUpperCase(),
          value: dashboard.soldItems.toString(),
          icon: Icons.shopping_cart_checkout_outlined,
        ),
        _StatisticCard(
          title: appLocalizations.productsPrice.toUpperCase(),
          value:
          "${dashboard.totalProductsPrice.toStringAsFixed(2)} ${appLocalizations.lE}",
          icon: Icons.sell_outlined,
        ),
        _StatisticCard(
          title: appLocalizations.inventoryValue.toUpperCase(),
          value:
          "${dashboard.totalInventoryValue.toStringAsFixed(2)} ${appLocalizations.lE}",
          icon: Icons.warehouse_outlined,
        ),
        _StatisticCard(
          title: appLocalizations.sales.toUpperCase(),
          value:
          "${dashboard.totalSales.toStringAsFixed(2)} ${appLocalizations.lE}",
          icon: Icons.payments_outlined,
        ),
        _StatisticCard(
          title: appLocalizations.profit.toUpperCase(),
          value:
          "${dashboard.totalProfit.toStringAsFixed(2)} ${appLocalizations.lE}",
          icon: Icons.trending_up,
          isHighlighted: true,
        ),
      ],
    );
  }
}

class _StatisticCard extends StatelessWidget {
  const _StatisticCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    this.isHighlighted = false,
  });

  final String title;
  final String value;
  final IconData icon;
  final bool isHighlighted;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: isHighlighted ? const Color(0xffFCFAF4) : ColorManager.white,
        borderRadius: BorderRadius.circular(20.r),
        border: isHighlighted
            ? Border.all(color: ColorManager.primaryColor.withOpacity(.2))
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.03),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            icon,
            color: ColorManager.primaryColor,
            size: 24.sp,
          ),
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                title.toUpperCase(),
                style: textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
              ),
            ),
          ),
          SizedBox(height: 4.h),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              style: textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
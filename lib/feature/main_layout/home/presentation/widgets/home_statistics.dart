import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:m_store_1/core/costants/color_manager.dart';
import 'package:m_store_1/l10n/app_localizations.dart';

class HomeStatistics extends StatelessWidget {
  const HomeStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final height = MediaQuery.sizeOf(context).height;
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 14.w,
      mainAxisSpacing: 14.h,
      mainAxisExtent: height * 0.15,
      children: [
        _StatisticCard(
          title: appLocalizations.products.toUpperCase(),
          value: "1,248",
          icon: Icons.inventory_2_outlined,
        ),
        _StatisticCard(
          title: appLocalizations.available.toUpperCase(),
          value: "842",
          icon: Icons.check_circle_outline,
        ),
        _StatisticCard(
          title: appLocalizations.sold.toUpperCase(),
          value: "406",
          icon: Icons.shopping_bag_outlined,
        ),
        _StatisticCard(
          title: appLocalizations.capital.toUpperCase(),
          value: "\$24.5k",
          icon: Icons.account_balance_outlined,
        ),
        _StatisticCard(
          title: appLocalizations.sales.toUpperCase(),
          value: "\$48.2k",
          icon: Icons.payments_outlined,
        ),
        _StatisticCard(
          title: appLocalizations.profit.toUpperCase(),
          value: "\$23.7k",
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
      padding: REdgeInsets.all(18),
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
        children: [
          Icon(icon, color: ColorManager.primaryColor, size: 28.sp),
          const Spacer(),
          Text(title.toUpperCase(), style: textTheme.bodySmall),
          SizedBox(height: 5.h),
          Text(value, style: textTheme.titleMedium),
        ],
      ),
    );
  }
}

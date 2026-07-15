import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m_store_1/core/costants/color_manager.dart';
import 'package:m_store_1/l10n/app_localizations.dart';

class CategoryStatistics extends StatelessWidget {
  const CategoryStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Container(
      padding: REdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(22.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.03),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                appLocalizations.topCategories,
                style: theme.textTheme.titleMedium,
              ),
              const Spacer(),
              TextButton(
                onPressed: () {},
                child: Text(
                  appLocalizations.seeAll,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: ColorManager.darkBronze,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          const _CategoryItem(
            title: "Electronics",
            products: 145,
            progress: .92,
          ),
          SizedBox(height: 18.h),
          const _CategoryItem(title: "Fashion", products: 98, progress: .68),
          SizedBox(height: 18.h),
          const _CategoryItem(
            title: "Accessories",
            products: 55,
            progress: .45,
          ),
          SizedBox(height: 18.h),
          const _CategoryItem(title: "Perfumes", products: 22, progress: .20),
        ],
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  const _CategoryItem({
    required this.title,
    required this.products,
    required this.progress,
  });

  final String title;
  final int products;
  final double progress;

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: Text(title, style: textTheme.labelMedium)),
            Text("$products ${appLocalizations.products}", style: textTheme.bodySmall),
          ],
        ),

        SizedBox(height: 8.h),

        ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 8.h,
            backgroundColor: ColorManager.lightGreyEF,
            valueColor: const AlwaysStoppedAnimation(ColorManager.primaryColor),
          ),
        ),
      ],
    );
  }
}

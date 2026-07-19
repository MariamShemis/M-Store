import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m_store_1/core/costants/color_manager.dart';
import 'package:m_store_1/feature/main_layout/home/data/model/category_statistics_model.dart';
import 'package:m_store_1/l10n/app_localizations.dart';

class CategoryStatistics extends StatefulWidget {
  const CategoryStatistics({
    super.key,
    required this.categories,
  });

  final List<CategoryStatisticsModel> categories;

  @override
  State<CategoryStatistics> createState() => _CategoryStatisticsState();
}

class _CategoryStatisticsState extends State<CategoryStatistics> {

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
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              appLocalizations.topCategories,
              style: theme.textTheme.titleMedium,
            ),
          ),
          SizedBox(height: 20.h),
          Column(
            children: widget.categories
                .map(
                  (e) => Padding(
                padding: EdgeInsets.only(bottom: 18.h),
                child: _CategoryItem(
                  title: e.category,
                  products: e.productsCount,
                  progress: e.percentage,
                ),
              ),
            )
                .toList(),
          ),
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

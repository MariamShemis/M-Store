import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:m_store_1/core/costants/assets_manager.dart';
import 'package:m_store_1/l10n/app_localizations.dart';

class EmptyProductsCard extends StatelessWidget {
  const EmptyProductsCard({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            LottieAssets.addToCart,
            fit: BoxFit.fill,
            width: 250,
            height: 250,
          ),
          Text(
            appLocalizations.your_Inventory_is_Empty,
            style: textTheme.titleMedium,
          ),
          SizedBox(height: 10.h),
          Text(
            appLocalizations
                .start_building_your_inventory_by_adding_your_first_product,
            textAlign: TextAlign.center,
            style: textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

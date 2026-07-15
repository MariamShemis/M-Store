import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:m_store_1/core/costants/color_manager.dart';
import 'package:m_store_1/feature/main_layout/products/presentation/widgets/empty_products_card.dart';
import 'package:m_store_1/l10n/app_localizations.dart';

class ProductsTab extends StatelessWidget {
  const ProductsTab({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: Padding(
          padding: REdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    appLocalizations.productInventory,
                    style: textTheme.titleLarge?.copyWith(
                      color: ColorManager.blackText,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    appLocalizations.manage_and_organize_your_store_products,
                    style: textTheme.bodySmall,
                  ),
                ],
              ),
              SizedBox(height: 40.h),
              Expanded(
                child: EmptyProductsCard(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

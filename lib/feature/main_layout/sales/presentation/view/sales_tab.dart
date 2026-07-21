import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m_store_1/core/costants/color_manager.dart';
import 'package:m_store_1/feature/main_layout/sales/data/cubit/sales_cubit.dart';
import 'package:m_store_1/feature/main_layout/sales/data/cubit/sales_state.dart';
import 'package:m_store_1/feature/main_layout/sales/presentation/widgets/sold_product_card.dart';
import 'package:m_store_1/feature/product_details/presentation/view/product_details.dart';
import 'package:m_store_1/l10n/app_localizations.dart';

class SalesTab extends StatefulWidget {
  const SalesTab({super.key});

  @override
  State<SalesTab> createState() => _SalesTabState();
}

class _SalesTabState extends State<SalesTab> {
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      SalesCubit.get(context).loadSales();
    });
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final cubit = SalesCubit.get(context);
    return BlocBuilder<SalesCubit, SalesState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: REdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    appLocalizations.soldProducts,
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 26.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  TextField(
                    controller: searchController,
                    onChanged: cubit.search,
                    decoration: InputDecoration(
                      hintText: "${appLocalizations.search_by_ID_Name_Buyers_or_Category}...",
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(vertical: 10.h),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  if (state is SalesLoading)
                    const Expanded(
                      child: Center(child: CircularProgressIndicator()),
                    )
                  else if (cubit.filteredProducts.isEmpty)
                    Expanded(
                      child: Center(
                        child: Text(
                          searchController.text.isEmpty
                              ? appLocalizations.noSoldProducts
                              : appLocalizations.no_matching_products_found,
                        ),
                      ),
                    )
                  else
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: cubit.loadSales,
                        child: ListView.separated(
                          itemCount: cubit.filteredProducts.length,
                          separatorBuilder: (_, __) => SizedBox(height: 18.h),
                          itemBuilder: (context, index) {
                            final product = cubit.filteredProducts[index];
                            return SoldProductCard(
                              product: product,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        ProductDetails(product: product),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

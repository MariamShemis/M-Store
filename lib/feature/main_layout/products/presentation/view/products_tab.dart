import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m_store_1/core/costants/color_manager.dart';
import 'package:m_store_1/core/routes/app_routes.dart';
import 'package:m_store_1/core/services/firebase_auth_services.dart';
import 'package:m_store_1/core/services/products_firebase_service.dart';
import 'package:m_store_1/feature/main_layout/products/data/model/product_model.dart';
import 'package:m_store_1/feature/main_layout/products/presentation/widgets/empty_products_card.dart';
import 'package:m_store_1/feature/main_layout/products/presentation/widgets/product_card.dart';
import 'package:m_store_1/l10n/app_localizations.dart';

class ProductsTab extends StatefulWidget {
  const ProductsTab({super.key});

  @override
  State<ProductsTab> createState() => _ProductsTabState();
}

class _ProductsTabState extends State<ProductsTab> {
  final TextEditingController _searchController = TextEditingController();

  String _search = "";

  ProductFilter _filter = ProductFilter.all;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.addProduct);
        },
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
                  // SizedBox(height: 6.h),
                  // Text(
                  //   appLocalizations.manage_and_organize_your_store_products,
                  //   style: textTheme.bodySmall,
                  // ),
                ],
              ),
              Expanded(
                child: StreamBuilder(
                  stream: ProductsFirebaseServices.productsStream(
                    FirebaseAuthServices.currentUserId()!,
                  ),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final products = snapshot.data!.docs.toList();

                    products.sort((a, b) {
                      final first = int.tryParse(a.data().productNumber) ?? 0;
                      final second = int.tryParse(b.data().productNumber) ?? 0;

                      return first.compareTo(second);
                    });
                    final filteredProducts = products.where((doc) {
                      final product = doc.data();
                      final matchesSearch =
                          product.productName.toLowerCase().contains(_search) ||
                              product.productNumber.toLowerCase().contains(_search) ||
                              product.category.toLowerCase().contains(_search);

                      final matchesFilter = switch (_filter) {
                        ProductFilter.all => true,
                        ProductFilter.available => !product.isSold,
                        ProductFilter.sold => product.isSold,
                      };

                      return matchesSearch && matchesFilter;
                    }).toList();
                    if (products.isEmpty) {
                      return Column(
                        children: [
                          SizedBox(height: 40.h),
                          const EmptyProductsCard(),
                        ],
                      );
                    }
                    return Column(
                      children: [
                        SizedBox(height: 10.h),
                        TextField(
                          controller: _searchController,
                          onChanged: (value) {
                            setState(() {
                              _search = value.trim().toLowerCase();
                            });
                          },
                          decoration: InputDecoration(
                            hintText:
                            "${appLocalizations.search_by_ID_Name_or_Category}...",
                            prefixIcon: const Icon(Icons.search),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.symmetric(vertical: 10.h),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18.r),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _filterChip(
                                title: appLocalizations.all,
                                selected: _filter == ProductFilter.all,
                                onTap: () {
                                  setState(() {
                                    _filter = ProductFilter.all;
                                  });
                                },
                              ),
                              SizedBox(width: 10.w),
                              _filterChip(
                                title: appLocalizations.available,
                                selected: _filter == ProductFilter.available,
                                onTap: () {
                                  setState(() {
                                    _filter = ProductFilter.available;
                                  });
                                },
                              ),
                              SizedBox(width: 10.w),
                              _filterChip(
                                title: appLocalizations.sold,
                                selected: _filter == ProductFilter.sold,
                                onTap: () {
                                  setState(() {
                                    _filter = ProductFilter.sold;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Expanded(
                          child: filteredProducts.isEmpty
                              ? Center(
                            child: Text(
                              appLocalizations.product_not_found,
                              style: GoogleFonts.manrope(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                                color: ColorManager.greyDark,
                              ),
                            ),
                          )
                              :  ListView.builder(
                            itemCount: filteredProducts.length,
                            itemBuilder: (context, index) {
                              final currentProduct = filteredProducts[index].data();
                              return ProductCard(
                                product: currentProduct,
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.productDetails,
                                    arguments: currentProduct,
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _filterChip({required String title, required bool selected , required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: REdgeInsets.symmetric(horizontal: 22, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? const Color(0xffD4AF37) : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          title,
          style: GoogleFonts.manrope(
            fontSize: 13.sp,
            color: selected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

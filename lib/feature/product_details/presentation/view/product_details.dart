import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:m_store_1/core/costants/color_manager.dart';
import 'package:m_store_1/core/services/firebase_auth_services.dart';
import 'package:m_store_1/core/services/products_firebase_service.dart';
import 'package:m_store_1/core/utils/ui_utils.dart';
import 'package:m_store_1/feature/add_product/data/cubit/add_product_cubit.dart';
import 'package:m_store_1/feature/add_product/presentation/view/add_product.dart';
import 'package:m_store_1/feature/main_layout/products/data/model/product_model.dart';
import 'package:m_store_1/feature/product_details/data/cubit/product_details_cubit.dart';
import 'package:m_store_1/feature/product_details/data/cubit/product_details_state.dart';
import 'package:m_store_1/feature/product_details/presentation/widgets/buyer_info_card.dart';
import 'package:m_store_1/feature/product_details/presentation/widgets/product_action_buttons.dart';
import 'package:m_store_1/feature/product_details/presentation/widgets/product_header_section.dart';
import 'package:m_store_1/feature/product_details/presentation/widgets/product_images_preview.dart';
import 'package:m_store_1/feature/product_details/presentation/widgets/product_info_card.dart';
import 'package:m_store_1/feature/product_details/presentation/widgets/sell_product_bottom_sheet.dart';
import 'package:m_store_1/l10n/app_localizations.dart';

class ProductDetails extends StatelessWidget {
  final ProductModel product;

  const ProductDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    return BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
      listener: (context, state) {
        if (state is ProductDetailsLoading) {
          UiUtils.showLoading(context, isDismissible: false);
        }
        if (state is ProductDetailsDeleted) {
          UiUtils.hideLoading(context);
          UiUtils.showToast("${appLocalizations.productDeletedSuccessfully}.");
          Navigator.pop(context);
        }

        if (state is ProductDetailsError) {
          UiUtils.hideLoading(context);
          UiUtils.showError(context, state.message);
        }
      },
      builder: (context, state) {

        return Scaffold(
          appBar: AppBar(
            title: Text(appLocalizations.productDetails, style: textTheme.titleMedium),
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
            ),
          ),
          body: StreamBuilder<ProductModel>(
            stream: ProductsFirebaseServices.productStream(
              FirebaseAuthServices.currentUserId()!,
              product.id,
            ),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              final currentProduct = snapshot.data!;

              return SingleChildScrollView(
                padding: REdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProductImagesPreview(product: currentProduct),
                    SizedBox(height: 24.h),
                    ProductHeaderSection(product: currentProduct),
                    SizedBox(height: 24.h),
                    ProductInfoCard(product: currentProduct),
                    SizedBox(height: 24.h),
                    if (currentProduct.isSold &&
                        currentProduct.buyers.isNotEmpty) ...[
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: currentProduct.buyers.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: 16.h),
                            child: BuyerInfoCard(
                              buyerData: currentProduct.buyers[index],
                              buyerNumber: index + 1,
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 8.h),
                    ],
                    ProductActionButtons(
                      isSold: currentProduct.isSold,
                      onSell: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (_) {
                            return SellProductBottomSheet(
                              product: currentProduct,
                              onSave: (name, phone, address, quantity) {
                                if (quantity >
                                    currentProduct.availableQuantity) {
                                  UiUtils.showToast(
                                    appLocalizations.quantity_is_greater_than_available_quantity,
                                  );
                                  return;
                                }

                                ProductDetailsCubit.get(context).sellProduct(
                                  product: currentProduct,
                                  quantity: quantity,
                                  buyers: [
                                    {
                                      "id": DateTime.now()
                                          .millisecondsSinceEpoch
                                          .toString(),
                                      "name": name,
                                      "phone": phone,
                                      "address": address,
                                      "quantity": quantity,
                                      "purchaseDate": DateTime.now(),
                                    },
                                  ],
                                );
                                Navigator.pop(context);
                              },
                            );
                          },
                        );
                      },
                      onEdit: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BlocProvider.value(
                              value: AddProductCubit.get(context),
                              child: AddProduct(product: currentProduct),
                            ),
                          ),
                        );
                      },
                      onDelete: () {
                        showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              title: Text(appLocalizations.deleteProduct),
                              content:  Text(
                                appLocalizations.are_you_sure_you_want_to_delete_this_product_
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(appLocalizations.cancel),
                                ),
                                state is ProductDetailsLoading
                                    ? CircularProgressIndicator(color: ColorManager.primaryColor,)
                                    : TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          ProductDetailsCubit.get(
                                            context,
                                          ).deleteProduct(currentProduct.id);
                                        },
                                        child: Text(
                                          appLocalizations.delete,
                                          style: TextStyle(
                                            color: ColorManager.red,
                                          ),
                                        ),
                                      ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    SizedBox(height: 40.h),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}

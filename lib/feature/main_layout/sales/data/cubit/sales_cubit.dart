import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_store_1/core/services/firebase_auth_services.dart';
import 'package:m_store_1/core/services/products_firebase_service.dart';
import 'package:m_store_1/feature/main_layout/products/data/model/product_model.dart';

import 'sales_state.dart';

class SalesCubit extends Cubit<SalesState> {
  SalesCubit() : super(SalesInitial());

  static SalesCubit get(context) => BlocProvider.of(context);

  List<ProductModel> allProducts = [];

  List<ProductModel> filteredProducts = [];
  String searchText = "";

  Future<void> loadSales() async {
    emit(SalesLoading());

    try {
      final uid = FirebaseAuthServices.currentUserId()!;

      allProducts = await ProductsFirebaseServices.getProducts(uid);

      allProducts =
          allProducts.where((e) => e.buyers.isNotEmpty).toList();

      applyFilter();

      emit(SalesSuccess());
    } catch (e) {
      emit(SalesError(e.toString()));
    }
  }

  void search(String value) {
    searchText = value.toLowerCase();

    applyFilter();

    emit(SalesSuccess());
  }

  void applyFilter() {
    List<ProductModel> result = List.from(allProducts);

    if (searchText.isNotEmpty) {
      result = result.where((product) {
        final productName = product.productName.toLowerCase();
        final productNumber = product.productNumber.toLowerCase();
        final category = product.category.toLowerCase();

        final hasBuyer = product.buyers.any((buyer) {
          final buyerName =
          (buyer["name"] ?? "").toString().toLowerCase();

          return buyerName.contains(searchText);
        });

        return productName.contains(searchText) ||
            productNumber.contains(searchText) ||
            category.contains(searchText) ||
            hasBuyer;
      }).toList();
    }

    filteredProducts = result;
  }
}
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_store_1/core/services/firebase_auth_services.dart';
import 'package:m_store_1/core/services/products_firebase_service.dart';
import 'package:m_store_1/feature/main_layout/products/data/model/product_model.dart';
import 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitial());

  static ProductDetailsCubit get(context) => BlocProvider.of(context);

  Future<void> deleteProduct(String productId) async {
    emit(ProductDetailsLoading());

    try {
      await ProductsFirebaseServices.deleteProduct(
        uid: FirebaseAuthServices.currentUserId()!,
        productId: productId,
      );

      emit(ProductDetailsDeleted());
    } catch (e) {
      emit(ProductDetailsError(e.toString()));
    }
  }

  Future<void> updateProduct(ProductModel product) async {
    emit(ProductDetailsLoading());

    try {
      await ProductsFirebaseServices.updateProduct(
        uid: FirebaseAuthServices.currentUserId()!,
        product: product,
      );

      emit(ProductDetailsSuccess());
    } catch (e) {
      emit(ProductDetailsError(e.toString()));
    }
  }

  Future<void> sellProduct({
    required ProductModel product,
    required int quantity,
    required List<Map<String, dynamic>> buyers,
  }) async {
    emit(ProductDetailsLoading());

    try {
      await ProductsFirebaseServices.sellProduct(
        uid: FirebaseAuthServices.currentUserId()!,
        productId: product.id,
        quantity: quantity,
        buyers: buyers,
      );

      emit(ProductDetailsSuccess());
    } catch (e) {
      emit(ProductDetailsError(e.toString()));
    }
  }
}
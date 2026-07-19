import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_store_1/core/services/cloudinary_services.dart';
import 'package:m_store_1/core/services/firebase_auth_services.dart';
import 'package:m_store_1/core/services/products_firebase_service.dart';
import 'package:m_store_1/feature/main_layout/products/data/model/product_model.dart';

import 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  AddProductCubit() : super(AddProductInitialState());

  static AddProductCubit get(context) => BlocProvider.of(context);

  Future<void> addProduct({
    required ProductModel product,
    required File mainImage,
    required List<File> images,
  }) async {
    emit(AddProductLoadingState());

    try {
      final uid = FirebaseAuthServices.currentUserId();

      if (uid == null) {
        throw Exception("User not found");
      }
      final mainImageUrl =
      await CloudinaryServices.uploadImage(mainImage);

      final imagesUrl =
      await CloudinaryServices.uploadImages(images);

      product.mainImage = mainImageUrl;
      product.images = imagesUrl;

      await ProductsFirebaseServices.addProduct(
        uid: uid,
        product: product,
      );

      emit(AddProductSuccessState());
    } catch (e) {
      emit(AddProductErrorState(e.toString()));
    }
  }

  Future<void> updateProduct({
    required ProductModel product,
    File? mainImage,
    List<File>? images,
    List<String>? oldImages,
  }) async {
    emit(AddProductLoadingState());

    try {
      if (mainImage != null) {
        product.mainImage =
        await CloudinaryServices.uploadImage(mainImage);
      }
      final uploadedImages = <String>[];
      if (images != null && images.isNotEmpty) {
        uploadedImages.addAll(
          await CloudinaryServices.uploadImages(images),
        );
      }
      product.updatedAt = DateTime.now();

      product.images = [
        ...?oldImages,
        ...uploadedImages,
      ];

      await ProductsFirebaseServices.updateProduct(
        uid: FirebaseAuthServices.currentUserId()!,
        product: product,
      );

      emit(AddProductSuccessState());
    } catch (e) {
      emit(AddProductErrorState(e.toString()));
    }
  }
}
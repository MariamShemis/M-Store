import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_store_1/core/services/firebase_auth_services.dart';
import 'package:m_store_1/core/services/products_firebase_service.dart';
import 'package:m_store_1/feature/main_layout/home/data/cubit/home_state.dart';
import 'package:m_store_1/feature/main_layout/home/data/model/home_model.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  HomeModel? homeModel;

  String userName = "";
  String? userImage;

  StreamSubscription? _productsSubscription;

  Future<void> loadHome() async {
    emit(HomeLoading());

    try {
      final user = await FirebaseAuthServices.getCurrentUser();

      userName = user.name;
      userImage = user.image;

      final uid = FirebaseAuthServices.currentUserId()!;

      await _productsSubscription?.cancel();

      _productsSubscription =
          ProductsFirebaseServices.productsStream(uid).listen((snapshot) {
            final products = snapshot.docs.map((e) => e.data()).toList();

            final dashboard =
            ProductsFirebaseServices.buildDashboard(products);

            final categories =
            ProductsFirebaseServices.buildCategoryStatistics(products);

            homeModel = HomeModel(
              dashboard: dashboard,
              topCategories: categories,
              userName: userName,
              userImage: userImage,
            );

            emit(HomeSuccess(homeModel!));
          });
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _productsSubscription?.cancel();
    return super.close();
  }
}

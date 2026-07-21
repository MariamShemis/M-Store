import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_store_1/core/services/firebase_auth_services.dart';
import 'package:m_store_1/core/services/products_firebase_service.dart';
import 'package:m_store_1/feature/main_layout/home/data/cubit/home_state.dart';
import 'package:m_store_1/feature/main_layout/home/data/model/category_statistics_model.dart';
import 'package:m_store_1/feature/main_layout/home/data/model/home_model.dart';
import 'package:m_store_1/feature/main_layout/home/data/model/dashboard_model.dart';
import 'package:m_store_1/feature/main_layout/products/data/model/product_model.dart';

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

            final dashboard = _buildDashboard(products);

            final categories = _buildCategories(products);

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

  DashboardModel _buildDashboard(List<ProductModel> products) {
    final int totalProducts = products.length;

    int availableProducts = 0;
    int soldProducts = 0;

    double totalSales = 0;
    double totalProfit = 0;

    for (final product in products) {
      if (product.isSold) {
        soldProducts++;
      } else {
        availableProducts++;
      }

      totalSales += product.sellingPrice * product.soldQuantity;

      totalProfit += product.profit;
    }

    return DashboardModel(
      totalProducts: totalProducts,
      availableProducts: availableProducts,
      soldProducts: soldProducts,
      totalSales: totalSales,
      totalProfit: totalProfit,
    );
  }

  List<CategoryStatisticsModel> _buildCategories(
      List<ProductModel> products,
      ) {
    final Map<String, int> categories = {};

    for (final product in products) {
      categories[product.category] =
          (categories[product.category] ?? 0) + 1;
    }

    final list = categories.entries
        .map(
          (e) => CategoryStatisticsModel(
        category: e.key,
        productsCount: e.value,
        percentage: products.isEmpty
            ? 0
            : e.value / products.length,
      ),
    )
        .toList();

    list.sort(
          (a, b) => b.productsCount.compareTo(a.productsCount),
    );

    return list;
  }

  @override
  Future<void> close() {
    _productsSubscription?.cancel();
    return super.close();
  }
}
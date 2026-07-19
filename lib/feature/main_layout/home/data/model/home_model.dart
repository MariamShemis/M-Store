import 'package:m_store_1/feature/main_layout/home/data/model/category_statistics_model.dart';
import 'package:m_store_1/feature/main_layout/home/data/model/dashboard_model.dart';

class HomeModel {
  final String userName;

  final String? userImage;

  final DashboardModel dashboard;

  final List<CategoryStatisticsModel> topCategories;

  HomeModel({
    required this.userName,
    required this.userImage,
    required this.dashboard,
    required this.topCategories,
  });
}
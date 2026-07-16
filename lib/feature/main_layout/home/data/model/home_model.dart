import 'package:m_store_1/feature/main_layout/home/data/model/category_statistics_model.dart';
import 'package:m_store_1/feature/main_layout/home/data/model/dashboard_model.dart';

import 'chart_model.dart';

class HomeModel {
  final DashboardModel dashboard;

  final List<CategoryStatisticsModel> topCategories;

  final List<ChartModel> revenueChart;

  HomeModel({
    required this.dashboard,
    required this.topCategories,
    required this.revenueChart,
  });
}
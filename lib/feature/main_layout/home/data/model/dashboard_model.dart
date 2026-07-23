class DashboardModel {
  final int totalProducts;

  final int availableProducts;
  final int soldProducts;

  final int availableItems;
  final int soldItems;

  final double totalProductsPrice;
  final double totalInventoryValue;
  final double totalSales;
  final double totalProfit;

  DashboardModel({
    required this.totalProducts,
    required this.availableProducts,
    required this.soldProducts,
    required this.availableItems,
    required this.soldItems,
    required this.totalProductsPrice,
    required this.totalInventoryValue,
    required this.totalSales,
    required this.totalProfit,
  });
}
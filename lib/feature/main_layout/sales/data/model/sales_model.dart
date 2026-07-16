class SaleModel {
  static const String collectionName = "sales";

  String id;

  String productId;
  String productNumber;
  String productName;

  String category;

  String buyerName;
  String buyerPhone;
  String buyerAddress;

  int quantity;

  double purchasePrice;
  double sellingPrice;

  double totalSales;
  double totalProfit;

  DateTime saleDate;

  SaleModel({
    required this.id,
    required this.productId,
    required this.productNumber,
    required this.productName,
    required this.category,
    required this.buyerName,
    required this.buyerPhone,
    required this.buyerAddress,
    required this.quantity,
    required this.purchasePrice,
    required this.sellingPrice,
    required this.totalSales,
    required this.totalProfit,
    required this.saleDate,
  });
}
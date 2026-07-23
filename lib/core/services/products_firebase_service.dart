import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:m_store_1/feature/main_layout/home/data/model/category_statistics_model.dart';
import 'package:m_store_1/feature/main_layout/home/data/model/dashboard_model.dart';
import 'package:m_store_1/feature/main_layout/products/data/model/product_model.dart';

class ProductsFirebaseServices {
  ProductsFirebaseServices._();

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ///==========================
  /// User Document
  ///==========================

  static DocumentReference<Map<String, dynamic>> _userDoc(String uid) {
    return _firestore.collection("users").doc(uid);
  }

  ///==========================
  /// Products Collection
  ///==========================

  static CollectionReference<ProductModel> getProductsCollection(String uid) {
    return _userDoc(uid)
        .collection(ProductModel.collectionName)
        .withConverter<ProductModel>(
          fromFirestore: (snapshot, _) =>
              ProductModel.fromJson(snapshot.data()!),
          toFirestore: (product, _) => product.toJson(),
        );
  }

  ///==========================
  /// Add Product
  ///==========================

  static Future<void> addProduct({
    required String uid,
    required ProductModel product,
  }) async {
    final doc = getProductsCollection(uid).doc();

    product.id = doc.id;

    await doc.set(product);
  }

  ///==========================
  /// Update Product
  ///==========================

  static Future<void> updateProduct({
    required String uid,
    required ProductModel product,
  }) async {
    await getProductsCollection(uid).doc(product.id).update(product.toJson());
  }

  ///==========================
  /// Delete Product
  ///==========================

  static Future<void> deleteProduct({
    required String uid,
    required String productId,
  }) async {
    await getProductsCollection(uid).doc(productId).delete();
  }

  ///==========================
  /// Get Product
  ///==========================

  static Future<ProductModel?> getProduct({
    required String uid,
    required String productId,
  }) async {
    final doc = await getProductsCollection(uid).doc(productId).get();

    return doc.data();
  }

  ///==========================
  /// Products Stream
  ///==========================

  static Stream<QuerySnapshot<ProductModel>> productsStream(String uid) {
    return getProductsCollection(
      uid,
    ).orderBy("createdAt", descending: true).snapshots();
  }

  ///==========================
  /// Get Products Once
  ///==========================

  static Future<List<ProductModel>> getProducts(String uid) async {
    final snapshot = await getProductsCollection(uid).get();

    return snapshot.docs.map((e) => e.data()).toList();
  }

  ///==========================
  /// Update Images
  ///==========================

  static Future<void> updateImages({
    required String uid,
    required String productId,
    required List<String> images,
  }) async {
    await getProductsCollection(uid).doc(productId).update({"images": images});
  }

  ///==========================
  /// Update Quantity
  ///==========================

  static Future<void> updateQuantity({
    required String uid,
    required String productId,
    required int quantity,
  }) async {
    await getProductsCollection(uid).doc(productId).update({
      "quantity": quantity,
      "availableQuantity": quantity,
    });
  }

  ///==========================
  /// Increase Quantity
  ///==========================

  static Future<void> increaseQuantity({
    required String uid,
    required String productId,
    required int amount,
  }) async {
    final product = await getProduct(uid: uid, productId: productId);

    if (product == null) return;

    await getProductsCollection(uid).doc(productId).update({
      "quantity": product.quantity + amount,
      "availableQuantity": product.availableQuantity + amount,
    });
  }

  ///==========================
  /// Decrease Quantity
  ///==========================

  static Future<void> decreaseQuantity({
    required String uid,
    required String productId,
    required int amount,
  }) async {
    final product = await getProduct(uid: uid, productId: productId);

    if (product == null) return;

    await getProductsCollection(uid).doc(productId).update({
      "quantity": product.quantity - amount,
      "availableQuantity": product.availableQuantity - amount,
    });
  }

  static Stream<List<ProductModel>> soldProductsStream(String uid) {
    return getProductsCollection(uid)
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((e) => e.data())
              .where((product) => product.buyers.isNotEmpty)
              .toList(),
        );
  }

  ///==========================
  /// Search By Product Number
  ///==========================

  static Future<List<ProductModel>> searchByProductNumber({
    required String uid,
    required String productNumber,
  }) async {
    final snapshot = await getProductsCollection(
      uid,
    ).where("productNumber", isEqualTo: productNumber).get();

    return snapshot.docs.map((e) => e.data()).toList();
  }

  ///==========================
  /// Search By Category
  ///==========================

  static Future<List<ProductModel>> searchByCategory({
    required String uid,
    required String category,
  }) async {
    final snapshot = await getProductsCollection(
      uid,
    ).where("category", isEqualTo: category).get();

    return snapshot.docs.map((e) => e.data()).toList();
  }

  ///==========================
  /// Search By Material
  ///==========================

  static Future<List<ProductModel>> searchByMaterial({
    required String uid,
    required String material,
  }) async {
    final snapshot = await getProductsCollection(
      uid,
    ).where("material", isEqualTo: material).get();

    return snapshot.docs.map((e) => e.data()).toList();
  }

  ///==========================
  /// Search By Color
  ///==========================

  static Future<List<ProductModel>> searchByColor({
    required String uid,
    required String color,
  }) async {
    final snapshot = await getProductsCollection(
      uid,
    ).where("color", isEqualTo: color).get();

    return snapshot.docs.map((e) => e.data()).toList();
  }

  ///==========================
  /// Search By Name
  ///==========================

  static Future<List<ProductModel>> searchByName({
    required String uid,
    required String name,
  }) async {
    final snapshot = await getProductsCollection(uid).get();

    return snapshot.docs
        .map((e) => e.data())
        .where(
          (product) =>
              product.productName.toLowerCase().contains(name.toLowerCase()),
        )
        .toList();
  }

  ///==========================
  /// Dashboard
  ///==========================

  static DashboardModel buildDashboard(List<ProductModel> products) {
    final totalProducts = products.length;

    int availableProducts = 0;
    int soldProducts = 0;

    int availableItems = 0;
    int soldItems = 0;

    double totalProductsPrice = 0;
    double totalInventoryValue = 0;
    double totalSales = 0;
    double totalProfit = 0;

    for (final product in products) {
      if (product.availableQuantity > 0) {
        availableProducts++;
      }

      if (product.soldQuantity > 0) {
        soldProducts++;
      }

      availableItems += product.availableQuantity;
      soldItems += product.soldQuantity;

      totalProductsPrice += product.purchasePrice;

      totalInventoryValue += product.purchasePrice * product.availableQuantity;

      totalSales += product.totalSellingPrice;

      totalProfit += product.totalProfit;
    }

    return DashboardModel(
      totalProducts: totalProducts,
      availableProducts: availableProducts,
      soldProducts: soldProducts,
      availableItems: availableItems,
      soldItems: soldItems,
      totalProductsPrice: totalProductsPrice,
      totalInventoryValue: totalInventoryValue,
      totalSales: totalSales,
      totalProfit: totalProfit,
    );
  }

  static List<CategoryStatisticsModel> buildCategoryStatistics(
    List<ProductModel> products,
  ) {
    final Map<String, int> categories = {};

    for (final product in products) {
      categories[product.category] = (categories[product.category] ?? 0) + 1;
    }

    final list = categories.entries
        .map(
          (e) => CategoryStatisticsModel(
            category: e.key,
            productsCount: e.value,
            percentage: products.isEmpty ? 0 : e.value / products.length,
          ),
        )
        .toList();

    list.sort((a, b) => b.productsCount.compareTo(a.productsCount));

    return list;
  }

  static Stream<ProductModel> productStream(String uid, String productId) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("products")
        .doc(productId)
        .snapshots()
        .map((doc) => ProductModel.fromJson(doc.data()!));
  }
}

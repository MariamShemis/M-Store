import 'package:cloud_firestore/cloud_firestore.dart';
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

  ///==========================
  /// Sell Product
  ///==========================

  static Future<void> sellProduct({
    required String uid,
    required String productId,
    required int quantity,
  }) async {
    final product = await getProduct(uid: uid, productId: productId);

    if (product == null) return;

    await getProductsCollection(uid).doc(productId).update({
      "soldQuantity": product.soldQuantity + quantity,
      "availableQuantity": product.availableQuantity - quantity,
    });
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

  static Future<DashboardModel> getDashboardData(String uid) async {
    final products = await getProducts(uid);

    int totalProducts = products.length;

    int available = 0;

    int sold = 0;

    double sales = 0;

    double profit = 0;

    for (final product in products) {
      available += product.availableQuantity;

      sold += product.soldQuantity;

      sales += product.sellingPrice * product.soldQuantity;

      profit +=
          (product.sellingPrice - product.purchasePrice) * product.soldQuantity;
    }

    return DashboardModel(
      totalProducts: totalProducts,
      availableProducts: available,
      soldProducts: sold,
      totalSales: sales,
      totalProfit: profit,
    );
  }
}

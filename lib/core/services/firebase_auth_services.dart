import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:m_store_1/feature/auth/data/model/login_request.dart';
import 'package:m_store_1/feature/auth/data/model/register_request.dart';
import 'package:m_store_1/feature/auth/data/model/user_model.dart';

class FirebaseAuthServices {
  FirebaseAuthServices._();

  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Register
  static Future<UserCredential> register(RegisterRequest request) async {
    UserCredential credential = await _auth.createUserWithEmailAndPassword(
      email: request.email,
      password: request.password,
    );

    UserModel user = UserModel(
      id: credential.user!.uid,
      name: request.name,
      email: request.email,
      phone: request.phone,
      createdAt: DateTime.now(),
    );

    await addUserToFirestore(user);

    return credential;
  }

  /// Login
  static Future<UserCredential> login(LoginRequest request) async {
    return await _auth.signInWithEmailAndPassword(
      email: request.email,
      password: request.password,
    );
  }

  /// Logout
  static Future<void> logout() async {
    await _auth.signOut();
  }

  /// Reset Password
  static Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  /// Current Firebase User
  static User? currentFirebaseUser() {
    return _auth.currentUser;
  }

  /// Current UID
  static String? currentUserId() {
    return _auth.currentUser?.uid;
  }

  /// Users Collection
  static CollectionReference<UserModel> getUsersCollection() {
    return _firestore
        .collection(UserModel.collectionName)
        .withConverter<UserModel>(
          fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
          toFirestore: (user, _) => user.toJson(),
        );
  }

  /// Add User
  static Future<void> addUserToFirestore(UserModel user) async {
    await getUsersCollection().doc(user.id).set(user);
  }

  /// Get User
  static Future<UserModel?> getUser(String uid) async {
    final doc = await getUsersCollection().doc(uid).get();

    return doc.data();
  }

  /// Get Current User
  static Future<UserModel> getCurrentUser() async {
    User? firebaseUser = _auth.currentUser;

    print("Firebase User: ${firebaseUser?.uid}");

    if (firebaseUser == null) {
      throw Exception("No user logged in");
    }

    final doc = await getUsersCollection().doc(firebaseUser.uid).get();

    print("Document Exists: ${doc.exists}");
    print("Data: ${doc.data()?.toJson()}");

    if (!doc.exists || doc.data() == null) {
      throw Exception("User not found");
    }

    return doc.data()!;
  }

  /// Update User
  static Future<void> updateUser(UserModel user) async {
    await getUsersCollection().doc(user.id).update(user.toJson());
  }

  /// Delete User
  static Future<void> deleteUser(String uid) async {
    await getUsersCollection().doc(uid).delete();
  }

  static Future<void> updateCurrentUserName(String name) async {
    await _auth.currentUser?.updateDisplayName(name);
  }

  static Future<void> updateCurrentUserEmail(String email) async {
    final user = _auth.currentUser!;

    try {
      await user.verifyBeforeUpdateEmail(email);
      //await FirebaseAuth.instance.currentUser!.updateEmail(newEmail);

      print("Verification email sent");
    } on FirebaseAuthException catch (e) {
      print("Code: ${e.code}");
      print("Message: ${e.message}");
      rethrow;
    }
  }

  static Future<void> reauthenticate(String password) async {
    final user = FirebaseAuth.instance.currentUser!;

    final provider = user.providerData.first.providerId;

    if (provider == "password") {
      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: password,
      );

      await user.reauthenticateWithCredential(credential);
      return;
    }

    if (provider == "google.com") {
      final googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) return;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await user.reauthenticateWithCredential(credential);
    }
  }
}

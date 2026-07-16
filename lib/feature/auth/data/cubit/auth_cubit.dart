import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_store_1/core/services/firebase_auth_services.dart';
import 'package:m_store_1/feature/auth/data/model/login_request.dart';
import 'package:m_store_1/feature/auth/data/model/register_request.dart';
import 'package:m_store_1/feature/auth/data/model/user_model.dart';

import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());

  static AuthCubit get(context) => BlocProvider.of(context);

  UserModel? currentUser;

  ///==========================
  /// Register
  ///==========================

  Future<void> register(RegisterRequest request) async {
    emit(RegisterLoadingState());

    try {
      await FirebaseAuthServices.register(request);

      currentUser = await FirebaseAuthServices.getCurrentUser();

      emit(RegisterSuccessState());
    } on FirebaseAuthException catch (e) {
      emit(RegisterErrorState(e.message ?? "Register Failed"));
    } catch (e) {
      emit(RegisterErrorState(e.toString()));
    }
  }

  ///==========================
  /// Login
  ///==========================

  Future<void> login(LoginRequest request) async {
    emit(LoginLoadingState());

    try {
      await FirebaseAuthServices.login(request);

      currentUser = await FirebaseAuthServices.getCurrentUser();

      emit(LoginSuccessState(currentUser!));
    } on FirebaseAuthException catch (e) {
      emit(LoginErrorState(e.message ?? "Login Failed"));
    } catch (e) {
      emit(LoginErrorState(e.toString()));
    }
  }

  ///==========================
  /// Current User
  ///==========================

  Future<void> getCurrentUser() async {
    try {
      currentUser = await FirebaseAuthServices.getCurrentUser();
    } catch (_) {}
  }

  ///==========================
  /// Reset Password
  ///==========================

  Future<void> resetPassword(String email) async {
    emit(ResetPasswordLoadingState());

    try {
      await FirebaseAuthServices.resetPassword(email);

      emit(ResetPasswordSuccessState());
    } on FirebaseAuthException catch (e) {
      emit(ResetPasswordErrorState(e.message ?? "Failed"));
    } catch (e) {
      emit(ResetPasswordErrorState(e.toString()));
    }
  }

  ///==========================
  /// Logout
  ///==========================

  Future<void> logout() async {
    emit(LogoutLoadingState());

    try {
      await FirebaseAuthServices.logout();

      currentUser = null;

      emit(LogoutSuccessState());
    } on FirebaseAuthException catch (e) {
      emit(LogoutErrorState(e.message ?? "Logout Failed"));
    } catch (e) {
      emit(LogoutErrorState(e.toString()));
    }
  }

  String _firebaseErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return 'This email is already in use.';

      case 'invalid-email':
        return 'Please enter a valid email address.';

      case 'weak-password':
        return 'Password is too weak.';

      case 'user-not-found':
        return 'No account found with this email.';

      case 'wrong-password':
      case 'invalid-credential':
        return 'Incorrect email or password.';

      case 'network-request-failed':
        return 'Please check your internet connection.';

      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';

      default:
        return 'Something went wrong. Please try again.';
    }
  }
}

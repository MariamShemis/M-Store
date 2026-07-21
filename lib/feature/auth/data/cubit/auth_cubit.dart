import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_store_1/core/services/firebase_auth_services.dart';
import 'package:m_store_1/core/services/google_sign_in_services.dart';
import 'package:m_store_1/feature/auth/data/model/login_request.dart';
import 'package:m_store_1/feature/auth/data/model/register_request.dart';
import 'package:m_store_1/feature/auth/data/model/user_model.dart';
import 'package:m_store_1/l10n/app_localizations.dart';

import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());

  static AuthCubit get(context) => BlocProvider.of(context);

  UserModel? currentUser;

  Future<void> register(RegisterRequest request , BuildContext context) async {
    emit(RegisterLoadingState());

    try {
      await FirebaseAuthServices.register(request);

      currentUser = await FirebaseAuthServices.getCurrentUser();

      emit(RegisterSuccessState(currentUser!));
    } on FirebaseAuthException catch (e) {
      emit(RegisterErrorState(_firebaseErrorMessage(e , context)));
    } catch (e) {
      emit(RegisterErrorState(e.toString()));
    }
  }

  Future<void> login(LoginRequest request , BuildContext context) async {
    emit(LoginLoadingState());

    try {
      await FirebaseAuthServices.login(request);

      currentUser = await FirebaseAuthServices.getCurrentUser();

      emit(LoginSuccessState(currentUser!));
    } on FirebaseAuthException catch (e) {
      emit(LoginErrorState(_firebaseErrorMessage(e , context)));
    } catch (e) {
      emit(LoginErrorState(e.toString()));
    }
  }

  Future<void> getCurrentUser() async {
    try {
      currentUser = await FirebaseAuthServices.getCurrentUser();
    } catch (_) {}
  }

  Future<void> resetPassword(String email , BuildContext context) async {
    emit(ResetPasswordLoadingState());

    try {
      await FirebaseAuthServices.resetPassword(email);

      emit(ResetPasswordSuccessState());
    } on FirebaseAuthException catch (e) {
      emit(ResetPasswordErrorState(_firebaseErrorMessage(e , context)));
    } catch (e) {
      emit(ResetPasswordErrorState(e.toString()));
    }
  }

  Future<void> logout(BuildContext context) async {
    emit(LogoutLoadingState());

    try {
      await FirebaseAuthServices.logout();

      currentUser = null;

      emit(LogoutSuccessState());
    } on FirebaseAuthException catch (e) {
      emit(LogoutErrorState(_firebaseErrorMessage(e , context)));
    } catch (e) {
      emit(LogoutErrorState(e.toString()));
    }
  }

  String _firebaseErrorMessage(FirebaseAuthException e , BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    switch (e.code) {
      case 'email-already-in-use':
        return appLocalizations.this_email_is_already_in_use;

      case 'invalid-email':
        return appLocalizations.please_enter_a_valid_email_address;

      case 'weak-password':
        return appLocalizations.password_is_too_weak;

      case 'user-not-found':
        return appLocalizations.no_account_found_with_this_email;

      case 'wrong-password':
      case 'invalid-credential':
        return appLocalizations.incorrect_email_or_password;

      case 'network-request-failed':
        return appLocalizations.please_check_your_internet_connection;

      case 'too-many-requests':
        return appLocalizations.too_many_attempts_Please_try_again_later;

      case 'google-sign-in-cancelled':
        return appLocalizations.google_sign_in_was_cancelled;

      default:
        return appLocalizations.something_went_wrong_Please_try_again;
    }
  }

  Future<void> loginWithGoogle(BuildContext context) async {
    emit(LoginLoadingState());

    try {
      final credential = await GoogleSignInServices.signIn();

      final firebaseUser = credential.user!;

      UserModel? user = await FirebaseAuthServices.getUser(firebaseUser.uid);

      if (user == null) {
        user = UserModel(
          id: firebaseUser.uid,
          name: firebaseUser.displayName ?? "",
          email: firebaseUser.email ?? "",
          phone: firebaseUser.phoneNumber ?? "",
          image: firebaseUser.photoURL,
          createdAt: DateTime.now(),
        );

        await FirebaseAuthServices.addUserToFirestore(user);
      }

      currentUser = user;

      emit(LoginSuccessState(user));
    } on FirebaseAuthException catch (e) {
      emit(LoginErrorState(_firebaseErrorMessage(e , context)));
    } catch (e) {
      emit(LoginErrorState(e.toString()));
    }
  }
}

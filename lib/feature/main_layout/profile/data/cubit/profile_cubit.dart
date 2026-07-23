import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_store_1/core/services/firebase_auth_services.dart';
import 'package:m_store_1/core/services/google_sign_in_services.dart';
import 'package:m_store_1/feature/auth/data/model/user_model.dart';

import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitialState());

  static ProfileCubit get(context) => BlocProvider.of(context);

  UserModel? currentUser;

  Future<void> loadProfile() async {
    emit(GetProfileLoadingState());

    try {
      final user = await FirebaseAuthServices.getCurrentUser();

      currentUser = user;

      emit(GetProfileSuccessState(user));
    } catch (e) {
      emit(GetProfileErrorState(e.toString()));
    }
  }

  Future<void> logout() async {
    emit(LogoutLoadingState());

    try {
      final providerId = FirebaseAuthServices
          .currentFirebaseUser()
          ?.providerData
          .first
          .providerId;

      if (providerId == "google.com") {
        await GoogleSignInServices.signOut();
      } else {
        await FirebaseAuthServices.logout();
      }

      currentUser = null;

      emit(LogoutSuccessState());
    } catch (e) {
      emit(LogoutErrorState(e.toString()));
    }
  }
}
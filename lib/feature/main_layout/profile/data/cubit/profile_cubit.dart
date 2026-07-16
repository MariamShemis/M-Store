import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_store_1/core/services/firebase_auth_services.dart';
import 'package:m_store_1/feature/auth/data/model/user_model.dart';

import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitialState());

  static ProfileCubit get(context) => BlocProvider.of(context);

  UserModel? currentUser;

  Future<void> loadProfile() async {
    emit(GetProfileLoadingState());

    try {
      currentUser = await FirebaseAuthServices.getCurrentUser();

      emit(GetProfileSuccessState(currentUser!));
    } catch (e) {
      emit(GetProfileErrorState(e.toString()));
    }
  }

  Future<void> logout() async {
    emit(LogoutLoadingState());

    try {
      await FirebaseAuthServices.logout();

      currentUser = null;

      emit(LogoutSuccessState());
    } catch (e) {
      emit(LogoutErrorState(e.toString()));
    }
  }
}
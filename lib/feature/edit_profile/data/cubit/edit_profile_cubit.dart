import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_store_1/core/services/cloudinary_services.dart';
import 'package:m_store_1/core/services/firebase_auth_services.dart';
import 'package:m_store_1/feature/auth/data/model/user_model.dart';

import 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(EditProfileInitial());

  UserModel? user;

  Future<void> loadProfile() async {
    emit(EditProfileLoading());

    try {
      user = await FirebaseAuthServices.getCurrentUser();

      emit(EditProfileLoaded());
    } catch (e) {
      emit(EditProfileError(e.toString()));
    }
  }

  Future<void> updateProfile({
    required String name,
    required String email,
    required String phone,
    required String birthday,
    required String gender,
    required String password,
    File? image,
  }) async {
    emit(EditProfileSaving());

    try {
      if (user == null) {
        throw Exception("User not found");
      }

      String? imageUrl = user!.image;

      if (image != null) {
        imageUrl = await CloudinaryServices.uploadImage(image);
      }
      await FirebaseAuth.instance.currentUser!.updateDisplayName(name);

      final updatedUser = user!.copyWith(
        name: name,
        email: email,
        phone: phone,
        birthday: birthday,
        gender: gender,
        image: imageUrl,
      );

      await FirebaseAuthServices.updateUser(updatedUser);
      await FirebaseAuthServices.updateCurrentUserName(name);

      if (email != user!.email) {
        await FirebaseAuthServices.reauthenticate(password);

        await FirebaseAuth.instance.currentUser!
            .verifyBeforeUpdateEmail(email);
      }

      user = updatedUser;

      emit(EditProfileSuccess());

      emit(EditProfileLoaded());
    } on FirebaseAuthException catch (e) {
      emit(EditProfileError("${e.code} : ${e.message}"));
    } catch (e) {
      emit(EditProfileError(e.toString()));
    }
  }
}

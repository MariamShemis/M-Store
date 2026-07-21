import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_store_1/feature/language/data/language_services/language_services.dart';
import 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit()
      : super(
    const LanguageState(
      locale: Locale('en'),
    ),
  );

  Future<void> loadLanguage() async {
    final languageCode = await LanguageService.getSavedLanguage();

    emit(
      LanguageState(
        locale: Locale(languageCode),
      ),
    );
  }

  Future<void> changeLanguage(String languageCode) async {
    final currentLanguage = state.locale.languageCode;

    if (currentLanguage == languageCode) return;

    final saved = await LanguageService.saveLanguage(languageCode);

    if (saved) {
      emit(
        LanguageState(
          locale: Locale(languageCode),
        ),
      );
    }
  }

  Future<void> resetLanguage() async {
    await LanguageService.clearLanguage();

    emit(
      const LanguageState(
        locale: Locale('en'),
      ),
    );
  }

  bool get isArabic => state.locale.languageCode == 'ar';

  bool get isEnglish => state.locale.languageCode == 'en';
}
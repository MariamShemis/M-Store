import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:m_store_1/l10n/app_localizations.dart';

import '../../data/cubit/language_cubit.dart';
import '../../data/cubit/language_state.dart';
import '../widgets/custom_language_card.dart';

class LanguageProfile extends StatefulWidget {
  const LanguageProfile({super.key});

  @override
  State<LanguageProfile> createState() => _LanguageProfileState();
}

class _LanguageProfileState extends State<LanguageProfile> {
  String selectedLang = "en";

  @override
  void initState() {
    super.initState();

    selectedLang = context.read<LanguageCubit>().state.locale.languageCode;
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<LanguageCubit, LanguageState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: Text(appLocalizations.selectLanguage)),
          body: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                Text(appLocalizations.choose_your_preferred_language_for_the_app_interface),
                SizedBox(height: 40.h),
                CustomLanguageCard(
                  title: "English",
                  subTitle: "Default Language",
                  languageCode: "en",
                  selectedLanguage: selectedLang,
                  onChanged: (value) {
                    setState(() {
                      selectedLang = value!;
                    });
                  },
                ),
                CustomLanguageCard(
                  title: "العربية",
                  subTitle: "Arabic",
                  languageCode: "ar",
                  selectedLanguage: selectedLang,

                  onChanged: (value) {
                    setState(() {
                      selectedLang = value!;
                    });
                  },
                ),

                SizedBox(height: 50.h),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      await context.read<LanguageCubit>().changeLanguage(
                        selectedLang,
                      );

                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    },

                    child: Text(appLocalizations.save),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

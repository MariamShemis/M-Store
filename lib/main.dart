import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_store_1/feature/add_product/data/cubit/add_product_cubit.dart';
import 'package:m_store_1/feature/auth/data/cubit/auth_cubit.dart';
import 'package:m_store_1/feature/edit_profile/data/cubit/edit_profile_cubit.dart';
import 'package:m_store_1/feature/main_layout/home/data/cubit/home_cubit.dart';
import 'package:m_store_1/feature/main_layout/profile/data/cubit/profile_cubit.dart';
import 'package:m_store_1/feature/main_layout/sales/data/cubit/sales_cubit.dart';
import 'package:m_store_1/feature/product_details/data/cubit/product_details_cubit.dart';
import 'package:m_store_1/firebase_options.dart';
import 'package:m_store_1/m_store.dart';
import 'feature/language/data/cubit/language_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthCubit()),
        BlocProvider(create: (_) => HomeCubit()),
        BlocProvider(create: (_) => SalesCubit()),
        BlocProvider(create: (_) => LanguageCubit()..loadLanguage()),
        BlocProvider(create: (_) => AddProductCubit()),
        BlocProvider(create: (_) => ProductDetailsCubit()),
        BlocProvider(create: (_) => EditProfileCubit()..loadProfile()),
        BlocProvider(create: (_) => ProfileCubit()..loadProfile()),
      ],
      child: MStore(),
    ),
  );
}

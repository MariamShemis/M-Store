import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_store_1/feature/auth/data/cubit/auth_cubit.dart';
import 'package:m_store_1/feature/main_layout/profile/data/cubit/profile_cubit.dart';
import 'package:m_store_1/firebase_options.dart';
import 'package:m_store_1/m_store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthCubit()),
        BlocProvider(create: (_) => ProfileCubit()..loadProfile()),
      ],
      child: MStore(),
    ),
  );
}

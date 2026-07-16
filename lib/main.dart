import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:m_store_1/firebase_options.dart';
import 'package:m_store_1/m_store.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MStore());
}


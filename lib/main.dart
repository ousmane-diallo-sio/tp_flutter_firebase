import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tp_flutter_firebase/app.dart';
import 'firebase_options.dart';

void main() {
  _initFirebase();
  runApp(const MyApp());
}

void _initFirebase() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
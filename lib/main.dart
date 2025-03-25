import 'package:identity/app.dart';
import 'package:flutter/material.dart';
import 'package:identity/services/getit.dart';
import 'package:identity/services/shared_pref.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPref.init();

  initializeSignal();
  runApp(const Application());
}

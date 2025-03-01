import 'package:identity/home.dart';
import 'package:flutter/material.dart';
import 'package:identity/services/getit.dart';
import 'package:signals/signals_flutter.dart';
import 'package:identity/constants/theme.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    final themer = getIt.get<Themer>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themer.state.watch(context),
      home: const Home(),
    );
  }
}
